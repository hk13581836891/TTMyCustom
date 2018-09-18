//
//  TTMySubscribeView.m
//  MyCustom
//
//  Created by houke on 2018/9/18.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "TTMySubscribeView.h"
#import "MainNavView.h"
#import "TTSubscribeAuthorViewModel.h"

@interface TTMySubscribeView ()
@property (nonatomic, strong) MainNavView *nav;
@end

@implementation TTMySubscribeView
-(void)setVm:(TTSubscribeAuthorViewModel *)vm{
    _vm = vm;
    self.manageView.vm = vm;
}
-(void)backBtnDown{
    [_vm getBack];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
        [self prepareTableView];
    }
    return self;
}
-(void)prepareTableView{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.tableHeaderView = self.manageView;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}
#pragma mark tableView dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _vm.mySubNewsArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.backgroundColor = UIColor.yellowColor;
    return cell;
}
#pragma mark 懒加载创建控件
-(MainNavView *)nav{
    if (!_nav) {
        _nav = [[MainNavView alloc] initWithColor:UIColor.whiteColor andTaget1:self andAction:@selector(backBtnDown) andTitle:@"我的订阅"];
    }
    return _nav;
}
-(TTMySubscribeManageView *)manageView{
    if (!_manageView) {
        _manageView = [[TTMySubscribeManageView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 50)];
    }
    return _manageView;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    }
    return _tableView;
}
-(void)setupUI{
    [self addSubview:self.nav];
    [self addSubview:self.tableView];
    
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nav.bottom);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
}
@end
