//
//  LJZTools.h
//  FunnyText
//
//  Created by 李金柱 on 16/4/11.
//  Copyright © 2016年 likeme. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJZTools : NSObject

//根据色值转换为color
+ (UIColor *)getColorWithHexColor:(NSString *)hexColor;
//判断字符串是否为空
+ (BOOL) isBlankString:(NSString *)string;
//计算文本高度
+ (CGFloat)textHeightFromTextString:(NSString *)text width:(CGFloat)textWidth fontSize:(CGFloat)size;
//计算文本的宽度
+(CGFloat)textWeightFromTextString:(NSString *)text height:(CGFloat)textheight fontSize:(CGFloat)size;
@end
