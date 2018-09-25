//
//  TTMineHeaderButton.m
//  MyCustom
//
//  Created by houke on 2018/9/25.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "TTMineHeaderButton.h"
#import "MasonryHeader.h"

@interface TTMineHeaderButton ()
@property(nonatomic, strong) NSString *titleStr;
@end

@implementation TTMineHeaderButton
- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        self.titleStr = title;
        [self setupUI];
    }
    return self;
}
-(UILabel *)numLab{
    if (!_numLab) {
        _numLab = [[UILabel alloc] initWithText:@"3" textColor:HEXCOLOR(0x222222) font:Arial_BoldMT(18)];
    }
    return _numLab;
}
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithText:self.titleStr textColor:HEXCOLOR(0x999999) font:PingFangSC_Regular(11)];
    }
    return _titleLab;
}
-(void)setupUI{
    [self addSubview:self.numLab];
    [self addSubview:self.titleLab];
    
    [_numLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(2);
        make.centerX.equalTo(self);
    }];
    [_titleLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.numLab.mas_bottom).offset(2);
        make.centerX.equalTo(self);
    }];
}
@end
