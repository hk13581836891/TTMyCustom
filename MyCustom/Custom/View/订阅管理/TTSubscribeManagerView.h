//
//  TTSubscribeManagerView.h
//  MyCustom
//
//  Created by houke on 2018/9/17.
//  Copyright © 2018年 houke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTSubscribeTypeView.h"

@class TTSubscribeAuthorViewModel;

@interface TTSubscribeManagerView : UIView<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) TTSubscribeTypeView *typeView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic , strong) TTSubscribeAuthorViewModel *vm;
@end
