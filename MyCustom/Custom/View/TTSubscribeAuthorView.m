//
//  TTSubscibeAuthorView.m
//  MyCustom
//
//  Created by houke on 2018/9/13.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "TTSubscribeAuthorView.h"
#import "YTAnimation.h"
#import "TTSubscribeAuthorViewModel.h"
#import <ReactiveObjC/ReactiveObjC.h>

#define itemWidth 130
#define itemHeight 158

@interface TTSubscribeAuthorView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, assign) NSInteger itmeCount;
@property (nonatomic, strong) NSMutableArray *tempArr;
@end

@implementation TTSubscribeAuthorView
-(NSMutableArray *)tempArr{
    if (!_tempArr) {
        _tempArr = [NSMutableArray array];
    }
    return _tempArr;
}
-(void)setVm:(TTSubscribeAuthorViewModel *)vm
{
    _vm = vm;
    if (vm.authorArr.count == 0) {
        return;
    }
    for (int i = 0; i < 5; i++) {
        TTSubscribeAuthorModel *model = vm.authorArr[i];
        [self.tempArr addObject:model];
    }
    for (int i = 0; i < 5; i++) {
        [_vm.authorArr removeObjectAtIndex:0];
    }
    [self reloadData];
}
- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 8;
    layout.minimumInteritemSpacing = 8;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset =UIEdgeInsetsMake(0, 0, 0, TTMargin);
    
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = HEXCOLOR(0xf3f4f5);
        self.dataSource = self;
        self.delegate = self;
        self.alwaysBounceHorizontal = YES;
        self.showsHorizontalScrollIndicator = NO;
        
        [self registerClass:[TTSubscribeAuthorCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([TTSubscribeAuthorCollectionCell class])];
        [self registerClass:[TTSubscribeAuthorMoreCell class] forCellWithReuseIdentifier:NSStringFromClass([TTSubscribeAuthorMoreCell class])];
    
    }
    return self;
}

#pragma mark collectionView数据源方法
-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.tempArr.count + 1;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.item == self.tempArr.count) {
        TTSubscribeAuthorMoreCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TTSubscribeAuthorMoreCell class]) forIndexPath:indexPath];
        return cell;
    }
    
    TTSubscribeAuthorCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TTSubscribeAuthorCollectionCell class]) forIndexPath:indexPath];
    cell.vm = _vm;
    TTSubscribeAuthorModel *model = _tempArr[indexPath.item];
    cell.model = model;
    cell.hidden = NO;
    @weakify(self)
    [cell setIndexPath:indexPath animationStopBlock:^(NSIndexPath *indexPath) {
        @strongify(self)
            [self performBatchUpdates:^{
                self.userInteractionEnabled = NO;
                //delete the cell you selected
                [self.tempArr removeObjectAtIndex:indexPath.item];
                [self deleteItemsAtIndexPaths:@[indexPath]];
                
            } completion:^(BOOL finished) {
                self.userInteractionEnabled = YES;
                //作者全部订阅完成时 直接刷新为作者新闻
                if (self.tempArr.count > 0) {
                    if (self.vm.authorArr.count > 0) {
                        [self.tempArr addObject:self.vm.authorArr[0]];
                        [self.vm.authorArr removeObjectAtIndex:0];
                    }
                }else{
                    if (self.reloadCell) {
                        self.reloadCell();
                    }
                }
                [self reloadData];
            }];
    }];
    [[cell rac_signalForSelector:@selector(subScribeBtnClick)] subscribeNext:^(RACTuple * _Nullable x) {
        self.userInteractionEnabled = NO;
    }];
    return cell;
}

#pragma mark layout代理方法
-(CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == _tempArr.count) {
        return CGSizeMake(59, itemHeight);
    }
    return CGSizeMake(itemWidth, itemHeight);
}

@end

#import <ReactiveObjC/ReactiveObjC.h>
#import "TTSubscribeAuthorViewModel.h"
@interface TTSubscribeAuthorCollectionCell ()

