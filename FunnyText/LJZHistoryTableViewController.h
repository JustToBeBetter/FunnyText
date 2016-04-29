//
//  LJZHistoryTableViewController.h
//  FunnyText
//
//  Created by 李金柱 on 16/4/27.
//  Copyright © 2016年 likeme. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJZHistoryTableViewController : UITableViewController

@property (nonatomic,copy) void (^PassHistoryString)(NSString *historyString);
@end
