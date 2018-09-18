//
//  TTMySubscribeView.h
//  MyCustom
//
//  Created by houke on 2018/9/18.
//  Copyright © 2018年 houke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTMySubscribeManageView.h"
@class TTSubscribeAuthorViewModel;

@interface TTMySubscribeView : UIView <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) TTSubscribeAuthorViewModel *vm;
@property (nonatomic, strong) TTMySubscribeManageView *manageView;
@property (nonatomic, strong) UITableView *tableView;
@end
