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

@interface TTSubscribeManagerView ()
@property (nonatomic, strong) MainNavView *nav;

@end
@implementation TTSubscribeManagerView

-(void)setVm:(TTSubscribeAuthorViewModel *)vm{
    _vm = vm;
    _typeView.vm = vm;
}
-(void)backBtnDown{
    [_vm subscribeManagerBack];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
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
        _typeView = [TTSubscribeTypeView new]; _typeView.backgroundColor = UIColor.purpleColor;
    }
    return _typeView;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.backgroundColor = UIColor.yellowColor;
    }
    return _tableView;
}
-(void)setupUI{
    [self addSubview:self.nav];
    [self addSubview:self.typeView];
    [self addSubview:self.tableView];
    
    [_typeView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nav.bottom);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(45);
    }];
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeView.bottom);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
}
@end












































