//
//  Sine.m
//  AnimationDraw
//
//  Created by gaojuyan on 2017/3/2.
//  Copyright © 2017年 Jiae. All rights reserved.
//

#import "Sine.h"

@interface Sine ()

@property (nonatomic, assign) float amp;
@property (nonatomic, assign) float omega;
@property (nonatomic, assign) float phi;

@end

@implementation Sine

+ (instancetype)createSineWithAmp:(float)amp
                            omega:(float)omega
                              phi:(float)phi {
    Sine *sine = [[self alloc]init];
    sine.amp = amp, sine.omega = omega, sine.phi = phi;
    return sine;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _amp = 10.f;
        _omega = 1.0f;
        _phi = 0.f;
        self.type = ShapeTypeSin;
    }
    return self;
}

- (AnimationPoint *)evaluate:(float)fraction
                  startValue:(AnimationPoint *)startValue
                    endValue:(AnimationPoint *)endValue {
    
    float startX = [startValue getX], endX = [endValue getX];
    //float startY = [startValue getY], endY = [endValue getY];
    float currentX = startX + (endX - startX) * fraction;
    float currentY = [startValue getY] + _amp * sinf(_omega * currentX + _phi);
    AnimationPoint *point = [[AnimationPoint alloc]initWithX:currentX y:currentY];
    [self.points addObject:point];
    return point;
}

@end
