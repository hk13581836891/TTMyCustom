//
//  TTNoConcernCell.m
//  MyCustom
//
//  Created by houke on 2018/9/12.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "TTNoConcernCell.h"
#import "TTCustomNoConcernView.h"
#import "TTConcernTeamViewModel.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "MasonryHeader.h"

@interface TTNoConcernCell ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIButton *finishBtn;
@property (nonatomic, strong) TTCustomNoConcernView *teamView;
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
-(TTCustomNoConcernView *)teamView{
    if (!_teamView) {
        _teamView = [TTCustomNoConcernView new];
        @weakify(self)
        [[_teamView rac_valuesForKeyPath:@"concernCount" observer:self] subscribeNext:^(id _Nullable x) {
            @strongify(self)
            if ([x intValue] == 0) {
                self.finishBtn.highlighted = NO;
                [self.finishBtn setBackgroundImage:[UIImage imageNamed:@"custom_unfinish_btn"] forState:(UIControlStateNormal)];
            }else{
                self.finishBtn.highlighted = YES;
                [self.finishBtn setBackgroundImage:[UIImage imageNamed:@"custom_finish_btn"] forState:(UIControlStateNormal)];
            }
        }];
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
