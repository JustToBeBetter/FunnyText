//
//  LJZTools.m
//  FunnyText
//
//  Created by 李金柱 on 16/4/11.
//  Copyright © 2016年 likeme. All rights reserved.
//

#import "LJZTools.h"

@implementation LJZTools

+ (UIColor *)getColorWithHexColor:(NSString *)hexColor{
    
    unsigned int red ,green,blue;
    
    NSScanner *scanner = [NSScanner scannerWithString:[hexColor substringWithRange:NSMakeRange(1, 2)]];
    [scanner scanHexInt:&red];
    
    scanner = [NSScanner scannerWithString:[hexColor substringWithRange:NSMakeRange(3, 2)]];
    [scanner scanHexInt:&green];
    
    scanner = [NSScanner scannerWithString:[hexColor substringWithRange:NSMakeRange(5, 2)]];
    [scanner scanHexInt:&blue];

    return LJZRGBColor(red, green, blue);
}
+ (BOOL) isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        
        return YES;
        
    }
    return NO;
    
}
+(CGFloat)textHeightFromTextString:(NSString *)text width:(CGFloat)textWidth fontSize:(CGFloat)size{
    
    if ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0){
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont fontWithName:kTextFont size:size]};
        CGRect rect = [text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil];
        
        return rect.size.height;
        
    }else{
        CGSize textSize = [text sizeWithFont:[UIFont fontWithName:kTextFont size:size] constrainedToSize:CGSizeMake(textWidth, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
        return textSize.height;
    }
  
}
+ (CGFloat)textWeightFromTextString:(NSString *)text height:(CGFloat)textheight fontSize:(CGFloat)size{
    
    if ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0) {
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont fontWithName:kTextFont size:size]};
        CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, textheight) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil];
        return rect.size.width;
    }else{
        CGSize textSize = [text sizeWithFont:[UIFont fontWithName:kTextFont size:size] constrainedToSize:CGSizeMake(MAXFLOAT, textheight) lineBreakMode:NSLineBreakByCharWrapping];
        return textSize.height;
    }
        
    
}
@end
