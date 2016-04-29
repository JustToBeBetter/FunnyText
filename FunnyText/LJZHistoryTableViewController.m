//
//  LJZHistoryTableViewController.m
//  FunnyText
//
//  Created by 李金柱 on 16/4/27.
//  Copyright © 2016年 likeme. All rights reserved.
//

#import "LJZHistoryTableViewController.h"

@interface LJZHistoryTableViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_dataArray;
}
@end

@implementation LJZHistoryTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSString *historyPath = [[LJZHistoryManager sharedInstance]getPlistPath];
    _dataArray = [NSMutableArray arrayWithContentsOfFile:historyPath];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.view.backgroundColor = kBackgroundColor;
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, 50)];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetHeight(header.frame) - 20, 120, 19)];
    title.text = @"历史";
    [header addSubview:title];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(header.frame)-1, kScreenSize.width, 1)];
    line.backgroundColor = LJZRGBColor(205, 221, 210);
    [header addSubview:line];
    self.tableView.tableHeaderView = header;
 
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenSize.width, 100)];
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.frame = CGRectMake(kScreenSize.width/6, 10, kScreenSize.width/6, 30);
    [editBtn addTarget:self action:@selector(editBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setTitle:@"完成" forState:UIControlStateSelected];
    [editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [footer addSubview:editBtn];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(4*kScreenSize.width/6, 10, kScreenSize.width/6, 30);
    [backBtn addTarget:self action:@selector(backBtnEven:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [footer addSubview:backBtn];
    
    self.tableView.tableFooterView = footer;
}
- (void)backBtnEven:(UIButton *)sender{
    [self dismiss];
}
- (void)editBtnEvent:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
       self.tableView.editing = YES;
    }else{
        [self SyncHistory];
        self.tableView.editing = NO;
    }
    
}
- (void)SyncHistory{
    
    [_dataArray writeToFile:[[LJZHistoryManager sharedInstance] getPlistPath] atomically:YES];
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"history";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text      = _dataArray[indexPath.row];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.backgroundColor = kBackgroundColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    self.PassHistoryString(_dataArray[indexPath.row]);
    [self dismiss];
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [_dataArray removeObjectAtIndex:indexPath.row];
    [self SyncHistory];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
