//
//  TTNoConcernView.m
//  MyCustom
//
//  Created by houke on 2018/9/15.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "TTCustomNoConcernView.h"
#import "TTConcernTeamViewModel.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "MasonryHeader.h"

@interface TTCustomNoConcernView ()<UICollectionViewDataSource, UICollectionViewDelegate>
@end
@implementation TTCustomNoConcernView

-(void)setVm:(TTConcernTeamViewModel *)vm{
    _vm = vm;
    [self reloadData];
}
- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 26;
    layout.minimumLineSpacing = 16;
    layout.itemSize = CGSizeMake(itemW, itemH);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset =UIEdgeInsetsMake(0, 20, 0, 20);
    
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        self.scrollEnabled = NO;
        
        [self registerClass:[TTNoConcernCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([TTNoConcernCollectionCell class])];
        [self registerClass:[TTNoConcernMoreCell class] forCellWithReuseIdentifier:NSStringFromClass([TTNoConcernMoreCell class])];
        
        self.concernCount = 0;
    }
    return self;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _vm.recommendTeamArr.count > 0 ? 12 : 0;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 11) {
        TTNoConcernMoreCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TTNoConcernMoreCell class]) forIndexPath:indexPath];
        return cell;
    }
    TTNoConcernCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TTNoConcernCollectionCell class]) forIndexPath:indexPath];
    cell.model = _vm.recommendTeamArr[indexPath.item];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 11) {
       
    }
    TTNoConcernCollectionCell *cell = (TTNoConcernCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    TTConcernTeamModel *model = _vm.recommendTeamArr[indexPath.item];
    
    if ([model.status intValue] == 0) {
        @weakify(self)
        [_vm concernCancelTeam:model.ID status:@"YES" finish:^(bool isSuccess) {
            @strongify(self)
            if (isSuccess) {
                model.status = @1;
                cell.backView.backgroundColor = HEXCOLOR(0xffe7e7);
                cell.backView.layer.borderColor = HEXCOLOR(0xff2323).CGColor;
                self.concernCount ++;
            }
        }];
    }else{
        @weakify(self)
        [_vm concernCancelTeam:model.ID status:@"NO" finish:^(bool isSuccess) {
            @strongify(self)
            if (isSuccess) {
                model.status = @0;
                cell.backView.backgroundColor = HEXCOLOR(0xf6f6f6);
                cell.backView.layer.borderColor = HEXCOLOR(0xE6E6E6).CGColor;
                self.concernCount --;
            }
        }];
    }
   
}
@end

#import "UIImageView+WebCache.h"
@interface TTNoConcernCollectionCell ()
@property (nonatomic, strong) UIImageView *teamImg;
@property (nonatomic, strong) UILabel *nameLab;

@end
@implementation TTNoConcernCollectionCell

-(void)setModel:(TTConcernTeamModel *)model{
    _model = model;
    [_teamImg sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:@""]];
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
        make.top.equalTo(self.contentView).offset(1);
        make.left.equalTo(self.contentView);
        make.width.equalTo(self.frame.size.width);
        make.height.equalTo(self.frame.size.width);
    }];
    
    [_teamImg makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.backView);
        make.width.equalTo(self.backView).multipliedBy(0.6);
        make.height.equalTo(self.backView).multipliedBy(0.6);
    }];
    [_nameLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.bottom).offset(6);
        make.centerX.equalTo(self.contentView);
    }];
}
@end

@interface TTNoConcernMoreCell ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *moreImg;
@end
@implementation TTNoConcernMoreCell

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
-(UIImageView *)moreImg{
    if (!_moreImg) {
        _moreImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"more_team_big"]];
    }
    return _moreImg;
}

-(void)setupUI{
    [self.contentView addSubview:self.backView];
    [self.contentView addSubview:self.moreImg];

    [_backView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
        make.width.equalTo(self.frame.size.width);
        make.height.equalTo(self.frame.size.width);
    }];
    
    [_moreImg makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.backView);
    }];
}
@end























