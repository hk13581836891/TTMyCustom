//
//  TTSubscibeAuthorView.h
//  MyCustom
//
//  Created by houke on 2018/9/13.
//  Copyright © 2018年 houke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTSubscibeAuthorView : UICollectionView

@end

@interface TTSubscibeAuthorCollectionCell : UICollectionViewCell
- (void)setIndexPat:(NSIndexPath *)indexPath animationStopBlock:(void (^)(NSIndexPath *))block;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) void (^animationStopBlock)(NSIndexPath *);
@end

@interface TTSubscibeAuthorMoreCell : UICollectionViewCell

@end

