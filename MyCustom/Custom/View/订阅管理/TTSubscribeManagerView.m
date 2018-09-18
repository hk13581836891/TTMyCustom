//
//  TTSubscribeManagerView.m
//  MyCustom
//
//  Created by houke on 2018/9/17.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "TTSubscribeManagerView.h"
#import "TTSubscribeTypeView.h"
#import "TTSubscribeAuthorViewModel.h"
#import "TTCategoryAuthorCell.h"

@interface TTSubscribeManagerView ()
@property (nonatomic, strong) MainNavView *nav;

@end
@implementation TTSubscribeManagerView

-(void)setVm:(TTSubscribeAuthorViewModel *)vm{
    _vm = vm;
    self.typeView.vm = vm;
}
-(void)backBtnDown{
    [_vm getBack];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
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
    [_tableView registerClass:[TTCategoryAuthorCell class] forCellReuseIdentifier:NSStringFromClass([TTCategoryAuthorCell class])];
}
#pragma mark tableView datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _vm.categoryArr.count;
}
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTCategoryAuthorCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TTCategoryAuthorCell class]) forIndexPath:indexPath];
    TTSubscribeAuthorModel *model = _vm.categoryArr[indexPath.row];
    cell.model = model;
    cell.vm = _vm;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithBackColor:HEXCOLOR(0xf5f5f5) borderColor:nil borderWidth:0 cornerRadius:0];
     [view addSubview:self.typeView];
    [_typeView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 3, 0));
    }];
    return view;
}
#pragma mark 懒加载创建控件
-(MainNavView *)nav{
    if (!_nav) {
        _nav = [[MainNavView alloc] initWithColor:UIColor.whiteColor andTaget1:self andAction:@selector(backBtnDown) andTitle:@"添加订阅"];
    }
    return _nav;
}
-(TTSubscribeTypeView *)typeView{
    if (!_typeView) {
        _typeView = [TTSubscribeTypeView new];
    }
    return _typeView;
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












































