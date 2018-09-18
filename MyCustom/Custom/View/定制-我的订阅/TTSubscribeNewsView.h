//
//  TTSubscibeNewsView.h
//  MyCustom
//
//  Created by houke on 2018/9/14.
//  Copyright © 2018年 houke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTSubscribeAuthorViewModel;

@interface TTSubscribeNewsView : UICollectionView
@property (nonatomic, strong) TTSubscribeAuthorViewModel *vm;
@end

@class TTSubscribeAuthorModel;
@interface TTSubscribeNewsCollectionCell: UICollectionViewCell
@property (nonatomic, strong) TTSubscribeAuthorModel *model;
@end
