//
//  ColorDefine.h
//  MyCustom
//
//  Created by houke on 2018/9/12.
//  Copyright © 2018年 houke. All rights reserved.
//

#ifndef ColorDefine_h
#define ColorDefine_h

#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

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

#define PingFangSC_Regular(Size) [UIFont fontWithName:([[[UIDevice currentDevice]systemVersion] floatValue] < 9.00)?@"Heiti SC":@"PingFangSC-Regular" size:(Size)]
#define PingFangSC_Medium(Size) [UIFont fontWithName:([[[UIDevice currentDevice]systemVersion] floatValue] < 9.00)?@"Heiti SC":@"PingFangSC-Medium" size:(Size)]
#define PingFangSC_Semibold(Size) [UIFont fontWithName:([[[UIDevice currentDevice]systemVersion] floatValue] < 9.00)?@"Heiti SC":@"PingFangSC-Semibold" size:(Size)]

#define TTMargin 15

#endif /* ColorDefine_h */


