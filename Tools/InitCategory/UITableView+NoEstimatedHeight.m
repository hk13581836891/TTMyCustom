//
//  UITableView+NoEstimatedHeight.m
//  MyCustom
//
//  Created by houke on 2018/9/18.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "UITableView+NoEstimatedHeight.h"

//#pragma message "Ignoring designated initializer warnings"
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
@implementation UITableView (NoEstimatedHeight)

-(instancetype)initWithNoEstimatedHeight:(CGRect)frame style:(UITableViewStyle)style
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:style];
    if (system_version>=11.0) {
        //屏蔽 ios11预加载高度
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
    }
    return tableView;
}
@end
