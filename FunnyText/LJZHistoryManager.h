//
//  LJZHistoryManager.h
//  FunnyText
//
//  Created by 李金柱 on 16/4/27.
//  Copyright © 2016年 likeme. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJZHistoryManager : NSObject

+ (LJZHistoryManager *)sharedInstance;
// 获取plist路径
- (NSString *)getPlistPath;
//判断沙盒中文件是否存在
- (BOOL)isPlistFileExists;
//删除对应的文件
- (void)deletePlist;

@end
