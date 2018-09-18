//
//  TTCategoryAuthorCell.m
//  MyCustom
//
//  Created by houke on 2018/9/18.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "TTCategoryAuthorCell.h"
#import "TTSubscribeAuthorViewModel.h"

@interface TTCategoryAuthorCell ()
@property (nonatomic, strong) UIImageView *avatarImg;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *descLab;
@property (nonatomic, strong) UIButton *subscribeBtn;
@end
@implementation TTCategoryAuthorCell
-(void)setVm:(TTSubscribeAuthorViewModel *)vm{
    _vm = vm;
}
-(void)setModel:(TTSubscribeAuthorModel *)model{
    _model = model;
    [_avatarImg sd_setImageWithURL:[NSURL URLWithString:model.authorHeadImage] placeholderImage:[UIImage imageNamed:@"custom_avatar_subscribe"]];
    _nameLab.text = model.authorName;
    _descLab.text = model.authorProfile;
   _subscribeBtn.selected = model.subscribestatus.intValue == 0 ? NO : YES;

}
-(void)subscribeBtnClick:(UIButton *)sender{
    
    if (!sender.selected) {
        [_vm addSubscribe:_model.authorId finish:^(bool isSuccess) {
            if (isSuccess) {
                sender.selected = !sender.selected;
            }
        }];
    }else{
        [_vm removeSubscribe:_model.authorId finish:^(bool isSuccess) {
            if (isSuccess) {
                sender.selected = !sender.selected;
            }
        }];
    }
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
        [_subscribeBtn addTarget:self action:@selector(subscribeBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return self;
}
#pragma mark 懒加载创建控件
-(UIImageView *)avatarImg{
    if (!_avatarImg) {
        _avatarImg = [[UIImageView alloc] initWithImageCircle:[UIImage imageNamed:@"custom_avatar_subscribe"] cornerRadius:45 / 2];
    }
    return _avatarImg;
}
-(UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] initWithText:@"姓名" textColor:HEXCOLOR(0x222222) font:PingFangSC_Medium(14)];
    }
    return _nameLab;
}
-(UILabel *)descLab{
    if (!_descLab) {
        _descLab = [[UILabel alloc] initWithText:@"简介" textColor:HEXCOLOR(0x6e757c) font:PingFangSC_Regular(11)];
        _descLab.numberOfLines = 1;
    }
    return _descLab;
}
-(UIButton *)subscribeBtn{
    if (!_subscribeBtn) {
        _subscribeBtn = [[UIButton alloc] initWithBackImage:[UIImage imageNamed:@"subscribe_false"] selectedImage:[UIImage imageNamed:@"subscribe_true"]];
    }
    return _subscribeBtn;
}
-(void)setupUI{
    [self.contentView addSubview:self.avatarImg];
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.descLab];
    [self.contentView addSubview:self.subscribeBtn];
    
    [_avatarImg makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(TTMargin);
        make.centerY.equalTo(self.contentView);
        make.size.equalTo(CGSizeMake(45, 45));
    }];
    [_nameLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImg.right).offset(10);
        make.top.equalTo(self.contentView).offset(18);
    }];
    [_descLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLab);
        make.bottom.equalTo(self.contentView).offset(-18);
    }];
    [_subscribeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-TTMargin);
        make.centerY.equalTo(self.avatarImg);
    }];
}
@end
