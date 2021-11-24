//
//  RCChatroomSceneToolBarConfig+Helper.m
//  Alamofire
//
//  Created by shaoshuai on 2021/11/3.
//

#import "RCChatroomSceneToolBarConfig+Helper.h"

@implementation RCChatroomSceneToolBarConfig (Helper)

+ (instancetype)default {
    RCChatroomSceneToolBarConfig *config = [[RCChatroomSceneToolBarConfig alloc] init];
    config.chatButtonSize = CGSizeMake(105, 36);
    config.chatButtonTitle = @"聊聊吧...";
    config.recordButtonEnable = NO;
    config.recordQuality = RCChatroomSceneRecordQualityLow;
    config.recordButtonPosition = RCChatroomSceneRecordButtonPositionLeft;
    config.inputViewEmojiEnable = YES;
    config.commonActions = @[];
    config.actions = @[];
    return config;
}

- (void)merge:(RCChatroomSceneToolBarConfig *)config {
    NSDictionary *dict = [config valueForKey:@"configInfo"];
    
    NSValue *chatButtonSize = dict[@"chatButtonSize"];
    if (chatButtonSize) {
        self.chatButtonSize = [chatButtonSize CGSizeValue];
    }
    
    NSString *chatButtonTitle = dict[@"chatButtonTitle"];
    if (chatButtonTitle) {
        self.chatButtonTitle = chatButtonTitle;
    }
    
    NSNumber *recordQuality = dict[@"recordQuality"];
    if (recordQuality) {
        self.recordQuality = [recordQuality integerValue];
    }
    
    NSNumber *recordButtonEnable = dict[@"recordButtonEnable"];
    if (recordButtonEnable) {
        self.recordButtonEnable = [recordButtonEnable boolValue];
    }
    
    NSNumber *recordPosition = dict[@"recordPosition"];
    if (recordPosition) {
        self.recordButtonPosition = [recordPosition integerValue];
    }

    NSNumber *emojiEnable = dict[@"emojiEnable"];
    if (emojiEnable) {
        self.inputViewEmojiEnable = [emojiEnable boolValue];
    }
    
    UIView *emojiView = dict[@"emojiView"];
    if (emojiView) {
        self.inputEmojiView = emojiView;
    }
    
    NSArray<UIView *> *commonActions = dict[@"commonActions"];
    if (commonActions) {
        self.commonActions = commonActions;
    }
    
    NSArray<UIView *> *actions = dict[@"actions"];
    if (actions) {
        self.actions = actions;
    }
}

@end
