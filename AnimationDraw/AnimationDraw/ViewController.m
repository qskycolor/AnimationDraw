//
//  ViewController.m
//  AnimationDraw
//
//  Created by gaojuyan on 2017/3/3.
//  Copyright © 2017年 gaojuyan. All rights reserved.
//

#import "ViewController.h"
#import "Animator.h"
#import "ShapeFactory.h"
#import "Canvas.h"
#import "Bezier.h"

@interface ViewController ()<AnimatorDelegate>

@property (nonatomic, strong) UIView *cursor;
@property (nonatomic, strong) Canvas *canvas;
@property (nonatomic, strong) Animator *animator;

@property (nonatomic, strong) NSMutableArray *spotArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    Canvas *canvas = [[Canvas alloc]initWithFrame:CGRectMake(0, 10, screenSize.width, 700)];
    canvas.backgroundColor = [UIColor whiteColor];
    canvas.color = [UIColor purpleColor];
    self.canvas = canvas;
    [self.view addSubview:canvas];
    
    UIView *cursor = [[UIView alloc]initWithFrame:CGRectMake(80, 400, 3, 3)];
    cursor.backgroundColor = [UIColor redColor];
    self.cursor = cursor;
    [self.view addSubview:cursor];
    
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:
                                                                  @[@"正弦曲线",
                                                                    @"圆形",
                                                                    @"矩形",
                                                                    @"贝塞尔曲线"]];
    segment.frame = CGRectMake(40, screenSize.height - 80, screenSize.width - 80, 44);
    segment.apportionsSegmentWidthsByContent = YES;
    [segment addTarget:self action:@selector(onSegmentChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segment];
    segment.selectedSegmentIndex = 0;
    [self onSegmentChanged:segment];
}

- (void)onSegmentChanged:(UISegmentedControl *)sender {
    NSInteger index = sender.selectedSegmentIndex;
    NSLog(@"segment index: %@", @(index));
    ShapeType type;
    switch (index) {
        case 0:
            type = ShapeTypeSin;
            break;
            
        case 1:
            type = ShapeTypeCircle;
            
            break;
    
        case 2:
            type = ShapeTypeRectangle;
            break;
            
        case 3:
            type = ShapeTypeBezier;
            break;
            
        default:
            break;
    }
    [self createAnimationShape:type];
}

- (void)createAnimationShape:(ShapeType)type {
    if (self.animator) {
        [self.animator invalidate];
        for (UILabel *spotLabel in self.spotArray) {
            [spotLabel removeFromSuperview];
        }
        [self.spotArray removeAllObjects];
    }
    Shape *shape = [ShapeFactory createShapeWithType:type];
    AnimationPoint *startPoint = [[AnimationPoint alloc]initWithX:CGRectGetMinX(_cursor.frame) y:CGRectGetMinY(_cursor.frame)];
    AnimationPoint *endPoint = [[AnimationPoint alloc]initWithX:300 y:400];
    Animator *animator = [Animator animateOnTarget:_cursor
                                         evaluator:shape
                                            values:@[startPoint, endPoint]];
    // 描随机点
    if (type == ShapeTypeBezier) {
        Bezier *bezier = (Bezier *)shape;
        NSInteger count = [[bezier getSpots] count];
        for (int i = 0; i < count; i++) {
            CGPoint point = CGPointFromString([bezier getSpots][i]);
            UILabel *spotLabel = [[UILabel alloc] initWithFrame:CGRectMake(point.x, point.y, 70, 30)];
            spotLabel.text = [NSString stringWithFormat:@"第%@个点", @(i+1)];
            spotLabel.textColor = [UIColor blackColor];
            [self.view addSubview:spotLabel];
            [self.spotArray addObject:spotLabel];
        }
    }
    [animator setDuration:6];
    [animator setDelegate:self];
    [animator start];
    self.animator = animator;
    [self.canvas drawShape:shape];
}

- (void)onAnimationUpdate:(Animator *)animation {
    [self.canvas setNeedsDisplay];
}

- (void)onAnimationStart:(Animator *)animation {
    NSLog(@"animation start");
}

- (void)onAnimationEnd:(Animator *)animation {
    NSLog(@"animation end");
}

- (void)onAnimationRepeat:(Animator *)animation {
    NSLog(@"animation repeat");
}

- (void)onAnimationCancel:(Animator *)animation {
    NSLog(@"animation cancel");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getter

- (NSMutableArray *)spotArray
{
    if (!_spotArray) {
        _spotArray = [[NSMutableArray alloc] init];
    }
    return _spotArray;
}

@end
