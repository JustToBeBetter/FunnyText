//
//  LJZTextViewController.h
//  FunnyText
//
//  Created by 李金柱 on 16/4/8.
//  Copyright © 2016年 likeme. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJZTextViewController : UIViewController

@property (nonatomic,  copy) NSString    *text;
@property (nonatomic) CGFloat  speed;
@property (nonatomic) BOOL  isV;
@property (nonatomic) BOOL  isMoving;
@end
