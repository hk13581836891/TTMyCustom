//
//  TTSubscibeAuthorCell.m
//  MyCustom
//
//  Created by houke on 2018/9/12.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "TTSubscibeAuthorCell.h"
#import "TTSubscibeAuthorView.h"
#import "TTSbuscribeAuthorViewModel.h"

@interface TTSubscibeAuthorCell ()

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) TTSubscibeAuthorView *subscibeView;

@end

@implementation TTSubscibeAuthorCell

-(void)setVm:(TTSbuscribeAuthorViewModel *)vm {
    _vm = vm;
    _subscibeView.vm = vm;
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
        _titleLab = [[UILabel alloc] initWithText:@"推荐大咖" textColor:HEXCOLOR(0x222222) font:PingFangSC_Medium(14)];
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

-(TTSubscibeAuthorView *)subscibeView{
    if (!_subscibeView) {
        _subscibeView = [TTSubscibeAuthorView new];
    }
    return _subscibeView;
}

-(void)setupUI{
    
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.moreBtn];
    [self.contentView addSubview:self.subscibeView];
    
    [_titleLab makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(TTMargin);
        make.top.equalTo(self.contentView).offset(TTMargin);
        
    }];
    
    [_moreBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab);
        make.right.equalTo(self.contentView).offset(-TTMargin);
    }];
    
    [_subscibeView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(42, TTMargin, 10 , 0));
    }];
}
@end

























