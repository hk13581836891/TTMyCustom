//
//  MainNavView.m
//  Titan_ios
//
//  Created by RichyLeo on 15/4/23.
//  Copyright (c) 2015年 RichyLeo. All rights reserved.
//

#import "MainNavView.h"
#import "ColorContants.h"

@implementation MainNavView

-(id)initWebViewNavWithColor:(UIColor *)color andTaget:(id)taget andAction:(SEL)action andTitle:(NSString *)title andShareAction:(SEL)shareAction
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATION_BAR_HEIGHT)];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    
        UIImage *image = [UIImage imageNamed:@"back_black"];
        _imgV=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, image.size.width, image.size.height)];
        _imgV.center = CGPointMake(10+image.size.width/2, STATUS_BAR_HEIGHT + NAV_OTHER_HEIGHT/2);
        _imgV.image= image;
        [self addSubview:_imgV];
        
        UIButton *btu=[UIButton buttonWithType:UIButtonTypeSystem];
        btu.frame=CGRectMake(0, STATUS_BAR_HEIGHT, 80, NAV_OTHER_HEIGHT);
        [btu setTitle:nil forState:UIControlStateNormal];
        [btu addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btu];
        
        _titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(80, STATUS_BAR_HEIGHT,SCREEN_WIDTH-160, NAV_OTHER_HEIGHT)];
        _titleLabel.text=title;
        _titleLabel.tag = 11;
        _titleLabel.textColor = HEXCOLOR(0x333333);
        _titleLabel.font=PingFangSC_Regular(19);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -50, STATUS_BAR_HEIGHT, 40,NAV_OTHER_HEIGHT)];
        [shareBtn setImage:[UIImage imageNamed:@"ad_share_black"] forState:UIControlStateNormal];
        [shareBtn setImage:[UIImage imageNamed:@"ad_share_black"] forState:UIControlStateHighlighted];
        shareBtn.tag = 12;
        [shareBtn addTarget:taget action:shareAction forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:shareBtn];

        _line = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT - 0.5, SCREEN_WIDTH, 0.5)];
        _line.backgroundColor = HEXCOLOR(0xebebeb);
        [self addSubview:_line];
    }
    return self;
    
}
//
//-(id)initWithColor:(UIColor *)color andTitle:(NSString *)title
//{
//    self=[super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATION_BAR_HEIGHT)];
//    if (self) {
//        self.backgroundColor= WhiteColor;
//
//        _titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(40, STATUS_BAR_HEIGHT,SCREEN_WIDTH-80, NAV_OTHER_HEIGHT)];
//        _titleLabel.text=title;
//        _titleLabel.tag = 11;
//        _titleLabel.textAlignment=NSTextAlignmentCenter;
//        _titleLabel.textColor= ColorUserTitle;
//        _titleLabel.font= PingFangSC_Medium(18);
//        [self addSubview:_titleLabel];
//        
//        _line = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT - 0.5, SCREEN_WIDTH, 0.5)];
//        _line.backgroundColor = [SingleTon colorWithHexString:@"ebebeb"];
//        [self addSubview:_line];
//        
//    }
//    return self;
//}
-(id)initWithColor:(UIColor *)color andTaget1:(id)taget andAction:(SEL)action andTitle:(NSString *)title
{
    self=[super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATION_BAR_HEIGHT)];
    if (self) {

        self.backgroundColor= WhiteColor;
        
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(40, STATUS_BAR_HEIGHT,SCREEN_WIDTH-80, NAV_OTHER_HEIGHT)];
        lab.text=title;
        lab.tag = 11;
        lab.textAlignment=NSTextAlignmentCenter;
        lab.textColor = HEXCOLOR(0x333333);
        lab.font=PingFangSC_Regular(19);
        _titleLabel = lab;
        [self addSubview:lab];
        
        UIImage *image = [UIImage imageNamed:@"back_black"];
        _imgV=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, image.size.width, image.size.height)];
        _imgV.center = CGPointMake(10+image.size.width/2, STATUS_BAR_HEIGHT + NAV_OTHER_HEIGHT/2);
        _imgV.image= image;
        _imgV.tag =12;
        [self addSubview:_imgV];
        
        UIButton *btu=[UIButton buttonWithType:UIButtonTypeSystem];
        btu.tag = 13;
        btu.frame = CGRectMake(0, 0, 80, self.frame.size.height);
        [btu addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btu];
        
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT - 1, SCREEN_WIDTH, 0.5)];
        _line.backgroundColor = HEXCOLOR(0xebebeb);
        [self addSubview:_line];
        
    }
    return self;
}
//-(id)initWithframe:(CGRect)frame andColor:(UIColor *)color andleftBtnTarget:(id)taget andleftBtnAction:(SEL)action andTitle:(NSString *)title
//{
//    if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATION_BAR_HEIGHT)]) {
//        self.backgroundColor = WhiteColor;
//        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, STATUS_BAR_HEIGHT, SCREEN_WIDTH-100, NAV_OTHER_HEIGHT)];
//        _titleLabel.text=title;
//        _titleLabel.tag = 11;
//        _titleLabel.textAlignment=NSTextAlignmentCenter;
//        _titleLabel.textColor = ColorMainBlack;
//        _titleLabel.font=PingFangSC_Regular(19);
//        [self addSubview:_titleLabel];
//        
//        UIImage *image = [UIImage imageNamed:@"back_black"];
//        UIImageView *imgV=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, image.size.width, image.size.height)];
//        imgV.center = CGPointMake(10+image.size.width/2, STATUS_BAR_HEIGHT + NAV_OTHER_HEIGHT/2);
//        imgV.image= image;
//        imgV.tag =12;
//        [self addSubview:imgV];
//        
//        UIButton *btu=[UIButton buttonWithType:UIButtonTypeSystem];
//        btu.frame=CGRectMake(0, 0, 80, frame.size.height);
//        [btu setTitle:nil forState:UIControlStateNormal];
//        [btu addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:btu];
//        
//        _line = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT -0.5, SCREEN_WIDTH, 0.5)];
//        _line.backgroundColor = [SingleTon colorWithHexString:@"ebebeb"];
//        [self addSubview:_line];
//        
//    }
//    return self;
//}
//-(id)initWithFrame:(CGRect)frame andColorR:(float)r andColorG:(float)g andColorB:(float)b andTaget1:(id)taget andAction:(SEL)action andTitle:(NSString *)title andTitleImage:(NSString *)titleIma
//{
//    self=[super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATION_BAR_HEIGHT)];
//    if (self) {
//        self.backgroundColor= WhiteColor;
//
//        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(40, STATUS_BAR_HEIGHT,SCREEN_WIDTH-80, NAV_OTHER_HEIGHT)];
//        lab.text=title;
//        lab.tag = 11;
//        lab.textAlignment=NSTextAlignmentCenter;
//        lab.textColor=ColorMainBlack;
//        lab.font=PingFangSC_Regular(19);
//        [self addSubview:lab];
//        
//        UIImageView *titleImage=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-28,  30, 56, 20)];
//        titleImage.image=[UIImage imageNamed:titleIma];
//        [self addSubview:titleImage];
//        
//        UIImage *image = [UIImage imageNamed:@"back_black"];
//        UIImageView *imgV=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, image.size.width, image.size.height)];
//        imgV.center = CGPointMake(10+image.size.width/2, STATUS_BAR_HEIGHT + NAV_OTHER_HEIGHT/2);
//        imgV.image= image;
//        imgV.tag =12;
//        [self addSubview:imgV];
//        
//        UIButton *btu=[UIButton buttonWithType:UIButtonTypeSystem];
//        btu.frame=CGRectMake(0, 0, 80, frame.size.height);
//        [btu setTitle:nil forState:UIControlStateNormal];
//        [btu addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:btu];
//        
//        _line = [[UIView alloc] initWithFrame:CGRectMake(0,  NAVIGATION_BAR_HEIGHT -0.5, SCREEN_WIDTH, 0.5)];
//        _line.backgroundColor = [SingleTon colorWithHexString:@"ebebeb"];
//        [self addSubview:_line];
//        
//    }
//    return self;
//}
//-(id)initWithframeMatch:(CGRect)frame andColor:(UIColor *)color andleftBtnTarget:(id)taget andleftBtnAction:(SEL)action andTitle:(NSString *)title
//{
//    if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATION_BAR_HEIGHT)]) {
//        self.backgroundColor = WhiteColor;
//        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, STATUS_BAR_HEIGHT, SCREEN_WIDTH-100, NAV_OTHER_HEIGHT)];
//        _titleLabel.text=title;
//        _titleLabel.tag = 11;
//        _titleLabel.textAlignment=NSTextAlignmentCenter;
//        _titleLabel.textColor = ColorMainBlack;
//        _titleLabel.font=PingFangSC_Regular(17);
//        [self addSubview:_titleLabel];
//        
//        UIImage *image = [UIImage imageNamed:@"back_white"];
//        _imgV=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, image.size.width, image.size.height)];
//        _imgV.center = CGPointMake(10+image.size.width/2, STATUS_BAR_HEIGHT + NAV_OTHER_HEIGHT/2);
//        _imgV.image= image;
//        _imgV.tag =12;
//        [self addSubview:_imgV];
//        
//        UIButton *btu=[UIButton buttonWithType:UIButtonTypeSystem];
//        btu.frame=CGRectMake(0, 0, 80, frame.size.height);
//        [btu setTitle:nil forState:UIControlStateNormal];
//        [btu addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:btu];
//        
//        _line = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT -0.5, SCREEN_WIDTH, 0.5)];
//        _line.backgroundColor = [SingleTon colorWithHexString:@"ebebeb"];
//        [self addSubview:_line];
//        
//    }
//    return self;
//}
//-(instancetype)initDetailNavWithColor:(UIColor *)color andleftBtnTarget:(id)taget andleftBtnAction:(SEL)action andTitle:(NSString *)title
//{
//    if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATION_BAR_HEIGHT)]) {
//        self.backgroundColor = color;
//        
//        UIImage *titleImage = [UIImage imageNamed:@"detail_logo_title"];
//        UIImageView *imgTitle = [UIImageView new];
//        imgTitle.image = titleImage;
//        imgTitle.frame = CGRectMake((SCREEN_WIDTH- titleImage.size.width)/2, STATUS_BAR_HEIGHT +(44-titleImage.size.height)/2, titleImage.size.width, titleImage.size.height);
//        [self addSubview:imgTitle];
//        
//        UIImage *image = [UIImage imageNamed:@"back_red"];
//        _imgV=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, image.size.width, image.size.height)];
//        _imgV.center = CGPointMake(10+image.size.width/2, STATUS_BAR_HEIGHT + NAV_OTHER_HEIGHT/2);
//        _imgV.image= image;
//        _imgV.tag =12;
//        [self addSubview:_imgV];
//        
//        UIButton *btu=[UIButton buttonWithType:UIButtonTypeSystem];
//        btu.frame=CGRectMake(0, 0, 80, self.frame.size.height);
//        [btu setTitle:nil forState:UIControlStateNormal];
//        [btu addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:btu];
//        
//        _line = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT -0.5, SCREEN_WIDTH, 0.5)];
//        _line.backgroundColor = [SingleTon colorWithHexString:@"ebebeb"];
//        [self addSubview:_line];
//        
//    }
//    return self;
//}
@end
