//
//  Canvas.h
//  AnimationDraw
//
//  Created by gaojuyan on 2017/3/2.
//  Copyright © 2017年 Jiae. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shape.h"

@interface Canvas : UIView

@property (nonatomic, strong) UIColor *color;

- (void)drawShape:(id<Shape>)shape;

@end
