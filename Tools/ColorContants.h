//
//  ColorContants.h
//  CCTVNews
//
//  Created by Richy Leo on 14-8-27.
//  Copyright (c) 2014年 Richy Leo. All rights reserved.
//

#ifndef CCTVNews_ColorContants_h
#define CCTVNews_ColorContants_h
/**
 * Description : 宏定义的颜色常量
 *
 */

//颜色常量
#define RGBCOLOR(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0]



//直播色
#define Text_Message_Font_Size 16
//黄色名字
#define RCTextMessageYellowColor RGBCOLOR(255, 201, 38)
//蓝色
#define RCTextMessageBlueColor RGBCOLOR(0, 127, 255)
//打赏紫色
#define RCTextMessagePurpleColor RGBCOLOR(255, 84, 255)










#define kNewRedColor ColorMainRed



//字色
#define kNightTextColor RGBCOLOR(124, 124, 124)
//线色
#define kNightLineColor RGBCOLOR(76, 76, 76)
//分割线色
#define kNightSeportLineColor RGBCOLOR(76, 76, 76)
//背景色
#define kNightBackgroudColor RGBCOLOR(39, 39, 39)
//标题色
#define kNightTitleColor RGBCOLOR(209, 209, 209)
//主题红色
#define kNightThemeColor RGBCOLOR(220, 48, 35)
//cell列表色
#define kNightListColor RGBCOLOR(52, 52, 52)
//24h蓝色
#define kNight24hBlueColor  RGBCOLOR(87, 107, 149)
//导航栏色(跟 cell一样)
#define kNightNavColor RGBCOLOR(52, 52, 52)





//正文色
#define kDayTextColor RGBCOLOR(102, 102, 102)
//24hline线色
#define kDayLineColor RGBCOLOR(235, 235, 235)
//分割线色
#define kDaySeportLineColor RGBCOLOR(204, 204, 204)
//背景色
#define kDayBackgroudColor [UIColor whiteColor]
//灰灰的背景色
#define kDayGrayBackgroudColor RGBCOLOR(242, 242, 242)
//标题色
#define kDayTitleColor RGBCOLOR(68, 68, 68)
//主题红色
#define kDayThemeColor RGBCOLOR(220, 48, 35)
//列表色
#define kDayListColor [UIColor whiteColor]
//24h蓝色
#define kDay24hBlueColor RGBCOLOR(50, 70, 99)
//评论数字色
#define kDayComColor RGBCOLOR(170 , 170, 170)
//导航栏色(跟 cell一样)
#define kDayNavColor RGBCOLOR(220, 48, 35)
//点评人的名字色
#define kDayNamelabColor RGBCOLOR(87, 107, 149)



//判断
#define isNightModel [[[NSUserDefaults standardUserDefaults] objectForKey:@"isNight"] isEqualToString:@"1"]

#define redddd HEXCOLOR(0xff3334)
#define WhiteColor [UIColor whiteColor]
#define GrayTColor RGBCOLOR(230,230,230)
#define ColorUserTitle  [SingleTon colorWithHexString:@"444444"]
#define ColorMainBlack [SingleTon colorWithHexString:@"333333"]
#define ColorMainRed [SingleTon colorWithHexString:@"f33a28"]
#define ColorMainGray [SingleTon colorWithHexString:@"999999"]
#define ColorMainBackGray [SingleTon colorWithHexString:@"f2f2f2"]
#define ColorGrayText [SingleTon colorWithHexString:@"666666"]
#define ColorGrayTime [SingleTon colorWithHexString:@"bbbbbb"]
#define ColorTBCount [SingleTon colorWithHexString:@"f6c1c0"]
#define ColorRecLine [SingleTon colorWithHexString:@"cccccc"]
#define ColorLiveBlue [SingleTon colorWithHexString:@"3a86ec"]
#define ColorBottomGray [SingleTon colorWithHexString:@"888888"]
#define ColorUpdatVideoGray [SingleTon colorWithHexString:@"cdcdcd"]
#define ColorSearchBorder [SingleTon colorWithHexString:@"c9c9c9"]
#define ColorGrayLine [SingleTon colorWithHexString:@"e5e5e5"]
#define ColorLightBlue [SingleTon colorWithHexString:@"33b2ff"]
#define ColorLigBlue [SingleTon colorWithHexString:@"5cc1ff"]
#define ColorSepGray [SingleTon colorWithHexString:@"6e6e6e"]
#define ColorFlashBlack [SingleTon colorWithHexString:@"222222"]
#define ColorCellSelect RGBCOLOR(217, 217, 217)
#define ColorSepLine [SingleTon colorWithHexString:@"e4e4e4"]
#define ColorGrayBack [SingleTon colorWithHexString:@"f5f5f5"]
#define ColorProgress [SingleTon colorWithHexString:@"aaaaaa"]
#define ColorProgressLight [SingleTon colorWithHexString:@"fafafa"]
#define ColorRed [SingleTon colorWithHexString:@"ff4d36"]
#define ColorSheetGray [SingleTon colorWithHexString:@"fcfcfc"]
#define ColorNewsAuthor [SingleTon colorWithHexString:@"555555"]

#define Center [NSNotificationCenter defaultCenter]
#endif
