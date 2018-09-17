//
//  TTNoConcernView.h
//  MyCustom
//
//  Created by houke on 2018/9/15.
//  Copyright © 2018年 houke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTConcernTeamViewModel;

@interface TTNoConcernView : UICollectionView
@property (nonatomic, strong) TTConcernTeamViewModel *vm;
@property (nonatomic, assign) NSInteger concernCount;
@end

#define itemW (UIScreen.mainScreen.bounds.size.width - 20 *2 - 26 *3)/4
#define itemH (itemW + 6+ 16)

@class TTConcernTeamModel;
@interface TTNoConcernCollectionCell : UICollectionViewCell
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) TTConcernTeamModel *model;
@end

@interface TTNoConcernMoreCell : UICollectionViewCell

@end
