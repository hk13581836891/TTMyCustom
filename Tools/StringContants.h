//
//  StringContants.h
//  CCTVNews
//
//  Created by Richy Leo on 14-8-27.
//  Copyright (c) 2014年 Richy Leo. All rights reserved.
//
#ifndef CCTVNews_StringContants_h
#define CCTVNews_StringContants_hzhengge
#import "MJExtension.h"

#pragma mark XMPP
#define USERID [[SingleTon getInstance].landScuessDic objectForKey:@"returnuid"]?[[[SingleTon getInstance].landScuessDic objectForKey:@"returnuid"] stringValue]:@""

#define BUGLY_APP_ID @"900022092"

//#define APP_TEST 0    //正式服
#define APP_TEST 1  //测试服
#if APP_TEST
//测试服务器地址
//#define SERVER_ADDRESS @"http://resourcetest.ttplus.titan24.com/init.json"
//#define AD_ON_OFF   @"http://apitest.ttplus.titan24.com/ad/idx"
//#define advertisement_info   @"http://apitest.ttplus.titan24.com/advertisement/info"
#define SERVER_ADDRESS @"http://resourcedev.ttplus.cn/init.json"
#define SERVER_CONNECT_STATUS @"http://www1.ttplus.cn/keepalive.txt"
#define AD_ON_OFF   @"http://apidev.ttplus.cn/ad/idx"
#define advertisement_info   @"http://apidev.ttplus.cn/advertisement/info"
#define SECRET_KEY @"123"
#define SECRET_VALUE @"123"
#define UMSOCIAL_APPKEY @"5550817567e58e100a000463"
#else
//预正式
//#define SERVER_ADDRESS @"http://resourcepro.ttplus.cn/init.json"
//正式服务器
#define SERVER_ADDRESS @"http://resource.ttplus.cn/init.json"
#define SERVER_CONNECT_STATUS @"http://www1.ttplus.cn/keepalive.txt"
#define AD_ON_OFF      @"http://api.ttplus.cn/ad/idx"
#define advertisement_info   @"http://api.ttplus.cn/advertisement/info"
#define SECRET_KEY @"2d08a6a33b7348ab8d65bda468cffc78"
#define SECRET_VALUE @"b0b58e4a99724a98b9f59e5db207d64d"
#define UMSOCIAL_APPKEY @"5550817567e58e100a000463"
#endif

//友盟key值.
//测试：54113b6ffd98c5b149086604jhhhhhhhhhhhhhhhhhhh
//正式：54365032fd98c5cb1807b7fd
#define UMENG_DATA_KEY @"54365032fd98c5cb1807b7fd"
//微信key值
//测试：wx40324434dc348227
//正式：wxc8fcf70a7baa2ca5
#define WX_APPKEY @"wxc8fcf70a7baa2ca5"

// 目前新浪分享调用的是系统分享，故以下值先不做替换
#define kAppKey        @"3808434008"
#define kAPPSecret       @"1a63aa8a91be47ed28cccab9315952dc"
#define kRedirectURI @"http://weibo.com/cctvnewsbeijing?topnav=1&wvr=5&topsug=1"

//判断是iPhone 或 ipad
#define isIphone [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
//判断系统Version
#define App_Version [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define systemVersion_aboveIOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 6.999
#define systemVersion_aboveIOS8 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.99
#define systemVersion_aboveIOS9 ([[[UIDevice currentDevice]systemVersion] floatValue] >= 8.99 ? YES : NO)
#define systemVersion_aboveIOS10 [[[UIDevice currentDevice]systemVersion] floatValue] >= 9.99

#define CELL_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define IMAGE_HEIGHT CGRectGetWidth([UIScreen mainScreen].bounds) * (float)9 / (float)16
#define Img_HEIGHT CGRectGetWidth([UIScreen mainScreen].bounds) /2

//屏幕的宽高
#define SCREEN_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define SCREEN_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)
#define TableViewFooterH 50
//小边距
#define ofsetX 20
#define IDFA [USER_DEFAULT objectForKey:@"idfa"]

#define YRNotification [NSNotificationCenter defaultCenter]
#define kUserDefaults [NSUserDefaults standardUserDefaults]
// nav bar
#define NAV_ICON_OFFSET 10
#define NAVBAR_FRAME CGRectMake(0, 0, IMAGE_WIDTH, STATUS_BAR_HEIGHT + 44 + NAV_ICON_OFFSET)
#define VIEW_ORIGIN_Y (STATUS_BAR_HEIGHT + 44)

#define PATH_TO_FAVORITE_DIC @"PATH_TO_FAVORITE_DIC"

//存取收藏数据的 key值
#define KEY_TIME_SORT @"timeSort"
#define KEY_FAVORITE_INFO @"favorite"
#define KEY_LIKE_SORT @"likeSort"

//通知进入详情页
#define NOTIFICATION_JUMP_DETAIL @"NOTIFICATION_JUMP_DETAIL"
#define NOTIFICATION_JUMP_VIDEODETAIL @"NOTIFICATION_JUMP_VIDEODETAIL"

