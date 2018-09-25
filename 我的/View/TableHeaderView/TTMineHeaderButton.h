//
//  TTMineHeaderButton.h
//  MyCustom
//
//  Created by houke on 2018/9/25.
//  Copyright © 2018年 houke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTMineHeaderButton : UIButton

@property(nonatomic, strong) UILabel *numLab;
@property(nonatomic, strong) UILabel *titleLab;
@property(nonatomic, strong) UIView *redPointView;

- (instancetype)initWithTitle:(NSString *)title;
@end
