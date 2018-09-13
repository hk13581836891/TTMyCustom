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
    lab.textAlignment = NSTextAlignmentCenter;
    lab.numberOfLines = 0;
    [lab sizeToFit];
    return lab;
}
@end
