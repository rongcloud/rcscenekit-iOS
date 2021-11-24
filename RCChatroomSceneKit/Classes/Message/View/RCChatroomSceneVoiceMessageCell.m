//
//  RCChatroomSceneVoiceMessageCell.m
//  RCChatroomSceneKit
//
//  Created by shaoshuai on 2021/10/27.
//

#import <Masonry/Masonry.h>

#import "UIImage+Bundle.h"
#import "RCChatroomSceneProtocol.h"
#import "RCChatroomSceneAudioPlayer.h"
#import "RCChatroomSceneVoiceMessageCell.h"

static NSString *kRCCSMVoiceCellIdentifier = @"RCChatroomSceneVoiceMessageCell";

@interface RCChatroomSceneVoiceMessageCell () <RCChatroomSceneAudioPlayerDelegate>

@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, weak) id<RCChatroomSceneVoiceMessage> voiceMessage;

@end

@implementation RCChatroomSceneVoiceMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.containerView).with.offset(12);
            make.top.bottom.equalTo(self.containerView).with.inset(8);
        }];
        [self.containerView addSubview:self.playButton];
        [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentLabel.mas_right).with.offset(2);
            make.right.equalTo(self.containerView).with.offset(-4);
            make.centerY.equalTo(self.contentLabel);
            make.width.mas_greaterThanOrEqualTo(44);
        }];
    }
    return self;
}

- (UIButton *)playButton {
    if (_playButton == nil) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setImage:[UIImage bundleImageNamed:@"audio_icon_3"]
                     forState:UIControlStateNormal];
        [_playButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_playButton setTitleColor:[UIColor.whiteColor colorWithAlphaComponent:0.4] forState:UIControlStateHighlighted];
        [_playButton setTitle:@"″" forState:UIControlStateNormal];
        [_playButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        _playButton.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
        _playButton.contentHorizontalAlignment = NSTextAlignmentLeft;
        [_playButton addTarget:self action:@selector(playButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}

- (void)playButtonClick {
    [self startAnimation];
    
    if ([self.voiceMessage respondsToSelector:@selector(voicePath)]) {
        NSString *voicePath = [self.voiceMessage voicePath];
        NSURL *URL = [NSURL URLWithString:voicePath];
        [RCChatroomSceneAudioPlayer.shared play:URL delegate:self];
    }
}

- (void)startAnimation {
    self.playButton.imageView.animationImages = [self playAnimationImages];
    self.playButton.imageView.animationDuration = 1;
    [self.playButton.imageView startAnimating];
}

- (void)stopAnimation {
    [self.playButton.imageView stopAnimating];
}

- (NSArray<UIImage *> *)playAnimationImages {
    return @[
        [UIImage bundleImageNamed:@"audio_icon_1"],
        [UIImage bundleImageNamed:@"audio_icon_2"],
        [UIImage bundleImageNamed:@"audio_icon_3"]
    ];
}

- (instancetype)update:(id<RCChatroomSceneMessageProtocol>)message
              delegate:(id<RCChatroomSceneEventProtocol>)delegate {
    if ([message conformsToProtocol:@protocol(RCChatroomSceneVoiceMessage)]) {
        self.voiceMessage = (id<RCChatroomSceneVoiceMessage>)message;
        if ([self.voiceMessage respondsToSelector:@selector(voiceDuration)]) {
            long duration = [self.voiceMessage voiceDuration];
            NSString *title = [NSString stringWithFormat:@"%ld″", duration];
            [self.playButton setTitle:title forState:UIControlStateNormal];
        }
        if ([self.voiceMessage respondsToSelector:@selector(voicePath)]) {
            NSString *path = [self.voiceMessage voicePath];
            NSURL *URL = [NSURL URLWithString:path];
            if ([RCChatroomSceneAudioPlayer.shared.currentURL isEqual:URL]) {
                [self startAnimation];
                [RCChatroomSceneAudioPlayer.shared play:URL delegate:self];
            }
        }
    }
    return [super update:message delegate:delegate];
}

#pragma mark - RCChatroomSceneAudioPlayerDelegate -

- (void)didBegin {
    [self startAnimation];
}

- (void)didEnd {
    [self stopAnimation];
}

+ (NSString *)cellIdentifier {
    return kRCCSMVoiceCellIdentifier;
}

@end
