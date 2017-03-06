//
//  Shape.m
//  AnimationDraw
//
//  Created by gaojuyan on 2017/3/2.
//  Copyright © 2017年 Jiae. All rights reserved.
//

#import "Shape.h"


@implementation Shape

- (void)clear {
    [self.points removeAllObjects];
}

- (AnimationPoint *)evaluate:(float)fraction
                  startValue:(AnimationPoint *)startValue
                    endValue:(AnimationPoint *)endValue {
    // 交给子类实现
    return nil;
}

- (NSMutableArray *)points
{
    if (!_points) {
        _points = [[NSMutableArray alloc] init];
    }
    return _points;
}

@end
