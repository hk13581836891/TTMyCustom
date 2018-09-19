//
//  TTConcernTeamView.h
//  MyCustom
//
//  Created by houke on 2018/9/18.
//  Copyright © 2018年 houke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoEstimatedHeightUITableView.h"
@class TTConcernTeamViewModel;

@interface TTConcernTeamView : UIView<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) TTConcernTeamViewModel *vm;

@property (nonatomic, strong) NoEstimatedHeightUITableView *leftTableView;
@property (nonatomic, strong) NoEstimatedHeightUITableView *rightTableView;
@end
