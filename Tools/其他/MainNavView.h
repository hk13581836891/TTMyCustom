//
//  MainNavView.h
//  Titan_ios
//
//  Created by RichyLeo on 15/4/23.
//  Copyright (c) 2015年 RichyLeo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorContants.h"
#import "StringContants.h"
@interface MainNavView : UIView

@property (strong,nonatomic) UIView *line;
@property (strong,nonatomic)  UILabel *titleLabel;
@property (strong,nonatomic)  UIButton *AddBtn;
@property (strong,nonatomic)  UIImageView *imgV;

/**
 *  web页面
 */
-(id)initWebViewNavWithColor:(UIColor *)color andTaget:(id)taget andAction:(SEL)action andTitle:(NSString *)title andShareAction:(SEL)shareAction;

-(id)initWithColor:(UIColor *)color andTitle:(NSString *)title;
-(id)initWithColor:(UIColor *)color andTaget1:(id)taget andAction:(SEL)action andTitle:(NSString *)title;

-(id)initWithFrame:(CGRect)frame andColor:(UIColor *)color andTaget:(id)taget andAction:(SEL)action andTitle:(NSString *)title andTitleImage:(NSString *)titleIma;
-(id)initWithframe:(CGRect)frame andColor:(UIColor *)color andleftBtnTarget:(id)taget andleftBtnAction:(SEL)action andTitle:(NSString *)title ;
-(id)initWithFrame:(CGRect)frame andColorR:(float)r andColorG:(float)g andColorB:(float)b andTaget1:(id)taget andAction:(SEL)action andTitle:(NSString *)title andTitleImage:(NSString *)titleIma;
-(id)initWithframeMatch:(CGRect)frame andColor:(UIColor *)color andleftBtnTarget:(id)taget andleftBtnAction:(SEL)action andTitle:(NSString *)title;
-(instancetype)initDetailNavWithColor:(UIColor *)color andleftBtnTarget:(id)taget andleftBtnAction:(SEL)action andTitle:(NSString *)title;
@end
