//
//  UIButton+InitExtension.m
//  MyCustom
//
//  Created by houke on 2018/9/12.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "UIButton+InitExtension.h"

@implementation UIButton (InitExtension)

-(instancetype) initWithText:(NSString *)text backImage:(UIImage *)image{
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:text forState:(UIControlStateNormal)];
    [btn setBackgroundImage:image forState:(UIControlStateNormal)];
    
    [btn sizeToFit];
    return btn;
}

-(instancetype) initWithText:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font image:(UIImage *)image imgDirection:(ButtonImageDirection)direction {
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:text forState:(UIControlStateNormal)];
    [btn setTitleColor:color forState:(UIControlStateNormal)];
    btn.titleLabel.font = font;
    [btn setImage:image forState:(UIControlStateNormal)];
    
    [btn.titleLabel sizeToFit];
//    [btn.imageView sizeToFit];
    [btn sizeToFit];
    switch (direction) {
        case 0:{
            CGFloat interval = 2.0;
            btn.imageEdgeInsets = UIEdgeInsetsMake(0,-(interval / 2), 0,0);
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, (interval / 2), 0, 0);
        }break;
        case 1:{
            //图片在右
            CGSize titleSize = btn.titleLabel.bounds.size;
            CGSize imageSize = btn.imageView.bounds.size;
            CGFloat interval = 3.0;
            
            btn.imageEdgeInsets = UIEdgeInsetsMake(0,titleSize.width + interval, 0, -(titleSize.width + interval));
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width + interval), 0, imageSize.width + interval);
        }break;
        case 2:{
            //图片在上
            CGFloat offset = 5.f;
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, -btn.imageView.frame.size.width, -btn.imageView.frame.size.height-offset/2, 0);
            // button.imageEdgeInsets = UIEdgeInsetsMake(-button.titleLabel.frame.size.height-offset/2, 0, 0, -button.titleLabel.frame.size.width);
            // 由于iOS8中titleLabel的size为0，用上面这样设置有问题，修改一下即可
            btn.imageEdgeInsets = UIEdgeInsetsMake(-btn.titleLabel.intrinsicContentSize.height-offset/2, 0, 0, -btn.titleLabel.intrinsicContentSize.width);
        }break;
        case 3:{
            //图片标题都居中显示
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, -btn.imageView.frame.size.width, 0, 0);
            // button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -button.titleLabel.frame.size.width);
            // 由于iOS8中titleLabel的size为0，用上面这样设置有问题，修改一下即可
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -btn.titleLabel.intrinsicContentSize.width);
        }break;
    }
  
    
    
    return btn;
}
@end
