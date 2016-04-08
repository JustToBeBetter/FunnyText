//
//  LJZNavigationController.m
//  FunnyText
//
//  Created by 李金柱 on 16/3/31.
//  Copyright © 2016年 likeme. All rights reserved.
//

#import "LJZNavigationController.h"
#import "AppDelegate.h"
#import "LJZBaseInteractionController.h"
#import "LJZReversibleAnimationController.h"

@interface LJZNavigationController ()<UINavigationControllerDelegate>

@end

@implementation LJZNavigationController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.delegate = self;
    }
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    // when a push occurs, wire the interaction controller to the to- view controller
    if (AppDelegateAccessor.navigationControllerInteractionController) {
        [AppDelegateAccessor.navigationControllerInteractionController wireToViewController:toVC forOperation:LJZInteractionOperationPop];
    }
    
    if (AppDelegateAccessor.navigationControllerAnimationController) {
        AppDelegateAccessor.navigationControllerAnimationController.reverse = operation == UINavigationControllerOperationPop;
    }
    
    return AppDelegateAccessor.navigationControllerAnimationController;
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    
    // if we have an interaction controller - and it is currently in progress, return it
    return AppDelegateAccessor.navigationControllerInteractionController && AppDelegateAccessor.navigationControllerInteractionController.interactionInProgress ? AppDelegateAccessor.navigationControllerInteractionController : nil;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
