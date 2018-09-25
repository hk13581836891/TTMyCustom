//
//  TTMineCell.h
//  MyCustom
//
//  Created by houke on 2018/9/25.
//  Copyright © 2018年 houke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTMineCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *rightArrow;
@property (nonatomic, strong) UIView *redPointView;

@property (nonatomic, copy) NSDictionary *data;
@end
