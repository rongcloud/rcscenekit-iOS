//
//  RCChatroomSceneConfig.m
//  RCChatroomSceneKit
//
//  Created by shaoshuai on 2021/11/3.
//

#import "RCChatroomSceneToolBarConfig.h"

@interface RCChatroomSceneToolBarConfig ()

@property (nonatomic, strong) NSMutableDictionary *configInfo;

@end

@implementation RCChatroomSceneToolBarConfig

- (instancetype)init {
    if (self = [super init]) {
        _configInfo = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)setChatButtonSize:(CGSize)chatButtonSize {
    _chatButtonSize = chatButtonSize;
    _configInfo[@"chatButtonSize"] = [NSValue valueWithCGSize:chatButtonSize];
}

- (void)setChatButtonTitle:(NSString *)chatButtonTitle {
    _chatButtonTitle = chatButtonTitle;
    _configInfo[@"chatButtonTitle"] = chatButtonTitle;
}

- (void)setRecordQuality:(RCChatroomSceneRecordQuality)recordQuality {
    _recordQuality = recordQuality;
    _configInfo[@"recordQuality"] = @(recordQuality);
}

- (void)setRecordButtonEnable:(BOOL)recordButtonEnable {
    _recordButtonEnable = recordButtonEnable;
    _configInfo[@"recordButtonEnable"] = @(recordButtonEnable);
}

- (void)setRecordButtonPosition:(RCChatroomSceneRecordButtonPosition)recordPosition {
    _recordButtonPosition = recordPosition;
    _configInfo[@"recordPosition"] = @(recordPosition);
}

- (void)setInputViewEmojiEnable:(BOOL)emojiEnable {
    _inputViewEmojiEnable = emojiEnable;
    _configInfo[@"emojiEnable"] = @(emojiEnable);
}

- (void)setInputEmojiView:(UIView *)emojiView {
    _inputEmojiView = emojiView;
    _configInfo[@"emojiView"] = emojiView;
}

- (void)setCommonActions:(NSArray<UIView *> *)commonActions {
    _commonActions = commonActions;
    _configInfo[@"commonActions"] = commonActions;
}

- (void)setActions:(NSArray<UIView *> *)actions {
    _actions = actions;
    _configInfo[@"actions"] = actions;
}

@end
