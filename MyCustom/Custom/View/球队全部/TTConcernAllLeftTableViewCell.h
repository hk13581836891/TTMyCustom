//
//  TTConcernAllLeftTableViewCell.h
//  Tian_IOS
//
//  Created by houke on 2017/6/16.
//  Copyright © 2017年 RichyLeo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTConcernTeamModel;

@interface TTConcernAllLeftTableViewCell : UITableViewCell

@property (nonatomic, strong) void(^refreshSecondaryData)(NSNumber *pid);
@property (nonatomic, strong) TTConcernTeamModel *model;

+(instancetype)leftCell:(UITableView *)tableview;

@end
