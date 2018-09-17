//
//  TTSubscribeTypeView.h
//  MyCustom
//
//  Created by houke on 2018/9/17.
//  Copyright © 2018年 houke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTSubscribeAuthorViewModel;
@interface TTSubscribeTypeView : UICollectionView
@property (nonatomic , strong) TTSubscribeAuthorViewModel *vm;
@end

@interface TTSubscribeTypeCell : UICollectionViewCell

@end
