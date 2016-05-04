//
//  Define.h
//  FunnyText
//
//  Created by 李金柱 on 16/4/8.
//  Copyright © 2016年 likeme. All rights reserved.
//

#import "LJZTools.h"
#import "LJZHistoryManager.h"
#import "ASValueTrackingSlider.h"
#ifndef Define_h
#define Define_h

#define kTextFont @"Helvetica"

#define kScreenSize  [UIScreen mainScreen].bounds.size

  #define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define LJZRGBColor(r, g, b)    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

#define kBackgroundColor  LJZRGBColor(225, 248, 230);

#define kMaxSpeed  5
#endif /* Define_h */
