//
//  ShapeFactory.m
//  AnimationDraw
//
//  Created by gaojuyan on 2017/3/3.
//  Copyright © 2017年 gaojuyan. All rights reserved.
//

#import "ShapeFactory.h"
#import "Sine.h"
#import "Circle.h"

@implementation ShapeFactory

+ (Shape *)createShapeWithType:(ShapeType)type {
    
    Shape *shape = nil;
    switch (type) {
            
        case ShapeTypeLine:
            
        case ShapeTypeCircle:
        {
            AnimationPoint *center = [[AnimationPoint alloc]initWithX:100 y:400];
            shape = [Circle circleWithCenter:center radius:90];
        }
            break;
            
        case ShapeTypeSin:
            shape = [Sine createSineWithAmp:40 omega:0.1 phi:0.8];
            break;
            
        case ShapeTypeBezier:
            
        case ShapeTypeRectangle:
        {
            
            
        }
            break;
            
        default:
            break;
    }
    return shape;
}

@end
