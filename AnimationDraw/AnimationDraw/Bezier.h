//
//  Bezier.h
//  AnimationDraw
//
//  Created by fanzhou on 2017/3/5.
//  Copyright © 2017年 gaojuyan. All rights reserved.
//

#import "Shape.h"

@interface Bezier : Shape

+ (instancetype)bezierWithspotCount:(NSInteger )count;

- (NSArray *)getSpots;

@end
