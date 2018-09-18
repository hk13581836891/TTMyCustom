//
//  TTCategoryAuthorCell.h
//  MyCustom
//
//  Created by houke on 2018/9/18.
//  Copyright © 2018年 houke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTSubscribeAuthorModel;
@class TTSubscribeAuthorViewModel;

@interface TTCategoryAuthorCell : UITableViewCell
@property (nonatomic, strong) TTSubscribeAuthorModel *model;
@property (nonatomic, strong) TTSubscribeAuthorViewModel *vm;

@end
