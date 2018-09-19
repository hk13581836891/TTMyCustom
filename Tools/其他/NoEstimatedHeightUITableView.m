//
//  NoEstimatedHeightUITableView.m
//  Tian_IOS
//
//  Created by houke on 2017/10/17.
//  Copyright © 2017年 RichyLeo. All rights reserved.
//

#import "NoEstimatedHeightUITableView.h"

@implementation NoEstimatedHeightUITableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        if (system_version>=11.0) {
            //屏蔽 ios11预加载高度
            self.estimatedRowHeight = 0;
            self.estimatedSectionHeaderHeight = 0;
            self.estimatedSectionFooterHeight = 0;
            NSLog(@"调用NoEstimatedHeightUITableView.h");
        }
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