#define NOTIFICATION_SHARE_ACTION @"NOTIFICATION_SHARE_ACTION"
#define NOTIFICATION_LIKE_ACTION @"NOTIFICATION_LIKE_ACTION"

// 判断like本地是否 加1
#define BOOL_IS_LIKE_LOCAL_PLUS @"BOOL_IS_LIKE_LOCAL_PLUS"

// 后台用户量统计标示 只请求一次
#define BOOL_IS_FIRST_INSTALL @"BOOL_IS_FIRST_INSTALL"


//已读的(数组)
#define USER_READED @"user_readed"

//16进制转color
#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//手机型号
#define	CTL_HW		6		/* generic cpu/io */
#define	HW_MACHINE	 1		/* string: machine class */
int	sysctl(int *, u_int, void *, size_t *, void *, size_t);

// 初始化接口
#define METHORD_INIT    @"METHORD_INIT"

// 获取快讯新闻列表
#define METHORD_ALL     @"METHORD_ALL"
// 获取圈子新闻列表
#define METHORD_QUAN_ZI @"METHORD_QUAN_ZI"

#define SECTION_TIME_TAG        @"time"
#define SECTION_STRUCT_TAG      @"struct"
#define SECTION_URLS_TAG        @"urls"
#define SECTION_IPHONE_TAG      @"iphone"

#define SECTION_SUB_PURL_TAG        @"purl"

#define SECTION_SUB_ID_URL          @"sectionidurl"
#define SECTION_COM_URL          @"commenturl"
#define SECTION_COM_USER_URL          @"usercomment"
#define SECTION_REM_COM_URL          @"removecomment"
#define SECTION_FAV_USER_URL          @"favorites_user"
#define SECTION_FAV_ADD_URL          @"favorites_add"
#define SECTION_FAV_REMOVE_URL          @"favorites_remove"
// 快讯的名称
#define SECTION_NAME_KUAI_XUN        @"快讯"
#define SECTION_NAME_QUAN_ZI         @"圈子"

#define KEY_SECTION_PATH    @"sctionpath"

#define cache_touTiao_news_list_key      @"cache_touTiao_news_list_key"
#define cache_lasted_news_list_key     @"cache_lasted_news_list_key"
#define cache_wordLive_news_list_key     @"cache_wordLive_news_list_key"
#define cache_key_head                  @"cache_key_head"
#define cache_top12_news_list_key @"cache_top12_news_list_key"
#define cache_intensiveReading_list_key @"cache_intensiveReading_list_key"
#define cache_reComment_news_list_key      @"cache_reComment_news_list_key"
#define cache_videoList_news_list_key      @"cache_videoList_news_list_key"

#endif


//判断设备型号
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)


#define DebugLog( s, ... ) NSLog( @"[%@:(%d)] %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )

#define PingFangSC_Regular(Size) [UIFont fontWithName:([[[UIDevice currentDevice]systemVersion] floatValue] < 9.00)?@"Heiti SC":@"PingFangSC-Regular" size:(Size)]
#define PingFangSC_Medium(Size) [UIFont fontWithName:([[[UIDevice currentDevice]systemVersion] floatValue] < 9.00)?@"Heiti SC":@"PingFangSC-Medium" size:(Size)]
#define PingFangSC_Semibold(Size) [UIFont fontWithName:([[[UIDevice currentDevice]systemVersion] floatValue] < 9.00)?@"Heiti SC":@"PingFangSC-Semibold" size:(Size)]

//height and width
#define HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

#define USER_DEFAULT [NSUserDefaults standardUserDefaults]
#define imageShowYes ([[USER_DEFAULT objectForKey:@"imageShow"] isEqualToString:@"1"])?YES:NO

#define W_w SCREEN_WIDTH/750

//openfire服务器端口 默认5222
#define  kHostPort      5222
//openfire域名
#define kDomin @"123456.local"
//resource
#define kResource @"iOS"
#define iOS8_OR_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define ratio_w(a) a*SCREEN_WIDTH/375
//适配 x
//#define STATUS_BAR_HEIGHT ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.99 ? 20 : 0)
#define system_version [[UIDevice currentDevice].systemVersion doubleValue]
// 判断是否是iPhone X
#define IS_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 状态栏高度
#define STATUS_BAR_HEIGHT (IS_iPhoneX ? 44.f : 20.f)
#define NAV_OTHER_HEIGHT   44.f
// 导航栏高度
#define NAVIGATION_BAR_HEIGHT (IS_iPhoneX ? 88.f : 64.f)
// tabBar高度
#define TAB_BAR_HEIGHT (IS_iPhoneX ? (49.f+34.f) : 49.f)
// home indicator
#define HOME_INDICATOR_HEIGHT (IS_iPhoneX ? 34.f : 0.f)
// 有navigationBar的高度没有tabbar
#define TABLE_Height SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT
// 有tabbar和navigationBar的高度
#define TABLE_containtTab_Height SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT
// 除去底部indicator的高度
#define CONTENT_Height SCREEN_HEIGHT-HOME_INDICATOR_HEIGHT
//homePageTableViewH
#define HomePageTableViewH SCREEN_HEIGHT-NAVIGATION_BAR_HEIGHT -NAV_OTHER_HEIGHT-TAB_BAR_HEIGHT

