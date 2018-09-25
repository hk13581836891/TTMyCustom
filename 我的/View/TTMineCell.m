//
//  TTMineCell.m
//  MyCustom
//
//  Created by houke on 2018/9/25.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "TTMineCell.h"
#import "MasonryHeader.h"

@implementation TTMineCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}
-(void)iconName:(NSString *)iconName titleStr:(NSString *)title{
    _iconImg.image = [UIImage imageNamed:iconName];
    _titleLab.text = title;
}
#pragma mark 懒加载创建控件
-(UIImageView *)iconImg{
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"my_icon_message"]];
    }
    return _iconImg;
}
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithText:@"我的消息" textColor:HEXCOLOR(0x222222) font:PingFangSC_Regular(13)];
    }
    return _titleLab;
}
-(UIImageView *)rightArrow{
    if (!_rightArrow) {
        _rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"my_arrow_right"]];
    }
    return _rightArrow;
}
-(void)setupUI{
    [self.contentView addSubview:self.iconImg];
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.rightArrow];
    
    [_iconImg makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(TTMargin);
        make.centerY.equalTo(self.contentView);
        make.size.equalTo(CGSizeMake(17, 17));
    }];
    [_titleLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.mas_right).offset(12);
        make.centerY.equalTo(self.contentView);
    }];
    [_rightArrow makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-TTMargin);
        make.centerY.equalTo(self.contentView);
    }];
}
@end
