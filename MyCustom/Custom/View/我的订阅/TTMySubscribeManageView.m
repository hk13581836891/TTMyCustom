//
//  TTMySubscribeManageView.m
//  MyCustom
//
//  Created by houke on 2018/9/18.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "TTMySubscribeManageView.h"
#import "TTSubscribeAuthorViewModel.h"
#import "MasonryHeader.h"

@interface TTMySubscribeManageView ()
@property (nonatomic, strong) UIButton *manageBtn;
@end

@implementation TTMySubscribeManageView

-(void)setVm:(TTSubscribeAuthorViewModel *)vm{
    _vm = vm;
}
-(void)mangeBtnClick{
    [_vm pushToSubscribeManager];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = HEXCOLOR(0xf5f5f5);
        [self setupUI];
        [_manageBtn addTarget:self action:@selector(mangeBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return self;
}
#pragma mark 懒加载创建控件
-(UIButton *)manageBtn{
    if (!_manageBtn) {
        _manageBtn = [[UIButton alloc] initWithText:@"管理订阅" textColor:HEXCOLOR(0x222222) font:PingFangSC_Regular(14) image:[UIImage imageNamed:@"add_sub_author"] imgDirection:Left backColor:UIColor.whiteColor];
        _manageBtn.layer.cornerRadius = 19;
    }
    return _manageBtn;
}
-(void)setupUI{
    [self addSubview:self.manageBtn];
    [_manageBtn makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(UIScreen.mainScreen.bounds.size.width - TTMargin * 2);
        make.height.equalTo(38);
    }];
}
@end
