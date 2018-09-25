//
//  TTMineHeaderView.m
//  MyCustom
//
//  Created by houke on 2018/9/25.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "TTMineHeaderView.h"
#import "MasonryHeader.h"
#import "TTMineHeaderButton.h"
#import "TTMineCoinButton.h"

#define SCALE SCREEN_WIDTH / 375

@interface TTMineHeaderView ()
@property (nonatomic, strong) UIImageView *backImg;
@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UIImageView *lvImg;
@property (nonatomic, strong) UILabel *lvLabel;
@property (nonatomic, strong) UIButton *signBtn;
@property (nonatomic, strong) TTMineHeaderButton *topicBtn;
@property (nonatomic, strong) TTMineHeaderButton *commentBtn;
@property (nonatomic, strong) TTMineHeaderButton *likeBtn;
@property (nonatomic, strong) TTMineCoinButton *coinBtn;
@property (nonatomic, strong) TTMineCoinButton *tCoinBtn;
@end

@implementation TTMineHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, (STATUS_BAR_HEIGHT + 160 + 74) * SCALE);
        self.backgroundColor = UIColor.whiteColor;
        [self setupUI];
    }
    return self;
}
#pragma mark 懒加载创建控件
-(UIImageView *)backImg{
    if (!_backImg) {
        _backImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"my_bg_picture"]];
    }
    return _backImg;
}
-(UIImageView *)avatar{
    if (!_avatar) {
        _avatar = [[UIImageView alloc] initWithImageCircle:[UIImage imageNamed:@"my_avatar_icon"] cornerRadius:(54*SCALE) /2 ];
    }
    return _avatar;
}
-(UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] initWithText:@"体坛加" textColor:HEXCOLOR(0x222222) font:PingFangSC_Medium(16)];
        _nameLab.preferredMaxLayoutWidth = SCREEN_WIDTH - 20*SCALE *2 - 10 *2 - 54*SCALE - 72;
    }
    return _nameLab;
}
-(UIImageView *)lvImg{
    if (!_lvImg) {
        _lvImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"my_icon_lv"]];
    }
    return _lvImg;
}
-(UILabel *)lvLabel{
    if (!_lvLabel) {
        _lvLabel = [[UILabel alloc] initWithText:@"LV6:1100 / 1500" textColor:HEXCOLOR(0x999999) font:[UIFont fontWithName:([[[UIDevice currentDevice]systemVersion] floatValue] < 9.00)?@"Heiti SC":@"Arial-BoldMT" size:(12)]];
    }
    return _lvLabel;
}
-(UIButton *)signBtn{
    if (!_signBtn) {
        _signBtn = [[UIButton alloc] initWithBackImage:[UIImage imageNamed:@"my_btn_qian_01"] selectedImage:[UIImage imageNamed:@"my_btn_qian_02"]];
    }
    return _signBtn;
}
-(TTMineHeaderButton *)topicBtn{
    if (!_topicBtn) {
        _topicBtn = [TTMineHeaderButton new];_topicBtn.backgroundColor = UIColor.redColor;
    }
    return _topicBtn;
}
-(TTMineHeaderButton *)commentBtn{
    if (!_commentBtn) {
        _commentBtn = [TTMineHeaderButton new];_commentBtn.backgroundColor = UIColor.yellowColor;
    }
    return _commentBtn;
}
-(TTMineHeaderButton *)likeBtn{
    if (!_likeBtn) {
        _likeBtn = [TTMineHeaderButton new];_likeBtn.backgroundColor = UIColor.purpleColor;
    }
    return _likeBtn;
}
-(TTMineCoinButton *)coinBtn{
    if (!_coinBtn) {
        _coinBtn = [TTMineCoinButton new];_coinBtn.backgroundColor = UIColor.purpleColor;
    }
    return _coinBtn;
}
-(TTMineCoinButton *)tCoinBtn{
    if (!_tCoinBtn) {
        _tCoinBtn = [TTMineCoinButton new];_tCoinBtn.backgroundColor = UIColor.yellowColor;
    }
    return _tCoinBtn;
}
-(void)setupUI{
    [self addSubview:self.backImg];
    [self addSubview:self.avatar];
    [self addSubview:self.nameLab];
    [self addSubview:self.lvImg];
    [self addSubview:self.lvLabel];
    [self addSubview:self.signBtn];
    [self addSubview:self.topicBtn];
    [self addSubview:self.commentBtn];
    [self addSubview:self.likeBtn];
    [self addSubview:self.coinBtn];
    [self addSubview:self.tCoinBtn];
    
    [_backImg makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, (STATUS_BAR_HEIGHT +160) * SCALE));
    }];
    [_avatar makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset((STATUS_BAR_HEIGHT + 28) * SCALE);
        make.left.equalTo(self).offset(20*SCALE);
        make.size.equalTo(CGSizeMake(54 * SCALE, 54 * SCALE));
    }];
    [_nameLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar.mas_right).offset(10);
        make.centerY.equalTo(self.avatar).offset(-10);
    }];
    [_lvImg makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLab.mas_bottom).offset(8);
        make.left.equalTo(self.nameLab);
    }];
    [_lvLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lvImg);
        make.left.equalTo(self.lvImg.mas_right).offset(2.5);
    }];
    [_signBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20*SCALE);
        make.centerY.equalTo(self.avatar);
    }];
    [_commentBtn makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(75, 50));
        make.bottom.equalTo(self.backImg.mas_bottom).offset(-8);
        make.centerX.equalTo(self);
    }];
    [_topicBtn makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(75, 50));
        make.bottom.equalTo(self.backImg.mas_bottom).offset(-8);
        make.right.equalTo(self.commentBtn.mas_left).offset(-30*SCALE);
    }];
    [_likeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(75, 50));
        make.bottom.equalTo(self.backImg.mas_bottom).offset(-8);
        make.left.equalTo(self.commentBtn.mas_right).offset(30*SCALE);
    }];
    [_coinBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backImg.mas_bottom);
        make.left.equalTo(self).offset(20*SCALE);
        make.size.equalTo(CGSizeMake(162 * SCALE, 64 * SCALE));
    }];
    [_tCoinBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backImg.mas_bottom);
        make.right.equalTo(self).offset(-20*SCALE);
        make.size.equalTo(CGSizeMake(162 * SCALE, 64 * SCALE));
    }];
}
@end

























