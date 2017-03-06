//
//  Sine.h
//  AnimationDraw
//
//  Created by gaojuyan on 2017/3/2.
//  Copyright © 2017年 Jiae. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shape.h"
#import "AnimationPoint.h"

@interface Sine : Shape

// y = A*sin(w * x + phi)

+ (instancetype)createSineWithAmp:(float)amp
                            omega:(float)omega
                              phi:(float)phi;

@end
