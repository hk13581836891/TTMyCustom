//
//  TTSubscibeAuthorCell.h
//  MyCustom
//
//  Created by houke on 2018/9/12.
//  Copyright © 2018年 houke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTSubscribeAuthorView.h"
@class TTSubscribeAuthorViewModel;

@interface TTSubscribeAuthorCell : UITableViewCell

@property (nonatomic, strong) TTSubscribeAuthorViewModel *vm;
@property (nonatomic, strong) TTSubscribeAuthorView *subscribeView;
@end

