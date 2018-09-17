
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
        
        [self registerClass:[TTSubscribeTypeCell class] forCellWithReuseIdentifier:NSStringFromClass([TTSubscribeTypeCell class])];
    }
    return self;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _vm.mySubArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TTSubscribeTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TTSubscribeTypeCell class]) forIndexPath:indexPath];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(100, 30);
}

@end

@implementation TTSubscribeTypeCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    
}
@end
