//
//  UIImage+Bundle.m
//  RCChatroomSceneKit
//
//  Created by shaoshuai on 2021/11/2.
//

#import "UIImage+Bundle.h"

@implementation UIImage (Bundle)

+ (instancetype)bundleImageNamed:(NSString *)name {
    return [UIImage bundleImageNamed:name extention:@"png"];
}

+ (instancetype)bundleImageNamed:(NSString *)name extention:(NSString *)extension {
    NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"RCChatroomSceneToolBar")];
    NSString *path = [bundle pathForResource:name ofType:extension];
    return [UIImage imageWithContentsOfFile:path];
}

@end
