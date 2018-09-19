//
//  UIImageView+InitExtension.m
//  MyCustom
//
//  Created by houke on 2018/9/12.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "UIImageView+InitExtension.h"

@implementation UIImageView (InitExtension)

- (instancetype)initWithImageCircle:(UIImage *)image cornerRadius:(CGFloat)cornerRadius{
    
    UIImageView *img = [[UIImageView alloc] initWithImage:image];
    img.layer.masksToBounds = YES;
    img.layer.cornerRadius = cornerRadius;
    [img sizeToFit];
    
    return img;
}
@end
