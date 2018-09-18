//
//  TTCustomViewController.m
//  Tian_IOS
//
//  Created by houke on 2018/9/12.
//  Copyright © 2018年 RichyLeo. All rights reserved.
//

#import "TTCustomViewController.h"
#import "TTSubscribeAuthorCell.h"
#import "TTSubscribeNewsCell.h"
#import "TTSetCusomView.h"
#import "TTConcernTopView.h"
#import "TTNoConcernCell.h"
#import "TTSubscribeAuthorViewModel.h"
#import "TTConcernTeamViewModel.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "TTSubscribeManagerController.h"
#import "TTMySubscribeController.h"
#import "TTConcernTeamController.h"

@interface TTCustomViewController ()

@property (nonatomic, strong) TTSubscribeAuthorViewModel *authorVM;
@property (nonatomic, strong) TTConcernTeamViewModel *conTeamVM;
@property (nonatomic, assign) NSInteger subscribeCount;

@end

@implementation TTCustomViewController

-(TTSubscribeAuthorViewModel *)authorVM{
    if (!_authorVM) {
        _authorVM = [TTSubscribeAuthorViewModel new];
    }
    return _authorVM;
}

-(TTConcernTeamViewModel *)conTeamVM{
    if (!_conTeamVM) {
        _conTeamVM  = [TTConcernTeamViewModel new];
    }
    return _conTeamVM;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //订阅
    @weakify(self)
    [self.authorVM getSubscribeList:^(bool isSuccess) {
        @strongify(self)
        self.subscribeCount = self.authorVM.mySubArr.count;
        if (self.subscribeCount == 0) {
            [self.authorVM getRecommendAutorList:^(BOOL isSuccess) {
                if (isSuccess) {
                    [self.tableView reloadData];
                }
            }];
        }else{
            [self.authorVM getSubscribeAuthorNewsList:^(bool isSuccess) {
                if (isSuccess) {
                    [self.tableView reloadData];
                }
            }];
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareTableView];
    [self reloadData];
    [self clickEvent];
}
-(void)clickEvent{
    //订阅
    @weakify(self)
    [[self.authorVM rac_signalForSelector:@selector(pushToMySubscribe)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self)
        TTMySubscribeController *vc = [TTMySubscribeController new];
        vc.vm = self.authorVM;
        [self presentViewController:vc animated:YES completion:nil];
    }];
    
    [[_authorVM rac_signalForSelector:@selector(pushToSubscribeManager)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self)
        TTSubscribeManagerController *vc = [TTSubscribeManagerController new];
        vc.vm = self.authorVM;
        [self presentViewController:vc animated:YES completion:nil];
    }];
    
    [[_authorVM rac_signalForSelector:@selector(pushToSubscribeManager)] subscribeNext:^(RACTuple * _Nullable x) {
       @strongify(self)
        TTSubscribeManagerController *vc = [TTSubscribeManagerController new];
        vc.vm = self.authorVM;
        [self presentViewController:vc animated:YES completion:nil];
    }];
    
    //球队
    [[self.conTeamVM rac_signalForSelector:@selector(pushToConcerTeam)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self)
        TTConcernTeamController *vc = [TTConcernTeamController new];
        vc.vm = self.conTeamVM;
        [self presentViewController:vc animated:YES completion:nil];
    }];
}
-(void)prepareTableView{
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = [[TTSetCusomView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
    [self.tableView registerClass:[TTSubscribeNewsCell class] forCellReuseIdentifier:NSStringFromClass([TTSubscribeNewsCell class])];
    [self.tableView registerClass:[TTSubscribeAuthorCell class] forCellReuseIdentifier:NSStringFromClass([TTSubscribeAuthorCell class])];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [self.tableView registerClass:[TTNoConcernCell class] forCellReuseIdentifier:NSStringFromClass([TTNoConcernCell class])];
}
-(void)reloadData{
   
    //球队定制
    @weakify(self)
    [self.conTeamVM getConcernTeamList:^(bool isSuccess) {
        @strongify(self)
        if (isSuccess) {
            [self.tableView reloadData];
        }
    }];
    [self.conTeamVM getRecommendTeamDataList:^(bool isSuccess) {
        @strongify(self)
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
        return 1;
    }
    if (_conTeamVM.concernTeamArr.count > 0) {
        return 20;
    }
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (self.subscribeCount == 0) {
            return 215;
        }
        return 152;
    }
    if (_conTeamVM.concernTeamArr.count > 0) {
        return 66;
    }
    return tableView.estimatedRowHeight;
}
-(UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        if (_conTeamVM.concernTeamArr.count != 0) {
            TTConcernTopView *topView = [TTConcernTopView new];
            topView.vm = _conTeamVM;
            return topView;
        }
        return nil;
    }
    return nil;
}

-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        if (_conTeamVM.concernTeamArr.count != 0) {
            return 80;
        }
        return 0.00001;
    }
    
    return 0.00001;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (self.subscribeCount == 0) {
            TTSubscribeAuthorCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TTSubscribeAuthorCell class]) forIndexPath:indexPath];
            cell.vm = _authorVM;
            @weakify(self)
            cell.subscribeView.reloadCell = ^{
                @strongify(self);
                self.subscribeCount = 1;
                [self.authorVM getSubscribeAuthorNewsList:^(bool isSuccess) {
                    if (isSuccess) {
                        [self.tableView reloadData];
                    }
                }];
            };
            return cell;
        }else{
            TTSubscribeNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TTSubscribeNewsCell class]) forIndexPath:indexPath];
            cell.vm = _authorVM;
            return cell;
        }
    }
    if (_conTeamVM.concernTeamArr.count > 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    
        return cell;
    }
    TTNoConcernCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TTNoConcernCell class]) forIndexPath:indexPath];
    cell.vm = _conTeamVM;
    return cell;
}

@end
