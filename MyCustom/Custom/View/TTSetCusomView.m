//
//  TTSetCusomView.m
//  MyCustom
//
//  Created by houke on 2018/9/12.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "TTSetCusomView.h"
#import "Masonry.h"

@interface TTSetCusomView ()

@property (nonatomic, strong) UILabel *descLab;
@property (nonatomic, strong) UIButton *falseBtn;
@property (nonatomic, strong) UIButton *trueBtn;

@end

@implementation TTSetCusomView

- (void)falseBtnClick:(UIButton *)btn {
    _falseBtn.selected = !_falseBtn.selected;
    if (_falseBtn.selected) {
        [_falseBtn setBackgroundColor:HEXCOLOR(0xFF2323)];
        _falseBtn.layer.borderWidth = 0;
    }
     [_falseBtn setBackgroundColor:HEXCOLOR(0xffffff)];
    _falseBtn.layer.borderWidth = 1;
}

- (void)trueBtnClick:(UIButton *)btn {
    _trueBtn.selected = !_trueBtn.selected;
    if (_trueBtn.selected) {
         [_trueBtn setBackgroundColor:HEXCOLOR(0xffffff)];
         _trueBtn.layer.borderWidth = 1;
    }
     [_trueBtn setBackgroundColor:HEXCOLOR(0xFF2323)];
     _trueBtn.layer.borderWidth = 0;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
        
        [_falseBtn addTarget:self action:@selector(falseBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [_trueBtn addTarget:self action:@selector(trueBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return self;
}

-(UILabel *)descLab{
    if (!_descLab) {
        _descLab = [UILabel new];
        _descLab.text = @"是否将定制页设为首页，可前往个人设置页更改。";
        _descLab.textColor = HEXCOLOR(0x222222);
        _descLab.font = PingFangSC_Regular(11);
        _descLab.preferredMaxLayoutWidth = UIScreen.mainScreen.bounds.size.width - 140;
        [_descLab sizeToFit];
    }
    return _descLab;
}

-(UIButton *)falseBtn
{
    if (!_falseBtn) {
        _falseBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_falseBtn setTintColor:HEXCOLOR(0xFF2323)];
        [_falseBtn setTitle:@"否" forState:(UIControlStateNormal)];
        [_falseBtn setTitleColor:HEXCOLOR(0xFF2323) forState:(UIControlStateNormal)];
        [_falseBtn setTitleColor:HEXCOLOR(0xffffff) forState:(UIControlStateSelected)];
        _falseBtn.titleLabel.font = PingFangSC_Regular(11);
        _falseBtn.layer.cornerRadius = 11;
        _falseBtn.layer.borderWidth = 1;
        _falseBtn.layer.borderColor = HEXCOLOR(0xFF2323).CGColor;
        
    }
    return _falseBtn;
}

-(UIButton *)trueBtn
{
    if (!_trueBtn) {
        _trueBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_trueBtn setTintColor:HEXCOLOR(0xFF2323)];
        [_trueBtn setTitle:@"是" forState:(UIControlStateNormal)];
        [_trueBtn setTitleColor:HEXCOLOR(0xffffff) forState:(UIControlStateNormal)];
        [_trueBtn setTitleColor:HEXCOLOR(0xFF2323) forState:(UIControlStateSelected)];
        [_trueBtn setBackgroundColor:HEXCOLOR(0xFF2323)];
        _trueBtn.layer.cornerRadius = 11;
        _trueBtn.titleLabel.font = PingFangSC_Regular(11);
        
    }
    return _trueBtn;
}

-(void)setupUI {
    
    [self addSubview:self.descLab];
    [self addSubview:self.falseBtn];
    [self addSubview:self.trueBtn];
    
    [_descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(TTMargin);
        make.centerY.equalTo(self);
        make.width.equalTo(UIScreen.mainScreen.bounds.size.width - 140);
        make.height.equalTo(22);
    }];
    
    [_trueBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-TTMargin);
        make.centerY.equalTo(self);
        make.width.equalTo(40);
        make.height.equalTo(22);
    }];
    
    [_falseBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.trueBtn.left).offset(-TTMargin);
        make.centerY.equalTo(self);
        make.width.equalTo(40);
        make.height.equalTo(22);
    }];
}
















@end
