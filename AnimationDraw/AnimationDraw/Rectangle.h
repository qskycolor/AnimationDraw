//
//  Rectangle.h
//  AnimationDraw
//
//  Created by fanzhou on 2017/3/5.
//  Copyright © 2017年 gaojuyan. All rights reserved.
//

#import "Shape.h"

@interface Rectangle : Shape

+ (instancetype)rectangleWithCenter:(AnimationPoint *)center
                             length:(float)length
                              width:(float)width;

@end
