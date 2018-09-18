//
//  TTSubscibeAuthorView.h
//  MyCustom
//
//  Created by houke on 2018/9/13.
//  Copyright © 2018年 houke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTSubscribeAuthorViewModel;

@interface TTSubscribeAuthorView : UICollectionView

@property (nonatomic, strong) TTSubscribeAuthorViewModel *vm;
@property (nonatomic, strong) NSString *test;
@property (nonatomic, strong) void (^reloadCell)(void);
@end

@class TTSubscribeAuthorModel;
@class TTSubscribeAuthorViewModel;
@interface TTSubscribeAuthorCollectionCell : UICollectionViewCell

@property (nonatomic, strong) TTSubscribeAuthorModel *model;
@property (nonatomic, strong) TTSubscribeAuthorViewModel *vm;
- (void)setIndexPath:(NSIndexPath *)indexPath animationStopBlock:(void (^)(NSIndexPath *))block;

@property (nonatomic, strong) UIButton *subscribeBtn;
-(void)subScribeBtnClick;

@end

@interface TTSubscribeAuthorMoreCell : UICollectionViewCell

@end

