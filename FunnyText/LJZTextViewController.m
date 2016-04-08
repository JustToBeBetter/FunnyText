
//
//  LJZTextViewController.m
//  FunnyText
//
//  Created by 李金柱 on 16/4/8.
//  Copyright © 2016年 likeme. All rights reserved.
//

#import "LJZTextViewController.h"

@interface LJZTextViewController ()

@end

@implementation LJZTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [self.view addGestureRecognizer:tap];
}
- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
