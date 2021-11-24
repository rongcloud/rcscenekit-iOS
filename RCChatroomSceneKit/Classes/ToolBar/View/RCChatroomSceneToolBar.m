//
//  RCChatroomSceneToolBar.m
//  RCChatroomSceneKit
//
//  Created by shaoshuai on 2021/10/29.
//

#import <Masonry/Masonry.h>

#import "UIImage+Bundle.h"
#import "RCChatroomSceneToolBar.h"
#import "RCChatroomAudioRecordView.h"
#import "RCChatroomSceneInputViewController.h"
#import "RCChatroomSceneToolBarConfig+Helper.h"

@interface RCChatroomSceneToolBar () <RCChatroomSceneInputViewControllerDelegate, RCChatroomAudioRecordViewDelegate>

@property (nonatomic, strong) UIButton *chatButton;
@property (nonatomic, strong) UIStackView *commonStackView;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) RCChatroomAudioRecordView *recordView;
@property (nonatomic, strong) RCChatroomSceneToolBarConfig *config;

@end

@implementation RCChatroomSceneToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.clearColor;
        
        _config = [RCChatroomSceneToolBarConfig default];
        
        [self addSubview:self.chatButton];
        [self.chatButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(12);
            make.centerY.equalTo(self);
            make.width.mas_equalTo(105);
            make.height.mas_equalTo(36);
        }];
        
        [self addSubview:self.commonStackView];
        [self.commonStackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.width.mas_greaterThanOrEqualTo(12);
            make.height.lessThanOrEqualTo(self);
            make.left.equalTo(self.chatButton.mas_right).offset(12);
        }];
        
        [self addSubview:self.stackView];
        [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-12);
            make.width.mas_greaterThanOrEqualTo(12);
            make.height.lessThanOrEqualTo(self);
            make.left.greaterThanOrEqualTo(self.commonStackView.mas_right).offset(12);
        }];
        
        [self setupUI];
    }
    return self;
}

- (UIButton *)chatButton {
    if (_chatButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor colorWithWhite:1 alpha:0.26];
        [button setTitleColor:[UIColor colorWithWhite:1 alpha:0.8] forState:UIControlStateNormal];
        [button setTitle:@"聊聊吧…" forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0);
        button.layer.cornerRadius = 18;
        button.layer.masksToBounds = YES;
        [button addTarget:self
                   action:@selector(buttonDidClick:)
         forControlEvents:UIControlEventTouchUpInside];
        UIImage *image = [UIImage bundleImageNamed:@"toolbar_chat_input"];
        [button setImage:image forState:UIControlStateNormal];
        _chatButton = button;
    }
    return _chatButton;
}

- (void)buttonDidClick:(UIButton *)button {
    RCChatroomSceneInputViewController *controller = [[RCChatroomSceneInputViewController alloc] initWithConfig:self.config inputDelegate:self];
    [UIApplication.sharedApplication.keyWindow.rootViewController presentViewController:controller animated:YES completion:nil];
}

- (RCChatroomAudioRecordView *)recordView {
    if (_recordView == nil) {
        _recordView = [[RCChatroomAudioRecordView alloc] init];
    }
    return _recordView;
}

- (UIStackView *)commonStackView {
    if (_commonStackView == nil) {
        _commonStackView = [[UIStackView alloc] init];
        _commonStackView.distribution = UIStackViewDistributionEqualSpacing;
        _commonStackView.alignment = UIStackViewAlignmentLeading;
        _commonStackView.spacing = 12;
    }
    return _commonStackView;
}

- (UIStackView *)stackView {
    if (_stackView == nil) {
        _stackView = [[UIStackView alloc] init];
        _stackView.distribution = UIStackViewDistributionEqualSpacing;
        _stackView.alignment = UIStackViewAlignmentTrailing;
        _stackView.spacing = 12;
    }
    return _stackView;
}

- (void)setConfig:(RCChatroomSceneToolBarConfig *)config {
    if (config == nil) return;
    [_config merge:config];
    [self setupUI];
}

- (void)setupUI {
    CGSize size = self.config.chatButtonSize;
    [self.chatButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(size.width);
        make.height.mas_equalTo(size.height);
    }];
    
    [self.chatButton setTitle:self.config.chatButtonTitle
                     forState:UIControlStateNormal];
    
    if (self.config.recordButtonEnable) {
        [self addSubview:self.recordView];
        self.recordView.delegate = self;
        [self.chatButton setImage:nil forState:UIControlStateNormal];
        switch (self.config.recordButtonPosition) {
            case RCChatroomSceneRecordButtonPositionLeft:
            {
                self.chatButton.titleEdgeInsets = UIEdgeInsetsMake(0, 24, 0, 0);
                [self.recordView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.centerY.equalTo(self.chatButton);
                    make.width.height.mas_equalTo(44);
                }];
            }
                break;
                
            case RCChatroomSceneRecordButtonPositionRight:
            {
                self.chatButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 24);
                [self.recordView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.centerY.equalTo(self.chatButton);
                    make.width.height.mas_equalTo(44);
                }];
            }
                break;
        }
    } else {
        [self.recordView removeFromSuperview];
        self.chatButton.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0);
        self.chatButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 4);
        UIImage *image = [UIImage bundleImageNamed:@"toolbar_chat_input"];
        [self.chatButton setImage:image forState:UIControlStateNormal];
    }
    
    for (UIView *view in self.commonStackView.arrangedSubviews) {
        [self.commonStackView removeArrangedSubview:view];
    }
    for (UIView *view in self.config.commonActions) {
        [self.commonStackView addArrangedSubview:view];
    }
    
    for (UIView *view in self.stackView.arrangedSubviews) {
        [self.stackView removeArrangedSubview:view];
    }
    for (UIView *view in self.config.actions) {
        [self.stackView addArrangedSubview:view];
    }
}

#pragma mark - RCChatroomSceneInputViewControllerDelegate -

- (void)inputViewDidClickSendButtonWith:(NSString *)content {
    if ([self.delegate respondsToSelector:@selector(textInputViewSendText:)]) {
        [self.delegate textInputViewSendText:content];
    }
}

#pragma mark - RCChatroomAudioRecordViewDelegate -

- (void)audioRecordDidBegin {
    if ([self.delegate respondsToSelector:@selector(audioRecordDidBegin)]) {
        [self.delegate audioRecordDidBegin];
    }
}

- (void)audioRecordDidCancel {
    if ([self.delegate respondsToSelector:@selector(audioRecordDidCancel)]) {
        [self.delegate audioRecordDidCancel];
    }
}

- (void)audioRecordDidEnd:(NSData *)data time:(NSTimeInterval)time {
    long currentTime = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString *fileName = [NSString stringWithFormat:@"%ld.wav", currentTime];
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:fileName];
    [data writeToFile:filePath atomically:YES];
    if ([self.delegate respondsToSelector:@selector(audioRecordDidEnd:time:)]) {
        [self.delegate audioRecordDidEnd:data time:time];
    }
}

@end
