//
//  TTMineCoinButton.m
//  MyCustom
//
//  Created by houke on 2018/9/25.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "TTMineCoinButton.h"
#import "MasonryHeader.h"

@interface TTMineCoinButton ()

@property (nonatomic, strong) NSString *imgName;
@property(nonatomic, strong) NSString *titleStr;
@end

@implementation TTMineCoinButton
- (instancetype)initWithImage:(NSString *)imgName title:(NSString *)title
{
    self = [super init];
    if (self) {
        self.imgName = imgName;
        self.titleStr = title;
        self.layer.cornerRadius = 4;
        [self setupUI];
    }
    return self;
}
-(UIImageView *)backImg{
    if (!_backImg) {
        _backImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.imgName]];
    }
    return _backImg;
}
-(UILabel *)countLab{
    if (!_countLab) {
        _countLab = [[UILabel alloc] initWithText:@"0" textColor:HEXCOLOR(0xffffff) font:PingFangSC_Semibold(20)];
    }
    return _countLab;
}
-(UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] initWithText:self.titleStr textColor:HEXCOLOR(0xffffff) font:PingFangSC_Regular(11)];
    }
    return _nameLab;
}
-(void)setupUI{
    [self addSubview:self.backImg];
    [self addSubview:self.countLab];
    [self addSubview:self.nameLab];
    
    [_backImg makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [_countLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(7);
        make.left.equalTo(self).offset(TTMargin);
    }];
    [_nameLab makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-7);
        make.left.equalTo(self).offset(TTMargin);
    }];
}
@end
