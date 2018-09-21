//
//  TTCustomCoverView.m
//  Tian_IOS
//
//  Created by houke on 2018/9/21.
//  Copyright © 2018年 RichyLeo. All rights reserved.
//

#import "TTCustomCoverView.h"
#import "MasonryHeader.h"

@interface TTCustomCoverView ()
@property (nonatomic, strong) UIImageView *guideImg;
@property (nonatomic, strong) UIButton *customBtn;
@property (nonatomic, strong) UIButton *jumpImg;
@end
@implementation TTCustomCoverView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = UIScreen.mainScreen.bounds;
        [self setupUI];
    }
    return self;
}
#pragma mark 懒加载创建控件
-(UIImageView *)guideImg{
    if (!_guideImg) {
        _guideImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"custom_cover_img"]];
//        _guideImg.userInteractionEnabled = YES;
    }
    return _guideImg;
}
-(UIButton *)customBtn{
    if (!_customBtn) {
        _customBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    }
    return _customBtn;
}
-(UIButton *)jumpImg{
    if (!_jumpImg) {
        _jumpImg = [[UIButton alloc] initWithBackImage:[UIImage imageNamed:@"custom_corver_jump"] selectedImage:nil];
    }
    return _jumpImg;
}
-(void)setupUI{
    [self addSubview:self.guideImg];
    [self addSubview:self.customBtn];
    [self addSubview:self.jumpImg];
    
    [_guideImg makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(60);
        make.top.equalTo(self).offset( TAB_BAR_HEIGHT + 44 + 3);
    }];
    [_customBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.guideImg);
        make.left.equalTo(self.guideImg);
        make.size.equalTo(CGSizeMake(60, 35));
    }];
    [_jumpImg makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.guideImg.mas_bottom).offset(27);
        make.centerX.equalTo(self.guideImg).offset(TTMargin);
    }];
}
@end
