//
//  UILabel+InitExtension.m
//  MyCustom
//
//  Created by houke on 2018/9/12.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "UILabel+InitExtension.h"

@implementation UILabel (InitExtension)

-(instancetype) initWithText:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font {
    UILabel *lab = [UILabel new];
    lab.text = text;
    lab.textColor = color;
    lab.font = font;
    lab.numberOfLines = 0;
    lab.textAlignment = NSTextAlignmentCenter;
    [lab sizeToFit];
    return lab;
}
-(instancetype) initWithText:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font screenInset:(CGFloat )screenInset  width:(CGFloat)width{
    UILabel *lab = [UILabel new];
    lab.text = text;
    lab.textColor = color;
    lab.font = font;
    lab.numberOfLines = 0;
    if (screenInset == 0) {
        lab.textAlignment = NSTextAlignmentCenter;
    }else{
        lab.preferredMaxLayoutWidth = width - screenInset * 2;
        lab.textAlignment = NSTextAlignmentLeft;
    }
    [lab sizeToFit];
    return lab;
}
@end
