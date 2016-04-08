//
//  ViewController.m
//  FunnyText
//
//  Created by 李金柱 on 16/3/31.
//  Copyright © 2016年 likeme. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "LJZBaseInteractionController.h"
#import "LJZReversibleAnimationController.h"
#import "LJZTurnAnimationController.h"
#import "LJZTextViewController.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>

- (IBAction)next:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
        AppDelegateAccessor.textAnimationController = [[LJZTurnAnimationController alloc]init];
    
}
#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    if (AppDelegateAccessor.textInteractionController) {
        [AppDelegateAccessor.textInteractionController wireToViewController:presented forOperation:LJZInteractionOperationDismiss];
    }
    
    AppDelegateAccessor.textAnimationController.reverse = NO;
    return AppDelegateAccessor.textAnimationController;
    
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    AppDelegateAccessor.textAnimationController.reverse = YES;
    return AppDelegateAccessor.textAnimationController;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return AppDelegateAccessor.textInteractionController && AppDelegateAccessor.textInteractionController.interactionInProgress ? AppDelegateAccessor.textInteractionController : nil;
}


- (IBAction)next:(id)sender {

    LJZTextViewController *VC = [[LJZTextViewController alloc]init];
    VC.transitioningDelegate = self;

    [self presentViewController:VC animated:YES completion:nil];
    
    //[self.navigationController pushViewController:[[LJZSecondViewController alloc]init] animated:YES];
}
@end
