//
//  TTSubscibeNewsView.m
//  MyCustom
//
//  Created by houke on 2018/9/14.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "TTSubscribeNewsView.h"

@interface TTSubscribeNewsView ()<UICollectionViewDataSource>

@end

@implementation TTSubscribeNewsView

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 8;
    layout.itemSize = CGSizeMake(240, 98);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset =UIEdgeInsetsMake(0, 0, 0, TTMargin);
    
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = HEXCOLOR(0xf3f4f5);
        self.dataSource = self;
//        self.delegate = self;
        self.alwaysBounceHorizontal = YES;
        self.showsHorizontalScrollIndicator = NO;
        
        [self registerClass:[TTSubscribeNewsCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([TTSubscribeNewsCollectionCell class])];
        
    }
    return self;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TTSubscribeNewsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TTSubscribeNewsCollectionCell class]) forIndexPath:indexPath];
    
    return cell;
}
@end

@interface TTSubscribeNewsCollectionCell ()

@property (nonatomic, strong) UIImageView *topImg;
@property (nonatomic, strong) UIView *avatarBack;
@property (nonatomic, strong) UIImageView *avatarImg;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UIView *whitBack;
@property (nonatomic, strong) UILabel *contentLab;
@end

@implementation TTSubscribeNewsCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark 懒加载创建控件
-(UIImageView *)topImg{
    if (!_topImg) {
        _topImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sub_news_topbg"]];
    }
    return _topImg;
}
-(UIView *)avatarBack{
    if (!_avatarBack) {
        _avatarBack = [[UIView alloc] initWithBackColor:UIColor.whiteColor borderColor:nil borderWidth:0 cornerRadius:12];
    }
    return _avatarBack;
}
-(UIImageView *)avatarImg{
    if (!_avatarImg) {
        _avatarImg = [[UIImageView alloc] initWithImageCircle:nil cornerRadius:11];
        _avatarImg.backgroundColor = [UIColor redColor];
    }
    return _avatarImg;
}
-(UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] initWithText:@"姓名" textColor:UIColor.whiteColor font:PingFangSC_Medium(13)];
    }
    return _nameLab;
}
-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc] initWithText:@"时间" textColor:UIColor.whiteColor font:PingFangSC_Regular(11)];
    }
    return _timeLab;
}
-(UIView *)whitBack{
    if (!_whitBack) {
        _whitBack = [[UIView alloc] initWithBackColor:UIColor.whiteColor borderColor:nil borderWidth:0 cornerRadius:4];
    }
    return _whitBack;
}
-(UILabel *)contentLab{
    if (!_contentLab) {
        _contentLab = [[UILabel alloc] initWithText:@"新闻标题" textColor:HEXCOLOR(0x222222) font:PingFangSC_Regular(13)];
    }
    return _contentLab;
}
-(void)setupUI{
    [self.contentView addSubview:self.topImg];
    [self.contentView addSubview:self.avatarBack];
    [self.contentView addSubview:self.avatarImg];
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.timeLab];
    [self.contentView addSubview:self.whitBack];
    [self.contentView addSubview:self.contentLab];

    [_topImg makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 62, 0));
    }];
    [_avatarBack makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(6);
        make.size.equalTo(CGSizeMake(24, 24));
    }];
    [_avatarImg makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.avatarBack);
        make.size.equalTo(CGSizeMake(22, 22));
    }];
    [_nameLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarBack.right).offset(8);
        make.centerY.equalTo(self.topImg);
    }];
    [_timeLab makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-8);
        make.centerY.equalTo(self.topImg);
    }];
    [_whitBack makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(36, 0, 0, 0));
    }];
}
@end

























