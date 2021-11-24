//
//  RCChatroomSceneMessageCell.m
//  RCChatroomSceneKit
//
//  Created by shaoshuai on 2021/10/28.
//

#import <Masonry/Masonry.h>

#import "UILabel+Touch.h"
#import "RCChatroomSceneProtocol.h"
#import "RCChatroomSceneMessageCell.h"
#import "RCChatroomSceneBubbleLayer.h"

static NSString *kRCCSMCellIdentifier = @"RCChatroomSceneMessageCell";

@interface RCChatroomSceneMessageCell ()

@end

@implementation RCChatroomSceneMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.containerView];
        [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).with.inset(12);
            make.top.equalTo(self.contentView).with.inset(4);
            make.bottom.equalTo(self.contentView).with.inset(4);
            make.right.lessThanOrEqualTo(self.contentView).with.inset(12);
        }];
        
        [self.containerView.layer addSublayer:self.bubbleLayer];
        
        [self.containerView addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.containerView).with.insets(UIEdgeInsetsMake(8, 12, 8, 12));
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelDidTap:)];
        tap.numberOfTouchesRequired = 1;
        tap.numberOfTapsRequired = 1;
        [self.contentLabel addGestureRecognizer:tap];
        self.contentLabel.userInteractionEnabled = YES;
    }
    return self;
}

- (UIView *)containerView {
    if (_containerView == nil) {
        _containerView = [[UIView alloc] init];
    }
    return _containerView;
}

- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (RCChatroomSceneBubbleLayer *)bubbleLayer {
    if (_bubbleLayer == nil) {
        _bubbleLayer = [RCChatroomSceneBubbleLayer layer];
    }
    return _bubbleLayer;
}

- (instancetype)update:(id<RCChatroomSceneMessageProtocol>)message
              delegate:(id<RCChatroomSceneEventProtocol>)delegate {
    self.message = message;
    self.delegate = delegate;
    if ([message respondsToSelector:@selector(attributeString)]) {
        self.contentLabel.attributedText = [message attributeString];
    }
    if ([message respondsToSelector:@selector(bubbleColor)]) {
        self.bubbleLayer.fillColor = [message bubbleColor].CGColor;
    } else {
        self.bubbleLayer.fillColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3].CGColor;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        self.bubbleLayer.frame = self.containerView.bounds;
    });
    return self;
}

- (void)labelDidTap:(UITapGestureRecognizer *)gesture {
    /// 点击位置
    CGPoint point = [gesture locationInView:self.contentLabel];
    /// 获取点击位置文本位置
    NSInteger index = [self.contentLabel indexOfAttriTxtAtPoint:point];
    if (index == NSNotFound) return;
    /// 获取事件
    if (![self.message respondsToSelector:@selector(events)]) return;
    NSDictionary *events = [self.message events];
    /// 判断是否触发事件
    [events enumerateKeysAndObjectsUsingBlock:^(NSValue *value, NSString *key, BOOL * _Nonnull stop) {
        NSRange range = [value rangeValue];
        if (range.location <= index && (range.location + range.length) >= index) {
            if ([self.delegate respondsToSelector:@selector(cell:didClickEvent:)]) {
                [self.delegate cell:self didClickEvent:key];
            }
            *stop = YES;
        }
    }];
}

+ (NSString *)cellIdentifier {
    return kRCCSMCellIdentifier;
}

@end
