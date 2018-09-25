//
//  TTMineController.m
//  MyCustom
//
//  Created by houke on 2018/9/25.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "TTMineController.h"
#import "TTMineHeaderView.h"
#import "TTMineCell.h"

@interface TTMineController ()
@property (nonatomic, strong) UIView *sectionHeader;
@end

@implementation TTMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareTableView];
}
-(void)prepareTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
    self.tableView.contentInset = UIEdgeInsetsMake(-STATUS_BAR_HEIGHT , 0, 0, 0);
    self.tableView.backgroundColor = UIColor.whiteColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.tableHeaderView = [TTMineHeaderView new];
    
    [self.tableView registerClass:[TTMineCell class] forCellReuseIdentifier:NSStringFromClass([TTMineCell class])];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) { return 1;}
    if (section == 1) { return 3;}
    return 2;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    view.backgroundColor = HEXCOLOR(0xf5f5f5);
    return view;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TTMineCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TTMineCell class])];
    if (indexPath.section == 0) {
        [cell iconName:@"my_icon_message" titleStr:@"我的消息"];return cell;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [cell iconName:@"my_icon_vip" titleStr:@"我的会员"];return cell;
        }
        if (indexPath.row == 1) {
            [cell iconName:@"my_icon_task" titleStr:@"每日任务"];return cell;
        }
        if (indexPath.row == 2) {
            [cell iconName:@"my_icon_card" titleStr:@"我的球星卡"];return cell;
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            [cell iconName:@"my_icon_opinion" titleStr:@"意见反馈"];return cell;
        }
        if (indexPath.row == 1) {
            [cell iconName:@"my_icon_set" titleStr:@"设置"];return cell;
        }
    }
    return nil;
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
