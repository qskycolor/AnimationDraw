//
//  AnimationPoint.h
//  AnimationDraw
//
//  Created by gaojuyan on 2017/3/2.
//  Copyright © 2017年 fanzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnimationPoint : NSObject

- (instancetype)initWithX:(float)x y:(float)y;

- (float)getX;
- (float)getY;

@end