@property (nonatomic, strong) UIImageView *avatarImg;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *descLab;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) void (^animationStopBlock)(NSIndexPath *);

@end

@implementation TTSubscribeAuthorCollectionCell
-(void)setVm:(TTSubscribeAuthorViewModel *)vm{
    _vm = vm;
}
-(void)setModel:(TTSubscribeAuthorModel *)model
{
    _model = model;
    [_avatarImg sd_setImageWithURL:[NSURL URLWithString:model.authorHeadImage] placeholderImage:[UIImage imageNamed:@"custom_avatar_subscribe"]];
    _nameLab.text = model.authorName;
    _descLab.text = model.authorProfile ? : @"  ";
    
}

- (void)setIndexPath:(NSIndexPath *)indexPath animationStopBlock:(void (^)(NSIndexPath *))block {
    
    self.indexPath = indexPath;
    self.animationStopBlock = block;
}
-(void)subScribeBtnClick {
    //添加订阅
    @weakify(self)
    [self.vm addSubscribe:_model.authorId finish:^(bool isSuccess) {
        @strongify(self)
        //2动画
        [YTAnimation fadeAnimation:self];
    }];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if ([anim valueForKey:@"animType"] ){
        self.animationStopBlock(self.indexPath);
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 4;
        [self setupUI];
        [_subscribeBtn addTarget:self action:@selector(subScribeBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return self;
}

#pragma mark 懒加载控件
-(UIImageView *)avatarImg {
    if (!_avatarImg) {
        _avatarImg = [[UIImageView alloc] initWithImageCircle:[UIImage imageNamed:@"custom_avatar_subscribe"] cornerRadius:54/2];
    }
    return _avatarImg;
}

-(UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] initWithText:@"姓名" textColor:HEXCOLOR(0x222222) font:PingFangSC_Medium(13)];
    }
    return _nameLab;
}

-(UILabel *)descLab {
    if (!_descLab) {
        _descLab = [[UILabel alloc] initWithText:@"驻欧洲记者" textColor: HEXCOLOR(0x555555) font:PingFangSC_Regular(11)];
    }
    return _descLab;
}

-(UIButton *)subscribeBtn {
    if (!_subscribeBtn) {
        _subscribeBtn = [[UIButton alloc] initWithText:nil backImage:[UIImage imageNamed:@"custom_subscribe_add"]];
    }
    return _subscribeBtn;
}
-(void)setupUI {
    [self.contentView addSubview:self.avatarImg];
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.descLab];
    [self.contentView addSubview:self.subscribeBtn];
    
    [_avatarImg makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(12);
        make.centerX.equalTo(self);
        make.width.equalTo(54);
        make.height.equalTo(54);
    }];
    
    [_nameLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImg.bottom).offset(8);
        make.centerX.equalTo(self);
    }];
    
    [_descLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLab.bottom).offset(4);
        make.centerX.equalTo(self);
    }];
    
    [_subscribeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descLab.bottom).offset(10);
        make.centerX.equalTo(self);
    }];
}
@end

@interface TTSubscribeAuthorMoreCell ()

@property (nonatomic, strong) UILabel *moreLab;
@end

@implementation TTSubscribeAuthorMoreCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 4;
        [self setupUI];
    }
    return self;
}
-(UILabel *)moreLab{
    if (!_moreLab) {
        _moreLab = [[UILabel alloc] initWithText:[self verticalText:@"+关注更多"] textColor:HEXCOLOR(0xff2323) font:PingFangSC_Regular(12)];
    }
    return _moreLab;
}
-(void)setupUI{
    [self.contentView addSubview:self.moreLab];
    
    [_moreLab makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(12);
        make.centerX.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(self.contentView);
    }];
}
-(NSString *)verticalText:(NSString *)text{
    NSMutableString * str = [[NSMutableString alloc] initWithString:text];
    NSInteger count = str.length;
    for (int i = 1; i < count; i ++) {
        [str insertString:@"\n" atIndex:i*2 - 1];
    }
    return str;
}

@end











































