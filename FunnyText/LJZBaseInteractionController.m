//
//  LJZBaseInteractionController.m
//  FunnyText
//
//  Created by 李金柱 on 16/3/31.
//  Copyright © 2016年 likeme. All rights reserved.
//

#import "LJZBaseInteractionController.h"

@implementation LJZBaseInteractionController


- (void)wireToViewController:(UIViewController *)viewController forOperation:(LJZInteractionOperation)operation {
    
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
    
}
@end
