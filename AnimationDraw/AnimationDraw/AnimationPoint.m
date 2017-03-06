//
//  AnimationPoint.m
//  AnimationDraw
//
//  Created by gaojuyan on 2017/3/2.
//  Copyright © 2017年 fanzhou. All rights reserved.
//

#import "AnimationPoint.h"

@interface AnimationPoint()

@property (nonatomic, assign) float x;
@property (nonatomic, assign) float y;

@end

@implementation AnimationPoint

- (instancetype)initWithX:(float)x y:(float)y {
    if (self == [super init]) {
        self.x = x;
        self.y = y;
    }
    return self;
}

- (float)getX {
    return self.x;
}

- (float)getY {
    return self.y;
}

@end
