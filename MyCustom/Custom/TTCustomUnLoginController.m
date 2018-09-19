//
//  TTCustomUnLoginController.m
//  MyCustom
//
//  Created by houke on 2018/9/19.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "TTCustomUnLoginController.h"
#import "MasonryHeader.h"

@interface TTCustomUnLoginController ()
@property (nonatomic, strong) UIImageView *backImg;
@property (nonatomic, strong) UIButton *customBtn;
@end

@implementation TTCustomUnLoginController

-(void)customBtnClick{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [_customBtn addTarget:self action:@selector(customBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
}

-(UIImageView *)backImg{
    if (!_backImg) {
        _backImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"custom_no_land"]];
    }
    return _backImg;
}
-(UIButton *)customBtn{
    if (!_customBtn) {
        _customBtn = [UIButton new];
    }
    return _customBtn;
}
-(void)setupUI{
    [self.view addSubview:self.backImg];
    [self.view addSubview:self.customBtn];
    
    [_backImg makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    [_customBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backImg);
        make.bottom.equalTo(self.backImg);
        make.size.equalTo(CGSizeMake(160, 60));
    }];
}
@end
