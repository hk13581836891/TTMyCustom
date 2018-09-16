//
//  TTNoConcernView.m
//  MyCustom
//
//  Created by houke on 2018/9/15.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "TTNoConcernView.h"

@interface TTNoConcernView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@end
@implementation TTNoConcernView

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 26;
    layout.minimumLineSpacing = 16;
    layout.itemSize = CGSizeMake(itemW, itemH);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset =UIEdgeInsetsMake(TTMargin, 20, TTMargin, 20);
    
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        self.scrollEnabled = NO;
        
        [self registerClass:[TTNoConcernCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([TTNoConcernCollectionCell class])];
        
    }
    return self;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 16;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TTNoConcernCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TTNoConcernCollectionCell class]) forIndexPath:indexPath];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end

@interface TTNoConcernCollectionCell ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *teamImg;
@property (nonatomic, strong) UILabel *nameLab;

@end
@implementation TTNoConcernCollectionCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
#pragma mark 懒加载创建控件
-(UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] initWithBackColor:HEXCOLOR(0xf6f6f6) borderColor:HEXCOLOR(0xe6e6e6) borderWidth:0.5 cornerRadius: (self.frame.size.width / 2)];
    }
    return _backView;
}
-(UIImageView *)teamImg{
    if (!_teamImg) {
        _teamImg = [UIImageView new];
    }
    return _teamImg;
}
-(UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] initWithText:@"球队名称" textColor:HEXCOLOR(0x222222) font:PingFangSC_Regular(11)];
    }
    return _nameLab;
}
-(void)setupUI{
    [self.contentView addSubview:self.backView];
    [self.contentView addSubview:self.teamImg];
    [self.contentView addSubview:self.nameLab];
    
    [_backView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
        make.width.equalTo(self.frame.size.width);
        make.height.equalTo(self.frame.size.width);
    }];
    
    [_teamImg makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.backView);
        make.width.equalTo(self.backView).multipliedBy(0.75);
        make.height.equalTo(self.backView).multipliedBy(0.75);
    }];
    [_nameLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.bottom).offset(6);
        make.centerX.equalTo(self.contentView);
    }];
}
@end
























