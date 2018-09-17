
//
//  TTSubscribeTypeView.m
//  MyCustom
//
//  Created by houke on 2018/9/17.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "TTSubscribeTypeView.h"
#import "TTSubscribeAuthorViewModel.h"

@interface TTSubscribeTypeView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@end
@implementation TTSubscribeTypeView
-(void)setVm:(TTSubscribeAuthorViewModel *)vm{
    _vm = vm;
    [self reloadData];
}
- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 20;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset =UIEdgeInsetsMake(0, 20, 0, TTMargin);
    
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        self.dataSource = self;
        self.delegate = self;
        self.alwaysBounceHorizontal = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
        
        [self registerClass:[TTSubscribeTypeCell class] forCellWithReuseIdentifier:NSStringFromClass([TTSubscribeTypeCell class])];
    }
    return self;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _vm.authorTypeArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TTSubscribeTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TTSubscribeTypeCell class]) forIndexPath:indexPath];
    cell.model = _vm.authorTypeArr[indexPath.item];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    TTAuthorTypeModel *model = _vm.authorTypeArr[indexPath.item];
    return [model.name sizeWithAttributes:@{NSFontAttributeName : PingFangSC_Regular(18)}];
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end

#import "TTSubscribeAuthorModel.h"
@interface TTSubscribeTypeCell ()

@property (nonatomic, strong) UIView *redLine;
@end
@implementation TTSubscribeTypeCell

-(void)setModel:(TTAuthorTypeModel *)model{
    _model = model;
    _nameLab.text = model.name;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = UIColor.whiteColor;
        [self setupUI];
    }
    return self;
}
#pragma mark 懒加载创建控件
-(UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] initWithText:@"分类" textColor:HEXCOLOR(0x222222) font:PingFangSC_Regular(16)];
        _nameLab.numberOfLines = 1;
        [_nameLab sizeToFit];
    }
    return _nameLab;
}
-(UIView *)redLine{
    if (!_redLine) {
        _redLine = [[UIView alloc] initWithBackColor:HEXCOLOR(0xff2323) borderColor:nil borderWidth:0 cornerRadius:1.0];
    }
    return _redLine;
}
-(void)setupUI{
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.redLine];
    
    [_nameLab makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [_redLine makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(2.5);
        make.size.equalTo(CGSizeMake(20, 2));
    }];
}
@end

















