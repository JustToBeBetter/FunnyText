//
//  LJZReversibleAnimationController.h
//  FunnyText
//
//  Created by 李金柱 on 16/3/31.
//  Copyright © 2016年 likeme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LJZReversibleAnimationController : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL reverse;//动画方向

@property (nonatomic, assign) NSTimeInterval duration;//动画时间

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView;

@end
