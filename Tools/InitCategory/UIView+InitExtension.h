//
//  UIView+InitExtension.h
//  MyCustom
//
//  Created by houke on 2018/9/14.
//  Copyright © 2018年 houke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (InitExtension)
-(instancetype) initWithBackColor:(UIColor *)backColor borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius;
@end
