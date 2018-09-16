//
//  UIButton+InitExtension.h
//  MyCustom
//
//  Created by houke on 2018/9/12.
//  Copyright © 2018年 houke. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Left,
    Right,
    Top,
    Center,
} ButtonImageDirection;

typedef enum : NSUInteger {
    Shrink,
    Enlarge,
} Hotspot;

@interface UIButton (InitExtension)

-(instancetype) initWithText:(NSString *)text backImage:(UIImage *)image highlightedImage:(UIImage *) highlightedImage;
-(instancetype) initWithText:(NSString *)text backImage:(UIImage *)image;
-(instancetype) initWithText:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font image:(UIImage *)image imgDirection:(ButtonImageDirection)direction backColor:(UIColor *)backColor;
-(instancetype) initWithText:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font image:(UIImage *)image imgDirection:(ButtonImageDirection)direction backColor:(UIColor *)backColor hotspot:(Hotspot)hotspot;

@end

@interface ShrinkHotspotButton : UIButton

@end
@interface EnlargeHotspotButton : UIButton

@end
