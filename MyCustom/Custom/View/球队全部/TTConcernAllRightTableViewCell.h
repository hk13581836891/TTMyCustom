//
//  TTConcernAllRightTableViewCell.h
//  Tian_IOS
//
//  Created by houke on 2017/6/16.
//  Copyright © 2017年 RichyLeo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTConcernTeamModel;

@interface TTConcernAllRightTableViewCell : UITableViewCell

@property (nonatomic, strong) TTConcernTeamModel *model;
@property (nonatomic, strong) void (^addRecommendFail)(NSString *error);
+(instancetype)rightCell:(UITableView *)tableview;
@end
