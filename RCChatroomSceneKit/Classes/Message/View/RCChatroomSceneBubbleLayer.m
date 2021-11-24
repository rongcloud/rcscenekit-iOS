//
//  RCChatroomSceneBubbleLayer.m
//  RCChatroomSceneKit
//
//  Created by shaoshuai on 2021/10/27.
//

#import "RCChatroomSceneBubbleLayer.h"

@implementation RCChatroomSceneBubbleLayer

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    CGFloat cornerRadius = 6;
    CGFloat leftTopRadius = 1;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, leftTopRadius);
    CGPathAddArc(path, nil, leftTopRadius, leftTopRadius, leftTopRadius, M_PI, M_PI + M_PI_2, NO);
    CGPathAddArc(path, nil, width - cornerRadius, cornerRadius, cornerRadius, -M_PI_2, 0, NO);
    CGPathAddArc(path, nil, width - cornerRadius, height - cornerRadius, cornerRadius, 0, M_PI_2, NO);
    CGPathAddArc(path, nil, cornerRadius, height - cornerRadius, cornerRadius, M_PI_2, M_PI, NO);
    CGPathCloseSubpath(path);

    self.path = path;
}

@end
