//
//  TTConcernTopView.m
//  MyCustom
//
//  Created by houke on 2018/9/12.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "TTConcernTopView.h"
#import "TTConcernTeamViewModel.h"

@interface TTConcernTopView ()

@property (nonatomic, strong) TTConcernTopCollectionView *collectionView;
@property (nonatomic, strong) UIButton *managerBtn;
@end

@implementation TTConcernTopView

-(void)setVm:(TTConcernTeamViewModel *)vm
{
    _vm = vm;
    _collectionView.vm = vm;
}

-(void)managerBtnClick{
    _managerBtn.backgroundColor = UIColor.yellowColor;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = HEXCOLOR(0xf5f5f5);
        [self setupUI];
        
        [_managerBtn addTarget:self action:@selector(managerBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return self;
}
#pragma mark 懒加载创建控件
-(TTConcernTopCollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [TTConcernTopCollectionView new];
    }
    return _collectionView;
}
-(UIButton *)managerBtn{
    if (!_managerBtn) {
        _managerBtn = [[UIButton alloc] initWithText:@"管理" textColor:HEXCOLOR(0x222222) font:PingFangSC_Regular(11) image:[UIImage imageNamed:@"more_team_circle"] imgDirection:Top backColor:UIColor.whiteColor hotspot:Shrink];
    }
    return _managerBtn;
}
-(void)setupUI{
    [self addSubview:self.collectionView];
    [self addSubview:self.managerBtn];
    
    [_collectionView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 2, 66));
    }];
    
    [_managerBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.width.equalTo(66);
        make.height.equalTo(78);
    }];

}
@end

@interface TTConcernTopCollectionView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@end
@implementation TTConcernTopCollectionView

-(void)setVm:(TTConcernTeamViewModel *)vm{
    _vm = vm;
}
- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(56, 78);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset =UIEdgeInsetsMake(0, 10, 0, TTMargin);
    
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        self.dataSource = self;
        self.delegate = self;
        self.alwaysBounceHorizontal = YES;
        self.showsHorizontalScrollIndicator = NO;
        
        [self registerClass:[TTConcernTopCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([TTConcernTopCollectionCell class])];
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
        
    }
    return self;
}
#pragma mark UICollectionView 数据源方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.vm.concernTeamArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TTConcernTopCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TTConcernTopCollectionCell class]) forIndexPath:indexPath];
    cell.model = self.vm.concernTeamArr[indexPath.item];
    return cell;
}

#pragma mark UICollectionView 代理
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TTConcernTopCollectionCell *cell = (TTConcernTopCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.imgBackView.layer.borderColor = HEXCOLOR(0x555555).CGColor;
    cell.nameLab.textColor = HEXCOLOR(0x222222);
    
}

-(void) collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TTConcernTopCollectionCell *cell = (TTConcernTopCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.imgBackView.layer.borderColor = HEXCOLOR(0xe6e6e6).CGColor;
    cell.nameLab.textColor = HEXCOLOR(0x999999);
}

@end

#define imgH 36
#import "TTConcernTeamModel.h"
@interface TTConcernTopCollectionCell ()
@property (nonatomic, strong) UIImageView *teamImg;

@end

@implementation TTConcernTopCollectionCell

-(void)setModel:(TTConcernTeamModel *)model{
    _model = model;
    [_teamImg sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    _nameLab.text = model.name;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark 懒加载创建控件
-(UIView *)imgBackView{
    if (!_imgBackView) {
        _imgBackView = [[UIView alloc] initWithBackColor:HEXCOLOR(0xf6f6f6) borderColor:HEXCOLOR(0xe6e6e6) borderWidth:0.5 cornerRadius:imgH / 2];
    }
    return _imgBackView;
}
-(UIImageView *)teamImg{
    if (!_teamImg) {
        _teamImg = [UIImageView new];
    }
    return _teamImg;
}
-(UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] initWithText:@"球队名称" textColor:HEXCOLOR(0x999999) font:PingFangSC_Regular(11)];
        _nameLab.numberOfLines = 1;
    }
    return _nameLab;
}
-(void)setupUI
{
    [self.contentView addSubview:self.imgBackView];
    [self.contentView addSubview:self.teamImg];
    [self.contentView addSubview:self.nameLab];
    
    [_imgBackView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(12);
        make.width.equalTo(imgH);
        make.height.equalTo(imgH);
    }];
    
    [_teamImg makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.imgBackView);
        make.size.equalTo(CGSizeMake(28, 28));
    }];
    [_nameLab makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imgBackView);
        make.top.equalTo(self.imgBackView.bottom).offset(3);
        make.width.equalTo(45);
    }];
}
@end























