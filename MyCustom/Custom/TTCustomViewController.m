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
#import "TTSbuscribeAuthorViewModel.h"
#import "TTConcernTeamViewModel.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface TTCustomViewController ()

@property (nonatomic, strong) TTSbuscribeAuthorViewModel *authorVM;
@property (nonatomic, strong) TTConcernTeamViewModel *conTeamVM;

@end

@implementation TTCustomViewController

-(TTSbuscribeAuthorViewModel *)authorVM{
    if (!_authorVM) {
        _authorVM = [TTSbuscribeAuthorViewModel new];
    }
    return _authorVM;
}

-(TTConcernTeamViewModel *)conTeamVM{
    if (!_conTeamVM) {
        _conTeamVM  = [TTConcernTeamViewModel new];
    }
    return _conTeamVM;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableHeaderView = [[TTSetCusomView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
  
    [self.tableView registerClass:[TTSubscibeNewsCell class] forCellReuseIdentifier:NSStringFromClass([TTSubscibeNewsCell class])];
    [self.tableView registerClass:[TTSubscibeAuthorCell class] forCellReuseIdentifier:NSStringFromClass([TTSubscibeAuthorCell class])];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [self.tableView registerClass:[TTNoConcernCell class] forCellReuseIdentifier:NSStringFromClass([TTNoConcernCell class])];
    
    [self.authorVM getRecommendAutorList:^(BOOL isSuccess) {
        if (isSuccess) {
            [self.tableView reloadData];
        }
    }];
    [self.conTeamVM getConcernTeamList:^(bool isSuccess) {
        if (isSuccess) {
            [self.tableView reloadData];
        }
    }];
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _authorVM.authorArr.count > 0 ? 1 : 0;
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
        topView.vm = _conTeamVM;
        return topView;
    }
    return nil;
}

-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 80;
    }
    
    return 0.00001;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        TTSubscibeAuthorCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TTSubscibeAuthorCell class])];
        cell.vm = _authorVM;
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

@end
