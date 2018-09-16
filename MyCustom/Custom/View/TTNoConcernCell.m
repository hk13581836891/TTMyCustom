//
//  TTNoConcernCell.m
//  MyCustom
//
//  Created by houke on 2018/9/12.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "TTNoConcernCell.h"
#import "TTNoConcernView.h"
#import "TTConcernTeamViewModel.h"

//#define itemW (UIScreen.mainScreen.bounds.size.width - 20 *2 - 26 *3)/4
//#define itemH itemW + 6+ 16
@interface TTNoConcernCell ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIButton *finishBtn;
@property (nonatomic, strong) TTNoConcernView *teamView;
@end

@implementation TTNoConcernCell
-(void)setVm:(TTConcernTeamViewModel *)vm{
    _vm = vm;
    _teamView.vm = vm;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}
#pragma mark 懒加载控件

-(UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithText:@"选择你的立场" textColor:HEXCOLOR(0x222222) font:PingFangSC_Medium(14)];
    }
    return _titleLab;
}
-(UIButton *)finishBtn
{
    if (!_finishBtn) {
        _finishBtn = [[UIButton alloc] initWithText:nil backImage:[UIImage imageNamed:@"custom_unfinish_btn"] highlightedImage:[UIImage imageNamed:@"custom_finish_btn"]];
    }
    return _finishBtn;
}
-(TTNoConcernView *)teamView{
    if (!_teamView) {
        _teamView = [TTNoConcernView new];
    }
    return _teamView;
}
-(void)setupUI{
    
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.finishBtn];
    [self.contentView addSubview:self.teamView];
    
    [_titleLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(TTMargin);
        make.top.equalTo(self.contentView).offset(TTMargin);
    }];
    [_finishBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab);
        make.right.equalTo(self.contentView).offset(-TTMargin);
    }];
    [_teamView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.finishBtn.bottom).offset(TTMargin);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.height.equalTo(itemH * 3 + 16 * 2 + TTMargin);
        
        make.bottom.equalTo(self.contentView);
    }];
}

@end
