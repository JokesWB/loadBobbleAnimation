//
//  LGCircleView.h
//  加载小球动画
//
//  Created by admin on 16/5/18.
//  Copyright © 2016年 LaiCunBa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGCircleView : UIView

/**
 *  开始动画
 */
+ (void)showInView:(UIView *)view;

/**
 *  结束动画
 */
+ (void)dismissInView:(UIView *)view;


@end