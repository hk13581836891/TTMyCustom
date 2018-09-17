//
//  TTSubscibeNewsCell.m
//  MyCustom
//
//  Created by houke on 2018/9/12.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "TTSubscribeNewsCell.h"
#import "TTSubscribeNewsView.h"

@interface TTSubscribeNewsCell ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) TTSubscribeNewsView *subNewsView;

@end

@implementation TTSubscribeNewsCell

-(void)setVm:(TTSubscribeAuthorViewModel *)vm{
    _vm = vm;
    _subNewsView.vm = vm;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = HEXCOLOR(0xF3F4F5);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    
    return self;
}

#pragma mark 懒加载控件

-(UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithText:@"我的订阅" textColor:HEXCOLOR(0x222222) font:PingFangSC_Medium(14)];
    }
    return _titleLab;
}

-(UIButton *)moreBtn
{
    if (!_moreBtn) {
        _moreBtn = [[UIButton alloc] initWithText:@"更多" textColor:HEXCOLOR(0x666666) font:PingFangSC_Regular(13) image:[UIImage imageNamed:@"custom_list_right"] imgDirection:1 backColor:nil];
    }
    return _moreBtn;
}

-(TTSubscribeNewsView *)subNewsView{
    if (!_subNewsView) {
        _subNewsView = [TTSubscribeNewsView new];
    }
    return _subNewsView;
}

-(void)setupUI{
    
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.moreBtn];
    [self.contentView addSubview:self.subNewsView];
    
    [_titleLab makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(TTMargin);
        make.top.equalTo(self.contentView).offset(TTMargin);
        
    }];
    
    [_moreBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab);
        make.right.equalTo(self.contentView).offset(-TTMargin);
    }];
    
    [_subNewsView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(42, TTMargin, 10 , 0));
    }];
}

@end
