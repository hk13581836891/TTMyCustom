//
//  UIView+InitExtension.m
//  MyCustom
//
//  Created by houke on 2018/9/14.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "UIView+InitExtension.h"

@implementation UIView (InitExtension)

#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
-(instancetype)initWithBackColor:(UIColor *)backColor borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius{
    
    UIView *view = [UIView new];
    view.backgroundColor = backColor;
    view.layer.borderColor = borderColor.CGColor;
    view.layer.borderWidth = borderWidth;
    view.layer.cornerRadius = cornerRadius;
    
    return view;
}
@end
