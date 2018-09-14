//
//  TTConcernTopView.h
//  MyCustom
//
//  Created by houke on 2018/9/12.
//  Copyright © 2018年 houke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTConcernTeamViewModel;

@interface TTConcernTopView : UIView
@property (nonatomic, strong)  TTConcernTeamViewModel *vm;
@end

@interface TTConcernTopCollectionView : UICollectionView
@property (nonatomic, strong)  TTConcernTeamViewModel *vm;
@end

@class TTConcernTeamModel;
@interface TTConcernTopCollectionCell : UICollectionViewCell
@property (nonatomic, strong)  TTConcernTeamModel *model;
@property (nonatomic, strong) UIView *imgBackView;
@property (nonatomic, strong) UILabel *nameLab;
@end


