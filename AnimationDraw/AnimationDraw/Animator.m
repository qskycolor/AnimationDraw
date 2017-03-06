//
//  Animator.m
//  AnimationDraw
//
//  Created by gaojuyan on 2017/3/2.
//  Copyright © 2017年 Jiae. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "Animator.h"
#import <UIKit/UIKit.h>
#import "AnimationPoint.h"

#define kSampleRate 0.05f

@interface Animator()<CAAnimationDelegate>

@property (nonatomic, weak) UIView *target;
@property (nonatomic, strong) NSArray *values;
@property (nonatomic, strong) NSArray *points;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) Shape *evaluator;
@property (nonatomic, assign) CGFloat currentTime;

@property (nonatomic, strong) AnimationPoint *startValue;
@property (nonatomic, strong) AnimationPoint *endValue;

@end

@implementation Animator


+ (instancetype)animateOnTarget:(UIView *)target
                      evaluator:(Shape *)evaluator
                         values:(NSArray *)values {
    NSAssert(target, @"target cannot be nil");
    NSAssert(values, @"values cannot be nil");
    Animator *animator = [[self alloc]init];
    animator.target = target;
    animator.values = values;
    animator.evaluator = evaluator;
    [animator setupAnimator];
    return animator;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _duration = 5.0f;// 默认5s
        _currentTime = 0.f;
    }
    return self;
}

- (void)setupAnimator {
    if (_values.count == 1) {
        AnimationPoint *p1 = [[AnimationPoint alloc]initWithX:0 y:0];
        AnimationPoint *p2 = [_values objectAtIndex:0];
        _values = @[p1, p2];
    }
    _startValue =  [_values objectAtIndex:0];
    _endValue = [_values objectAtIndex:1];
}

- (void)invalidate {
    [self.timer invalidate], self.timer = nil;
}

- (void)start {
    /*
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    AnimationPoint *start = self.points[0];
    AnimationPoint *end = self.points[1];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(start.getX, start.getY)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(end.getX, end.getY)];
    animation.repeatCount = FLT_MAX;
    //animation.timingFunction
    // 必须设置代理
    animation.delegate = self;
    // 取消反弹
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [_target.layer addAnimation:animation forKey:nil];*/
    if (_timer) {
        [self invalidate];
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:kSampleRate target:self selector:@selector(onAnimatorUpdated:) userInfo:nil repeats:YES];
    if ([self.delegate respondsToSelector:@selector(onAnimationStart:)]) {
        [self.delegate onAnimationStart:self];
    }
}

- (void)onAnimatorUpdated:(NSTimer *)timer {
    _currentTime += kSampleRate;
    if (_currentTime >= _duration) {
        _currentTime = 0.f;
        if ([self.delegate respondsToSelector:@selector(onAnimationRepeat:)]) {
            [self.delegate onAnimationRepeat:self];
        }
        [_evaluator clear];
    }
    float fraction = _currentTime / _duration;
    AnimationPoint *currentPoint = [_evaluator evaluate:fraction startValue:_startValue endValue:_endValue];
    //NSLog(@"x: %f, y: %f", [currentPoint getX], [currentPoint getY]);
    _target.frame = CGRectMake(currentPoint.getX, currentPoint.getY, CGRectGetWidth(_target.frame), CGRectGetHeight(_target.frame));
    if ([self.delegate respondsToSelector:@selector(onAnimationUpdate:)]) {
        [self.delegate onAnimationUpdate:self];
    }
}


@end
