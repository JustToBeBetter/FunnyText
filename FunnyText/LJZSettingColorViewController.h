//
//  LJZSettingColorViewController.h
//  FunnyText
//
//  Created by 李金柱 on 16/4/8.
//  Copyright © 2016年 likeme. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJZSettingColorViewController : UIViewController
@property (nonatomic) BOOL  isTextColor;
@property (nonatomic,  copy) void (^ReturnColorBlack)(NSString *hexColor, BOOL isTextColor);
@end
