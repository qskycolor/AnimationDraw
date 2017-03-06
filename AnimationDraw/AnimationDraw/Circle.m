//
//  Circle.m
//  AnimationDraw
//
//  Created by gaojuyan on 2017/3/3.
//  Copyright © 2017年 gaojuyan. All rights reserved.
//

#import "Circle.h"

@interface Circle ()

@property (nonatomic, assign) float radius;
@property (nonatomic, strong) AnimationPoint *center;

@end

@implementation Circle

- (instancetype)init {
    self = [super init];
    if (self) {
        _radius = 90.f;
        self.type = ShapeTypeCircle;
    }
    return self;
}

+ (instancetype)circleWithCenter:(AnimationPoint *)center radius:(float)radius {
    Circle *circle = [[self alloc] init];
    circle.radius = radius, circle.center = center;
    return circle;
}

- (AnimationPoint *)evaluate:(float)fraction
                  startValue:(AnimationPoint *)startValue
                    endValue:(AnimationPoint *)endValue {
    //旋转角度
    double theta = 2 * M_PI * fraction;
    
    float x = _center.getX - _radius * cos(theta);
    float y = _center.getY - _radius * sin(theta);
    AnimationPoint *point = [[AnimationPoint alloc]initWithX:x y:y];
    [self.points addObject:point];
    return point;
}

@end
