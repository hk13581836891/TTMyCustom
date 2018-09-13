//
//  TTSubscibeAuthorView.m
//  MyCustom
//
//  Created by houke on 2018/9/13.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "TTSubscibeAuthorView.h"
#import "YTAnimation.h"


#define itmeWidth 130
#define itmeHeight 158

@interface TTSubscibeAuthorView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, assign) NSInteger itmeCount;
@end

@implementation TTSubscibeAuthorView

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
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
        
        [self registerClass:[TTSubscibeAuthorCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([TTSubscibeAuthorCollectionCell class])];
        [self registerClass:[TTSubscibeAuthorMoreCell class] forCellWithReuseIdentifier:NSStringFromClass([TTSubscibeAuthorMoreCell class])];
        
        self.itmeCount = 5;
    }
    return self;
}

#pragma mark collectionView数据源方法
-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"--%i", self.itmeCount);
    return _itmeCount + 1;
}
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.item == _itmeCount) {
        TTSubscibeAuthorMoreCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TTSubscibeAuthorMoreCell class]) forIndexPath:indexPath];
        return cell;
    }
    
    TTSubscibeAuthorCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TTSubscibeAuthorCollectionCell class]) forIndexPath:indexPath];
    cell.indexPath = indexPath;
    [cell setAnimationStopBlock:^(NSIndexPath *indexPath) {
        NSLog(@"---%@",[NSThread currentThread]);
                    [self performBatchUpdates:^{
        
                        //delete the cell you selected
                        //        [sourceArr removeObjectAtIndex:indexPath.row];
                        self.itmeCount = self.itmeCount - 1;
                        [self deleteItemsAtIndexPaths:@[indexPath]];
        
                    } completion:^(BOOL finished) {
        
                        [self reloadData];
                    }];
    }];
//    [cell setIndexPat:indexPath animationStopBlock:^(NSIndexPath *indexPath) {
//
//        NSLog(@"---%@",[NSThread currentThread]);
//            [self performBatchUpdates:^{
//
//                //delete the cell you selected
//                //        [sourceArr removeObjectAtIndex:indexPath.row];
//                self.itmeCount = self.itmeCount - 1;
//                [self deleteItemsAtIndexPaths:@[indexPath]];
//
//            } completion:^(BOOL finished) {
//
//                [self reloadData];
//            }];
//    }];
    return cell;
}
#pragma mark layout代理方法
-(CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item < _itmeCount) {
        return CGSizeMake(itmeWidth, itmeHeight);
    }
    return CGSizeMake(59, itmeHeight);
}

@end


@interface TTSubscibeAuthorCollectionCell ()

@property (nonatomic, strong) UIImageView *avatarImg;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *descLab;
@property (nonatomic, strong) UIButton *subscibeBtn;

@end

@implementation TTSubscibeAuthorCollectionCell

- (void)setIndexPat:(NSIndexPath *)indexPath animationStopBlock:(void (^)(NSIndexPath *))block {
    
//    self.indexPath = indexPath;
//    self.animationStopBlock = block;
//    self.nameLab.text = [NSString stringWithFormat:@"%i",self.indexPath.item];
}
-(void)subScribeBtnClick {
    
    [YTAnimation fadeAnimation:self];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    self.animationStopBlock(self.indexPath);
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 4;
        [self setupUI];
        [_subscibeBtn addTarget:self action:@selector(subScribeBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return self;
}

#pragma mark 懒加载控件
-(UIImageView *)avatarImg {
    if (!_avatarImg) {
        _avatarImg = [[UIImageView alloc] initWithImageCircle:[UIImage imageNamed:@"custom_avatar_subscribe"]];
        _avatarImg.backgroundColor = [UIColor yellowColor];
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

-(UIButton *)subscibeBtn {
    if (!_subscibeBtn) {
        _subscibeBtn = [[UIButton alloc] initWithText:nil backImage:[UIImage imageNamed:@"custom_subscribe_add"]];
    }
    return _subscibeBtn;
}
-(void)setupUI {
    [self.contentView addSubview:self.avatarImg];
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.descLab];
    [self.contentView addSubview:self.subscibeBtn];
    
    [_avatarImg makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(12);
        make.centerX.equalTo(self);
    }];
    
    [_nameLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImg.bottom).offset(8);
        make.centerX.equalTo(self);
    }];
    
    [_descLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLab.bottom).offset(4);
        make.centerX.equalTo(self);
    }];
    
    [_subscibeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descLab.bottom).offset(10);
        make.centerX.equalTo(self);
    }];
}
@end

@interface TTSubscibeAuthorMoreCell ()

@property (nonatomic, strong) UILabel *moreLab;
@end

@implementation TTSubscibeAuthorMoreCell

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












































