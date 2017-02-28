//
//  LGCircleView.m
//  加载小球动画
//
//  Created by admin on 16/5/18.
//  Copyright © 2016年 LaiCunBa. All rights reserved.
//

#import "LGCircleView.h"

#define kNumberOfBalls 5   //小球个数
#define kRadius 10         //小球半径
#define kBallSpace 8       //小球间距
#define kDelay 0.2         //延迟时间
#define kDuration 0.6      //小球动画时间

@interface LGCircleView ()
@property (nonatomic , strong) NSArray *colorArray;  //小球颜色

@end

@implementation LGCircleView

static LGCircleView *instance;

+ (instancetype)instance
{
    if (!instance) {
        instance = [[LGCircleView alloc] init];
    }
    return instance;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.colorArray = @[[UIColor redColor], [UIColor greenColor], [UIColor orangeColor], [UIColor blueColor], [UIColor purpleColor]];
        
        self.layer.cornerRadius = kRadius;
        self.layer.masksToBounds = YES;
    }
    return self;
}

//开始动画
+ (void)showInView:(UIView *)view
{
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    [view addSubview:[self instance]];
    
    [self addBallInView:view];
}

//添加小球
+ (void)addBallInView:(UIView *)view
{
    LGCircleView *circleView = [self instance];
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    
    for (int i = 0; i < kNumberOfBalls; i++) {
        
        UIView *ballView = [self createBallWithColor:circleView.colorArray[i]];
        CGRect rect = ballView.frame;
        rect.origin.x = (i + 1) * kBallSpace + i * 2 * kRadius;
        ballView.frame = rect;
        [ballView setTransform:CGAffineTransformMakeScale(0, 0)];
        [circleView addSubview:ballView];
        
        CABasicAnimation *animation = [self creatAnimationWithDuration:kDuration Delay:i * kDelay];
        [ballView.layer addAnimation:animation forKey:@"scale"];
    }
    
    [self adjustFrameWithView:view];
}


//创建小球
+ (UIView *)createBallWithColor:(UIColor *)color
{
    UIView *circleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2 * kRadius, 2 * kRadius)];
    circleView.backgroundColor = color;
    circleView.layer.cornerRadius = kRadius;
    return circleView;
}

//创建动画
+ (CABasicAnimation *)creatAnimationWithDuration:(CGFloat)duration Delay:(CGFloat)delay
{
    CABasicAnimation *baseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    baseAnimation.fromValue = @(0.0f);
    baseAnimation.toValue = @(1.0f);
    baseAnimation.autoreverses = YES;
    baseAnimation.duration = duration;
    baseAnimation.removedOnCompletion = NO;
    baseAnimation.fillMode = kCAFillModeForwards;
    baseAnimation.repeatCount = INFINITY;
    baseAnimation.beginTime = CACurrentMediaTime() + delay;
    baseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return baseAnimation;
}

+ (void)adjustFrameWithView:(UIView *)view
{
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    LGCircleView *circleView = [self instance];
    CGRect rect = circleView.frame;
    rect.size.height = 2 * kRadius;
    rect.size.width = kNumberOfBalls * 2 * kRadius + (kNumberOfBalls + 1) * kBallSpace;
    rect.origin.x = view.center.x - rect.size.width * 0.5;
    rect.origin.y = view.center.y - rect.size.height * 0.5;
    circleView.frame = rect;
    
    //毛玻璃效果
    UIVisualEffectView *bgView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    bgView.alpha = 0.8;
    bgView.frame = circleView.bounds;
    bgView.clipsToBounds = YES;
    [circleView insertSubview:bgView atIndex:0];
}


//停止动画
+ (void)dismissInView:(UIView *)view
{
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    LGCircleView *circleView = [self instance];
    [circleView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [circleView removeFromSuperview];
}

@end
