//
//  TTCustomViewController.m
//  Tian_IOS
//
//  Created by houke on 2018/9/12.
//  Copyright © 2018年 RichyLeo. All rights reserved.
//

#import "TTCustomViewController.h"
#import "TTSubscibeAuthorCell.h"
#import "TTSubscibeNewsCell.h"
#import "TTSetCusomView.h"
#import "TTConcernTopView.h"
#import "TTNoConcernCell.h"

@interface TTCustomViewController ()

@end

@implementation TTCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = [[TTSetCusomView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
  
    [self.tableView registerClass:[TTSubscibeNewsCell class] forCellReuseIdentifier:NSStringFromClass([TTSubscibeNewsCell class])];
    [self.tableView registerClass:[TTSubscibeAuthorCell class] forCellReuseIdentifier:NSStringFromClass([TTSubscibeAuthorCell class])];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [self.tableView registerClass:[TTNoConcernCell class] forCellReuseIdentifier:NSStringFromClass([TTNoConcernCell class])];
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 20;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 215;
    }
    return 60;
}
-(UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        
        TTConcernTopView *topView = [TTConcernTopView new];
        return topView;
    }
    return nil;
}

-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 70;
    }
    
    return 0.00001;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        TTSubscibeAuthorCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TTSubscibeAuthorCell class])];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

@end
