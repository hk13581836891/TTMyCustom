
//
//  TTSubscribeTypeView.m
//  MyCustom
//
//  Created by houke on 2018/9/17.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "TTSubscribeTypeView.h"
#import "TTSubscribeAuthorViewModel.h"
#import "TTSubscribeAuthorCell.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "MasonryHeader.h"

@interface TTSubscribeTypeView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@end
@implementation TTSubscribeTypeView
-(void)setVm:(TTSubscribeAuthorViewModel *)vm{
    _vm = vm;
    [self reloadData];
    
    //设置默认选中 cell
    [self layoutIfNeeded];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:(UICollectionViewScrollPositionNone)];
        [self collectionView:self didSelectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    });
   
}

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = TTMargin;
    layout.minimumInteritemSpacing = TTMargin;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset =UIEdgeInsetsMake(0, 20, 0, TTMargin);
    
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        self.dataSource = self;
        self.delegate = self;
        self.alwaysBounceHorizontal = YES;
        self.showsHorizontalScrollIndicator = NO;
        
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
    return [model.name sizeWithAttributes:@{NSFontAttributeName : PingFangSC_Medium(18)}];
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TTSubscribeTypeCell *cell = (TTSubscribeTypeCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.nameLab.font = PingFangSC_Medium(18);
    cell.redLine.hidden = NO;
    
    TTAuthorTypeModel *model = _vm.authorTypeArr[indexPath.item];
    NSLog(@"--%@",model.name);
    @weakify(self)
    [_vm getCategoryAuthNewsList:model.ID finish:^(bool isSuccess) {
        @strongify(self)
        [self.vm reloadCategoryTableView];
    }];
}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    TTSubscribeTypeCell *cell = (TTSubscribeTypeCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.nameLab.font = PingFangSC_Regular(16);
    cell.redLine.hidden = YES;
}
@end

#import "TTSubscribeAuthorModel.h"
@interface TTSubscribeTypeCell ()

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
        _redLine.hidden = YES;
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
        make.bottom.equalTo(self.contentView).offset(3);
        make.size.equalTo(CGSizeMake(20, 2));
    }];
}
@end

















