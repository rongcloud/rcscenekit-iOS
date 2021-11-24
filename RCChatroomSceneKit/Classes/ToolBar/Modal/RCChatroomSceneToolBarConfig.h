//
//  RCChatroomSceneToolBarConfig.h
//  RCChatroomSceneKit
//
//  Created by shaoshuai on 2021/11/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, RCChatroomSceneRecordButtonPosition) {
    RCChatroomSceneRecordButtonPositionLeft,
    RCChatroomSceneRecordButtonPositionRight,
};

typedef NS_ENUM(NSInteger, RCChatroomSceneRecordQuality) {
    RCChatroomSceneRecordQualityLow,
    RCChatroomSceneRecordQualityHigh,
};

@interface RCChatroomSceneToolBarConfig : NSObject

/// 消息按钮大小
@property (nonatomic, assign) CGSize chatButtonSize;
/// 消息按钮标题
@property (nonatomic, strong) NSString *chatButtonTitle;

/// 录音按钮是否可用
@property (nonatomic, assign) BOOL recordButtonEnable;
/// 录音质量
@property (nonatomic, assign) RCChatroomSceneRecordQuality recordQuality;
/// 录音按钮位置
@property (nonatomic, assign) RCChatroomSceneRecordButtonPosition recordButtonPosition;

/// 是否支持表情
@property (nonatomic, assign) BOOL inputViewEmojiEnable;
/// 自定义表情视图
@property (nonatomic, strong) UIView *inputEmojiView;

/// 常用功能按钮
@property (nonatomic, strong) NSArray<UIView *> *commonActions;
/// 功能按钮
@property (nonatomic, strong) NSArray<UIView *> *actions;

@end

NS_ASSUME_NONNULL_END
