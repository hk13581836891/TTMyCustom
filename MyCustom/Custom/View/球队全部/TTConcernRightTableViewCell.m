//
//  TTConcernRightTableViewCell.m
//  Tian_IOS
//
//  Created by houke on 2017/6/16.
//  Copyright © 2017年 RichyLeo. All rights reserved.
//

#import "TTConcernRightTableViewCell.h"
#import "TTConcernTeamModel.h"
#import "TTConcernTeamViewModel.h"
#import "MasonryHeader.h"

@interface TTConcernRightTableViewCell ()
@property (nonatomic, strong) UIImageView * iconImg;
@property (nonatomic, strong) UIButton *concernBtn;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UIView *lineView;
@end
@implementation TTConcernRightTableViewCell
-(void)setVm:(TTConcernTeamViewModel *)vm{
    _vm = vm;
}
-(void)setModel:(TTConcernTeamModel *)model
{
    _model = model;
    [_iconImg sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:@"custom_avatar_subscribe"]];
    
    _nameLab.text = model.name;
    if (model.status.intValue == 0) {
        _concernBtn.selected = NO;
    }else{
        _concernBtn.selected = YES;
    }
}
-(void)concernBtnClick:(UIButton *)sender{
    [_vm concernCancelTeam:_model.ID status:_model.status.intValue == 0 ? @"YES" : @"NO" finish:^(bool isSuccess) {
        sender.selected = !sender.selected;
    }];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = HEXCOLOR(0xfbfbfb);
        [self setupUI];
        [_concernBtn addTarget:self action:@selector(concernBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return self;
}
-(UIImageView *)iconImg{
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc] initWithImageCircle:[UIImage imageNamed:@"custom_avatar_subscribe"] cornerRadius:20];
    }
    return _iconImg;
}
-(UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] initWithText:@"球队" textColor:HEXCOLOR(0x444444) font:PingFangSC_Regular(15)];
        _nameLab.numberOfLines = 1;
    }
    return _nameLab;
}
-(UIButton *)concernBtn{
    if (!_concernBtn) {
        _concernBtn = [[UIButton alloc] initWithBackImage:[UIImage imageNamed:@"subscribe_false"] selectedImage:[UIImage imageNamed:@"subscribe_true"]];
    }
    return _concernBtn;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithBackColor:HEXCOLOR(0xe4e4e4) borderColor:nil borderWidth:0 cornerRadius:0];
    }
    return _lineView;
}
-(void)setupUI{
    [self.contentView addSubview:self.iconImg];
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.concernBtn];
    [self.contentView addSubview:self.lineView];
    [_iconImg makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.centerY.equalTo(self.contentView);
        make.size.equalTo(CGSizeMake(40, 40));
    }];
    [_nameLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.right).offset(TTMargin);
        make.centerY.equalTo(self.iconImg);
    }];
    [_concernBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(self.iconImg);
    }];
    [_lineView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(64.5, 0, 0, 0));
    }];
}

@end
