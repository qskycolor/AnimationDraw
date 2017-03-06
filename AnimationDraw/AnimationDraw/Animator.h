//
//  Animator.h
//  AnimationDraw
//
//  Created by gaojuyan on 2017/3/2.
//  Copyright © 2017年 Jiae. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shape.h"

@class Animator;

@protocol AnimatorDelegate <NSObject>

- (void)onAnimationStart:(Animator *)animation;
- (void)onAnimationEnd:(Animator *)animation;
- (void)onAnimationCancel:(Animator *)animation;
- (void)onAnimationRepeat:(Animator *)animation;
- (void)onAnimationUpdate:(Animator *)animation;

@end

@interface Animator : NSObject

@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, weak) id<AnimatorDelegate> delegate;

+ (instancetype)animateOnTarget:(UIView *)target
                      evaluator:(Shape *)evaluator
                         values:(NSArray *)values;
- (void)start;
- (void)invalidate;

@end
