//
//  UIButton+InitExtension.m
//  MyCustom
//
//  Created by houke on 2018/9/12.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "UIButton+InitExtension.h"
#import "TTConcernTopView.h"

@implementation UIButton (InitExtension)

-(instancetype) initWithText:(NSString *)text backImage:(UIImage *)image{
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:text forState:(UIControlStateNormal)];
    [btn setBackgroundImage:image forState:(UIControlStateNormal)];
    
    [btn sizeToFit];
    return btn;
}
-(instancetype) initWithText:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font image:(UIImage *)image imgDirection:(ButtonImageDirection)direction backColor:(UIColor *)backColor hotspot:(Hotspot)hotspot{
    if (hotspot == 1) {
        EnlargeHotspotButton *btn = [EnlargeHotspotButton buttonWithType:(UIButtonTypeCustom)];
        [btn setTitle:text forState:(UIControlStateNormal)];
        [btn setTitleColor:color forState:(UIControlStateNormal)];
        btn.titleLabel.font = font;
        [btn setImage:image forState:(UIControlStateNormal)];
        [btn setBackgroundColor:backColor];
        
        [btn.titleLabel sizeToFit];
        //    [btn.imageView sizeToFit];
        [btn sizeToFit];
        [self getDirectionBtn:btn direction:direction];
        return btn;
    }
    
     ShrinkHotspotButton *btn = [ShrinkHotspotButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:text forState:(UIControlStateNormal)];
    [btn setTitleColor:color forState:(UIControlStateNormal)];
    btn.titleLabel.font = font;
    [btn setImage:image forState:(UIControlStateNormal)];
    [btn setBackgroundColor:backColor];
    
    [btn.titleLabel sizeToFit];
    //    [btn.imageView sizeToFit];
    [btn sizeToFit];
    [self getDirectionBtn:btn direction:direction];
    return btn;
    
}
-(instancetype) initWithText:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font image:(UIImage *)image imgDirection:(ButtonImageDirection)direction backColor:(UIColor *)backColor{
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:text forState:(UIControlStateNormal)];
    [btn setTitleColor:color forState:(UIControlStateNormal)];
    btn.titleLabel.font = font;
    [btn setImage:image forState:(UIControlStateNormal)];
    [btn setBackgroundColor:backColor];
    
    [btn.titleLabel sizeToFit];
    //    [btn.imageView sizeToFit];
    [btn sizeToFit];
    [self getDirectionBtn:btn direction:direction];
    return btn;
    
}
//调整按钮图片与文字位置
-(void)getDirectionBtn:(UIButton *)btn direction:(ButtonImageDirection)direction {
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
}
@end

@implementation ShrinkHotspotButton
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    //获取当前button的实际大小
    CGRect bounds = self.bounds;
    //若原热区小于44x44，则放大热区，否则保持原大小不变
    CGFloat widthDelta = fabs(44.0 - bounds.size.width);
    CGFloat heightDelta = fabs(44.0 - bounds.size.height);
    //缩小bounds
        bounds = CGRectInset(bounds, 0.5 * widthDelta, 0.5 * heightDelta);
    //如果点击的点 在 新的bounds里，就返回YES
    return CGRectContainsPoint(bounds, point);
    
}
@end

@implementation EnlargeHotspotButton
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    //获取当前button的实际大小
    CGRect bounds = self.bounds;
    //若原热区小于44x44，则放大热区，否则保持原大小不变
    CGFloat widthDelta = MAX(44.0 - bounds.size.width, 0);
    CGFloat heightDelta = MAX(44.0 - bounds.size.height, 0);
     //扩大bounds
     bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    //如果点击的点 在 新的bounds里，就返回YES
    return CGRectContainsPoint(bounds, point);
    
}
@end
