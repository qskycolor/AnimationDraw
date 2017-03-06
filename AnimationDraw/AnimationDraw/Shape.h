//
//  Shape.h
//  AnimationDraw
//
//  Created by gaojuyan on 2017/3/2.
//  Copyright © 2017年 Jiae. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AnimationPoint.h"

typedef NS_ENUM(NSInteger, ShapeType) {
    ShapeTypeLine,
    ShapeTypeSin,
    ShapeTypeCircle,
    ShapeTypeRectangle,
    ShapeTypeBezier
};

@protocol Shape <NSObject>

@property (nonatomic, assign) ShapeType type;
@property (nonatomic, assign) UIBezierPath *path;
@property (nonatomic, strong) NSMutableArray *points;

- (AnimationPoint *)evaluate:(float)fraction
                startValue:(AnimationPoint*)startValue
                  endValue:(AnimationPoint*)endValue;

@end

@interface Shape : NSObject<Shape>

@property (nonatomic, assign) ShapeType type;
@property (nonatomic, assign) UIBezierPath *path;
@property (nonatomic, strong) NSMutableArray *points;

- (void)clear;

@end
