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
@interface TTSubscribeAuthorCollectionCell : UICollectionViewCell

@property (nonatomic, strong) TTSubscribeAuthorModel *model;
- (void)setIndexPath:(NSIndexPath *)indexPath animationStopBlock:(void (^)(NSIndexPath *))block;
@end

@interface TTSubscribeAuthorMoreCell : UICollectionViewCell

@end

