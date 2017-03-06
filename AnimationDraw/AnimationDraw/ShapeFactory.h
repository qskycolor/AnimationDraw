//
//  ShapeFactory.h
//  AnimationDraw
//
//  Created by gaojuyan on 2017/3/3.
//  Copyright © 2017年 gaojuyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shape.h"

@interface ShapeFactory : NSObject

+ (Shape *)createShapeWithType:(ShapeType)type;

@end
