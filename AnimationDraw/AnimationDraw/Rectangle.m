//
//  Rectangle.m
//  AnimationDraw
//
//  Created by fanzhou on 2017/3/5.
//  Copyright © 2017年 gaojuyan. All rights reserved.
//

#import "Rectangle.h"

@interface Rectangle ()

@property (nonatomic, assign) float length;
@property (nonatomic, assign) float width;
@property (nonatomic, strong) AnimationPoint *center;

@end

@implementation Rectangle

- (instancetype)init {
    self = [super init];
    if (self) {
        _length = 200;
        _width = 100;
        self.type = ShapeTypeRectangle;
    }
    return self;
}

+ (instancetype)rectangleWithCenter:(AnimationPoint *)center
                             length:(float)length
                              width:(float)width {
    Rectangle *rectangle = [[Rectangle alloc] init];
    rectangle.center = center;
    rectangle.length = length;
    rectangle.width = width;
    return rectangle;
}

- (AnimationPoint *)evaluate:(float)fraction
                  startValue:(AnimationPoint *)startValue
                    endValue:(AnimationPoint *)endValue {
    CGFloat circumference = (_length + _width) * 2;
    CGFloat currentCircumference = circumference * fraction;
    CGFloat startX = [_center getX] - (_length * .5), startY = [_center getY] - (_width * .5);
    AnimationPoint *point = nil;
    if (currentCircumference <= _length) {
        point = [[AnimationPoint alloc]initWithX:currentCircumference + startX y:startY];
    }else if (currentCircumference > _length && currentCircumference <= _length + _width) {
        point = [[AnimationPoint alloc]initWithX:_length + startX y:startY + (currentCircumference - _length)];
    }else if (currentCircumference > _length + _width && currentCircumference <= _length * 2 + _width) {
        point = [[AnimationPoint alloc]initWithX:startX + (_length - (currentCircumference - _length - _width)) y:startY + _width];
    }else {
        point = [[AnimationPoint alloc]initWithX:startX y:startY + _width - (currentCircumference - _width - _length * 2)];
    }
    [self.points addObject:point];
    return point;
}

@end
