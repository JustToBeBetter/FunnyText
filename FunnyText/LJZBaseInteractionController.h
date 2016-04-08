//
//  LJZBaseInteractionController.h
//  FunnyText
//
//  Created by 李金柱 on 16/3/31.
//  Copyright © 2016年 likeme. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, LJZInteractionOperation) {
    /**
     Indicates that the interaction controller should start a navigation controller 'pop' navigation.
     */
    LJZInteractionOperationPop,
    /**
     Indicates that the interaction controller should initiate a modal 'dismiss'.
     */
    LJZInteractionOperationDismiss,
    /**
     Indicates that the interaction controller should navigate between tabs.
     */
    LJZInteractionOperationTab
};

@interface LJZBaseInteractionController : UIPercentDrivenInteractiveTransition
/**
 Connects this interaction controller to the given view controller.
 @param viewController The view controller which this interaction should add a gesture recognizer to.
 @param operation The operation that this interaction initiates when.
 */
- (void)wireToViewController:(UIViewController*)viewController forOperation:(LJZInteractionOperation)operation;

/**
 This property indicates whether an interactive transition is in progress.
 */
@property (nonatomic, assign) BOOL interactionInProgress;

@end
