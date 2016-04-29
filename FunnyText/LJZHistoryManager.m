//
//  LJZHistoryManager.m
//  FunnyText
//
//  Created by 李金柱 on 16/4/27.
//  Copyright © 2016年 likeme. All rights reserved.
//

#import "LJZHistoryManager.h"
static LJZHistoryManager *g_instance = nil;

@implementation LJZHistoryManager

+ (LJZHistoryManager *)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (g_instance == nil) {
            g_instance = [[self alloc]init];
        }
    });
    return g_instance;
}
// 获取plist路径
- (NSString *)getPlistPath{
    //沙盒中的文件路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *doucumentsDirectiory = [paths objectAtIndex:0];
    
    NSString *plistPath =[doucumentsDirectiory stringByAppendingPathComponent:@"history.plist"];
    return plistPath;
}
//判断沙盒中名为plistname的文件是否存在
-(BOOL) isPlistFileExists{
    
    NSString *plistPath =[[LJZHistoryManager sharedInstance]getPlistPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if( [fileManager fileExistsAtPath:plistPath]== NO ) {
        NSLog(@"history.plist not exists");
        return NO;
    }else{
        return YES;
    }
    
}
//删除plistPath路径对应的文件
-(void)deletePlist{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *plistPath = [[LJZHistoryManager sharedInstance] getPlistPath];
    [fileManager removeItemAtPath:plistPath error:nil];
    
}

@end
