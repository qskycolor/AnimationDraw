
//
//  Bezier.m
//  AnimationDraw
//
//  Created by fanzhou on 2017/3/5.
//  Copyright © 2017年 gaojuyan. All rights reserved.
//

#import "Bezier.h"

@interface Bezier ()

@property (nonatomic, strong) NSArray *spots;

@property (nonatomic, assign) NSInteger count;

@end

@implementation Bezier

- (instancetype)init {
    self = [super init];
    if (self) {
        _count = 3;
        self.type = ShapeTypeBezier;
    }
    return self;
}

+ (instancetype)bezierWithspotCount:(NSInteger )count {
    Bezier *bezier = [[Bezier alloc] init];
    bezier.count = count;
    [bezier createSpot];
    return bezier;
}

- (AnimationPoint *)evaluate:(float)fraction
                  startValue:(AnimationPoint *)startValue
                    endValue:(AnimationPoint *)endValue {
    CGFloat resultX = 0.f, resultY = 0.f;
    for (int i = 0; i < _count; i++) {
        CGPoint initPoint = CGPointFromString(_spots[i]);
        resultX += [self getBezierWithSpot:initPoint.x t:fraction count:_count-1 i:i];
        resultY += [self getBezierWithSpot:initPoint.y t:fraction count:_count-1 i:i];
    }
    AnimationPoint *point = [[AnimationPoint alloc]initWithX:resultX y:resultY];
    [self.points addObject:point];
    return point;
}

- (NSArray *)getSpots {
    return _spots;
}

- (void)createSpot {
    NSMutableArray *spots = [NSMutableArray arrayWithCapacity:_count];
    for (int i = 0; i < _count; i++) {
        CGFloat randomX = arc4random() % 300 + 1;
        CGFloat randomY = arc4random() % 400 + 1;
        CGPoint point = CGPointMake(randomX, randomY);
        [spots addObject:NSStringFromCGPoint(point)];
    }
    _spots = spots;
}

// bezier x/y 坐标
- (CGFloat)getBezierWithSpot:(CGFloat)spot t:(CGFloat)t count:(NSInteger)pointArrayCount i:(int)i {
    NSInteger binomial = [self binomialWithN:pointArrayCount r:i];
    return binomial * spot * pow(1-t, pointArrayCount-i) * pow(t, i);
}

// 二项式
- (NSInteger)binomialWithN:(NSInteger)n r:(NSInteger)r {
    return [self factorialWithNum:n] / [self factorialWithNum:r] / [self factorialWithNum:n - r];
}

// 阶乘
- (double)factorialWithNum:(NSInteger)num {
    if (num <= 0) {
        return 1;
    }
    return num * [self factorialWithNum:num - 1];
}

@end
