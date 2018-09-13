//
//  TTSubscibeAuthorView.h
//  MyCustom
//
//  Created by houke on 2018/9/13.
//  Copyright © 2018年 houke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTSbuscribeAuthorViewModel;

@interface TTSubscibeAuthorView : UICollectionView

@property (nonatomic, strong) TTSbuscribeAuthorViewModel *vm;

@end

@class TTSbuscribeAuthorModel;
@interface TTSubscibeAuthorCollectionCell : UICollectionViewCell

@property (nonatomic, strong) TTSbuscribeAuthorModel *model;
- (void)setIndexPath:(NSIndexPath *)indexPath animationStopBlock:(void (^)(NSIndexPath *))block;
@end

@interface TTSubscibeAuthorMoreCell : UICollectionViewCell

@end

