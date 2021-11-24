//
//  RCChatroomSceneToolBarConfig+Helper.h
//  Alamofire
//
//  Created by shaoshuai on 2021/11/3.
//

#import "RCChatroomSceneToolBarConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface RCChatroomSceneToolBarConfig (Helper)

+ (instancetype)default;

- (void)merge:(RCChatroomSceneToolBarConfig *)config;

@end

NS_ASSUME_NONNULL_END
