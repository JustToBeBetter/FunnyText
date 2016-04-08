//
//  AppDelegate.h
//  FunnyText
//
//  Created by 李金柱 on 16/3/31.
//  Copyright © 2016年 likeme. All rights reserved.
//

#import <UIKit/UIKit.h>

#define AppDelegateAccessor ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@class LJZReversibleAnimationController,LJZBaseInteractionController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong)  LJZReversibleAnimationController *textAnimationController;
@property (strong, nonatomic) LJZReversibleAnimationController *navigationControllerAnimationController;

@property (strong, nonatomic) LJZBaseInteractionController *navigationControllerInteractionController;

@property (strong, nonatomic) LJZBaseInteractionController *textInteractionController;
@end

