//
//  TTConcernTeamView.h
//  MyCustom
//
//  Created by houke on 2018/9/18.
//  Copyright © 2018年 houke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTConcernTeamViewModel;
@interface TTConcernTeamView : UIView<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) TTConcernTeamViewModel *vm;
@end
