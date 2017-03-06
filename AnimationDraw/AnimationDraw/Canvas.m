//
//  Canvas.m
//  AnimationDraw
//
//  Created by gaojuyan on 2017/3/2.
//  Copyright © 2017年 Jiae. All rights reserved.
//

#import "Canvas.h"

@interface Canvas ()

@property (nonatomic, strong) Shape *shape;

@end

@implementation Canvas

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [self.color set];
    
    NSArray *points = _shape.points;
    BOOL hasOrigin = NO;
    for (AnimationPoint *point in points) {
        if (hasOrigin == NO) {
            hasOrigin = YES;
            [path moveToPoint:CGPointMake([point getX], [point getY])];
        }
        [path addLineToPoint:CGPointMake([point getX], [point getY])];
    }
        
    [path stroke];
}

- (void)drawShape:(id<Shape>)shape {
    _shape = shape;
    [self setNeedsDisplay];
}


@end
