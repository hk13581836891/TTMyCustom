//
//  Tools.m
//  CCTVNews
//
//  Created by Richy Leo on 14-8-27.
//  Copyright (c) 2014年 Richy Leo. All rights reserved.
//

#import "Tools.h"
#import "ColorContants.h"
#import "NumberContants.h"
#import "StringContants.h"
#import "OpenUDID.h"
#import "RSA.h"
#import<CommonCrypto/CommonDigest.h>
#import <WebKit/WebKit.h>


#define MYVoteIDFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"voteid.data"]

static NSMutableArray *_voteIDs;

@implementation Tools
{
    UIView  *promptView;
}
/**
 随机生成 UUID
 */
+ (NSString *)uuidString
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}

/**
 取消通知红点
 
 @param cancleStr 取消类型
 */
+(void)cancleNoticeRedDot:(NSString *)cancleStr
{
    long currentDate = [[NSDate date] timeIntervalSince1970]*1000;
    NSString * cancelNoti = [TTInitInterfaceManager getUrlWithKey:Init_app url:@"new_cancel"];
    NSString * qwer;
    if ([SingleTon getInstance].landStatus) {
        qwer=[NSString stringWithFormat:@"%@",[[SingleTon getInstance].landScuessDic valueForKey:@"returnuid" ]];
    }else{
        qwer = @"";
    }
    
    cancelNoti = [NSString stringWithFormat:@"%@?userId=%@&cancel=%@&date=%ld",cancelNoti,qwer,cancleStr,currentDate];
    [HttpTool httpGet:cancelNoti params:nil target:nil success:^(id responseObject) {
        
        TTLog(@"取消成功");
        
        
    } failure:^(NSError *error) {
        
    }];
}
+(void)addOrCancleLikeWithView:(UIView*)view CommentId:(NSString *)commentId WithType:(BOOL)isLike success:(void(^)(BOOL islikeSuccess))success
{
    NSString *qwer=[NSString stringWithFormat:@"%@",[[SingleTon getInstance].landScuessDic valueForKey:@"returnuid" ]];
    qwer=[RSA DESEncryptWithBase64:qwer key:@"qazwsxedcrfv"];
    qwer =[[Tools alloc] stringByURLEncodingStringParameter:qwer];
    
    NSString *status = @"";
    if (!isLike) {
        status = @"LIKE";
        NSString *Comment_like = [TTInitInterfaceManager getUrlWithKey:Init_app url:@"comment_like"];
        NSString *url = [NSString stringWithFormat:@"%@?userId=%@&commentId=%@&type=%@",Comment_like,qwer,commentId,status];
        
        [HttpTool httpGet:url params:nil target:nil success:^(id responseObject) {
            
            NSString * type = [responseObject objectForKey:@"type"];
            if ([type isEqualToString:@"success"]) {
                if (success) {
                    success(YES);
                }
            }else{
                if (success) {
                    success(NO);
                    
                }
                NSString * content = [responseObject objectForKey:@"content"] ;
                MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
                HUD.color = [UIColor blackColor];
                //显示的文字
                HUD.mode = MBProgressHUDModeText;
                HUD.labelText = content;
                [HUD hide:YES afterDelay:1];
            }
            
        } failure:^(NSError *error) {
            if (success) {
                success(NO);
                NSString * content = @"网络不给力,点赞失败";
                MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
                HUD.color = [UIColor blackColor];
                //显示的文字
                HUD.mode = MBProgressHUDModeText;
                HUD.labelText = content;
                [HUD hide:YES afterDelay:1];
            }
        }];
    }else{
        status = @"CANCEL";
        NSString * content = @"您已点过赞";
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
        HUD.color = [UIColor blackColor];
        //显示的文字
        HUD.mode = MBProgressHUDModeText;
        HUD.labelText = content;
        [HUD hide:YES afterDelay:1];
    }
    
    
    
}
//启动页机制
+(void)getLaunchImageUrl
{
    NSString * url = [TTInitInterfaceManager getUrlWithKey:Init_www url:@"bootup_init"];
    // 从服务器请求详情数据
    [HttpTool httpGet:url params:nil target:nil success:^(id responseObject) {
        
        //正常返回
        NSDictionary *returnDic = responseObject;
        NSNumber * timestamp = [returnDic objectForKey:@"timestamp"];
        
        if (![[timestamp stringValue] isEqualToString:[Tools GetStrFromLocal:@"bootupimage"]]) {
            NSString * lunImage = [returnDic objectForKey:@"open_1242x2208"];
            NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:lunImage]];
            UIImage *lanchImg = [UIImage imageWithData:data];
            
            [Tools SaveImageToLocal:lanchImg Keys:@"lanchImg"];
            [Tools SaveStringToLocal:[timestamp stringValue] Keys:@"bootupimage"];
            
        }
        else
        {
            if (![Tools LocalHaveImage:@"lanchImg"]) {
                NSString * lunImage = [returnDic objectForKey:@"open_1242x2208"];
                NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:lunImage]];
                UIImage *lanchImg = [UIImage imageWithData:data];
                
                [Tools SaveImageToLocal:lanchImg Keys:@"lanchImg"];
                [Tools SaveStringToLocal:[timestamp stringValue] Keys:@"bootupimage"];
            }
        }
        NSString * adStr = [returnDic objectForKey:@"ad"];
        [Tools SaveStringToLocal:adStr Keys:@"adStr"];
        
        NSFormatter * durations = [returnDic objectForKey:@"durations"];
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user setObject:durations forKey:@"durations"];
        [user synchronize];
        
        
    } failure:^(NSError *error) {
        
    }];
}
//状态栏显示/隐藏
+(void)statuBarShowOrHide
{
    if ([SingleTon getInstance].statusBarHide) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
    }else{
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }
}
//nsstring转 uiimage
+(UIImage *)Base64StrToUIImage:(NSString *)imageStr
{
    NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageStr]];
    UIImage * image    = [UIImage imageWithData:imageData];
    return image;
}

//图片转字符串
+(NSString *)UIImageToBase64Str:(UIImage *) image
{
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}
//获取view的控制器
+ (UIViewController*)viewController :(UIView *)view {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

//获取导航控制器
+ (UINavigationController*)navigationController:(UIView *)view{
    for (UIView* next = view.superview; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController*)nextResponder;
        }
    }
    return nil;
}
+ (UIViewController*)VC:(UIView *)view{
    for (UIView* next = view.superview; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
//时间格式转换 long型转字符串
+(NSString *)changeTimeStyle:(id)newsTime;
{
    long long newstime;
    if (newsTime != [NSNull null] ) {
        newstime = [newsTime longLongValue];
    }
    
    NSDate *date= [NSDate dateWithTimeIntervalSince1970:newstime/1000];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit |NSMinuteCalendarUnit fromDate:date];
    NSInteger day = [components day];
    NSInteger month= [components month];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    NSString * time = [NSString stringWithFormat:@"%02ld-%02ld %02ld:%02ld", (long)month,(long)day,(long)hour,(long)minute];
    
    return time;
}

/**
 创建button
 */
+(UIButton *)creatButtonTarget:(id)target
                         title:(NSString*)title
                    titleColor:(UIColor *)titleColor
                     titleFont:(CGFloat)fontSize
               titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets
                         image:(UIImage *)image
               imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets
                       cornerR:(CGFloat)cornerR
                       borderW:(CGFloat)borderW
                   borderColor:(UIColor*)borderColor
               backGroundColor:(UIColor *)backGroundColor
                        action:(SEL)action
{
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = backGroundColor;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitleEdgeInsets:titleEdgeInsets];
    [button setImage:image forState:UIControlStateNormal];
    [button setImageEdgeInsets:imageEdgeInsets];
    button.layer.cornerRadius = cornerR;
    button.layer.borderColor = borderColor.CGColor;
    button.layer.borderWidth = borderW;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
    
}

/**
 lable改变属性
 @param lineSpacing 行间距
 @param color 文本颜色
 @param rang1 需要改变的颜色
 @param rang2 需要改变的颜色
 
 */
+(UILabel *)creatLabel_LineSpacing_Color:(NSString *)content
                               textColor:(UIColor *)textColor
                                    font:(UIFont *)font
                             lineSpacing:(CGFloat)lineSpacing
                                   color:(UIColor *)color
                                  range1:(NSRange)rang1
                                  range2:(NSRange)rang2
{
    
    UILabel * label = [self initLabel:content color:textColor font:font];
    label.numberOfLines = 0;
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    // 调整行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [content length])];
    
    //改变颜色
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:rang1];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:rang2];
    
    //改变字体
    //    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:30.0] range:range1];
    //    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0] range:range2];
    
    label.attributedText = attributedString;
    return label;
}
//仅提示 alert
+(void)creatAlertController:(id)target
                      title:(NSString *)title
                    message:(NSString *)message
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
    [target presentViewController:alert animated:YES completion:nil];
    
}
//json 转字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
//判断字符串是否存在，是否为空
+(NSString *)getReturnResult:(NSDictionary *)dic key:(NSString *)key
{
    NSString * result;
    
    if ([dic objectForKey:key]) {
        
        if ([[dic objectForKey:key] isKindOfClass:[NSNull class]]) {
            result= @"";
        }else{
            result = [dic objectForKey:key];
        }
        
    }else{
        result = @"";
    }
    
    return result;
}
//网络不通详情返回提示
+(UIAlertView * )creatAlertNotReachable:(id)target
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络不给力，将返回上一页" delegate:target cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert setTag:1001];
    [alert show];
    return alert;
}
+(void)creatNetErrowTipTop:(id)target;
{
    UILabel *tipLab = [[UILabel alloc] init];
    tipLab.frame = CGRectMake(27, 0, SCREEN_WIDTH-54, 40);
    tipLab.text = @"网络不给力，请稍后再试";
    tipLab.textColor = WhiteColor;
    tipLab.textAlignment = NSTextAlignmentCenter;
    tipLab.font = PingFangSC_Regular(18);
    tipLab.backgroundColor = ColorLigBlue;
    tipLab.alpha = 0.9;
    [target addSubview:tipLab];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tipLab removeFromSuperview];
    });
    
}
+(void)creatNetErrowTipBottom:(id)target
{
    
    UILabel *tipLab = [[UILabel alloc] init];
    tipLab.frame = CGRectMake(27, SCREEN_HEIGHT-50-40 -64, SCREEN_WIDTH-54, 40);
    tipLab.text = @"网络不给力，请稍后再试";
    tipLab.textColor = WhiteColor;
    tipLab.textAlignment = NSTextAlignmentCenter;
    tipLab.font = PingFangSC_Regular(18);
    tipLab.backgroundColor = ColorLigBlue;
    tipLab.alpha = 0.9;
    [target addSubview:tipLab];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tipLab removeFromSuperview];
    });
}
+(void)creatNetErrowCommonTipBottom:(id)target originY:(id)originY
{
    CGFloat originYf = [originY floatValue];
    UILabel *tipLab = [[UILabel alloc] init];
    tipLab.frame = CGRectMake(27, originYf , SCREEN_WIDTH-54, 40);
    tipLab.text = @"网络不给力，请稍后再试";
    tipLab.textColor = WhiteColor;
    tipLab.textAlignment = NSTextAlignmentCenter;
    tipLab.font = PingFangSC_Regular(18);
    tipLab.backgroundColor = ColorLigBlue;
    tipLab.alpha = 0.9;
    [target addSubview:tipLab];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tipLab removeFromSuperview];
    });
}

//网络不通提示hud
+(MBProgressHUD *)creatNotReachableHUD:(id)target
{
    MBProgressHUD *netHUD = [MBProgressHUD showHUDAddedTo:target animated:YES];
    netHUD.color = [UIColor blackColor];
    //显示的文字
    netHUD.mode = MBProgressHUDModeText;
    netHUD.labelText = @"当前网络不可用，请检查网络设置";
    [netHUD hide:YES afterDelay:1];
    
    return netHUD;
}
//网络不通提示label
+(CustomLabel *)creatNotReachableTip:(CGRect)frame
{
    
    CustomLabel * label = [[CustomLabel alloc] initWithFrame:frame];
    label.text = @"当前网络不给力，请您稍后再试";
    label.backgroundColor = ColorGrayBack;
    label.textColor = ColorMainRed;
    label.font = PingFangSC_Regular(13);
    
    return label;
}
//服务器联通状态
+(void)serverLinkStatus:(void (^)(BOOL bResult, NSString* errDesc))success
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *dev_os = [[UIDevice currentDevice] systemVersion];
    NSString *tinfo_version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *newUserAgent = [NSString stringWithFormat:@"(ttplus/%@/iOS%@)",tinfo_version,dev_os];//自定义需要拼接的字符串
    [mgr.requestSerializer setValue:newUserAgent forHTTPHeaderField:@"User-Agent"];
    [mgr GET:SERVER_CONNECT_STATUS parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"return data:%@",responseObject);
        NSString *res = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if ([res isEqualToString:@"1"]) {
            success(YES, nil);
        }
        else{
            success(NO, @"返回值非1");
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"ssssssss%@",error);
        success(NO, [error description]);
    }];
    
    return;
}
//创建列表返回值为0的提示 label
+(UILabel *)createTipLabel:(NSString *)content
{
    UILabel * showAlr = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-150, SCREEN_HEIGHT/2-64, 300, 40)];
    showAlr.text = content;
    showAlr.textColor = RGBCOLOR(153, 153, 153);
    showAlr.font = PingFangSC_Regular(18);
    showAlr.textAlignment =NSTextAlignmentCenter;
    
    return showAlr;
}
//获取用户 id并加密
+(NSString *)getUserId
{
    NSString * qwer=[NSString stringWithFormat:@"%@",[[SingleTon getInstance].landScuessDic valueForKey:@"returnuid" ]];
    qwer=[RSA DESEncryptWithBase64:qwer key:@"qazwsxedcrfv"];
    qwer =[[Tools alloc] stringByURLEncodingStringParameter:qwer];
    return qwer;
}

//根据文件名获取图片
+ (UIImage *)imageWithName:(NSString *)name
{
    
    NSString * imageStr = [NSString stringWithFormat:@"%@.png", name];
    UIImage * image = [UIImage imageNamed:imageStr];
    
    return image;
}



+ (UILabel *)initLabel:(CGRect)frame content:(NSString *)content color:(UIColor *)color font:(UIFont *)font aliment:(NSTextAlignment)aliment
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.text = content;
    label.textColor = color;
    label.font = font;
    label.textAlignment = aliment;
    return label;
}
//创建label
+ (UILabel *)initLabel:(NSString *)content color:(UIColor *)color font:(UIFont *)font
{
    
    CGSize size = [content sizeWithAttributes:@{NSFontAttributeName:font }];
    UILabel * label = [self initLabel:CGRectMake(0, 0, size.width, size.height) content:content color:color font:font aliment:NSTextAlignmentCenter];
    return label;
}

//创建button
+ (UIButton *)createButtonWithNormalImage:(NSString *)normal
                           highlitedImage:(NSString *)highlited
                                   target:(id)target
                                   action:(SEL)action
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (normal.length > 0) {
        UIImage *normalImage = [self imageWithName:normal];
        [button setImage:normalImage forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, normalImage.size.width, normalImage.size.height);
    }
    if (highlited.length > 0) {
        UIImage *highlightImage = [self imageWithName:highlited];
        [button setImage:highlightImage forState:UIControlStateHighlighted];
    }
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
    
}

+ (UIButton *)createButtonWithNormalImage:(NSString *)normal
                            selectedImage:(NSString *)selected
                                   target:(id)target
                                   action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (normal.length > 0) {
        UIImage *normalImage = [self imageWithName:normal];
        [button setImage:normalImage forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, normalImage.size.width, normalImage.size.height);
    }
    if (selected.length > 0) {
        UIImage *selectedImage = [self imageWithName:selected];
        [button setImage:selectedImage forState:UIControlStateHighlighted];
        [button setImage:selectedImage forState:UIControlStateSelected];
        button.frame = CGRectMake(0, 0, selectedImage.size.width, selectedImage.size.height);
    }
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

//创建navbar
+ (UIBarButtonItem *)createNavButtonItem:(NSString *)normal
                                selected:(NSString *)selected
                                  target:(id)taget
                                  action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (normal.length > 0) {
        UIImage *normalImage = [self imageWithName:normal];
        [button setImage:normalImage forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, normalImage.size.width, normalImage.size.height);
    }
    if (selected.length > 0) {
        UIImage *selectedImg = [self imageWithName:selected];
        [button setImage:selectedImg forState:UIControlStateHighlighted];
    }
    [button addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item ;
}

+ (UIToolbar *)createKeyBoardAccessViewWithLeftTitles:(NSDictionary *)leftDic rightTitle:(NSDictionary *)rightDic taget:(id)target
{
    UIToolbar *keybordBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0, 320, 30)];
    keybordBar.barStyle = UIBarStyleBlackTranslucent;
    if(systemVersion_aboveIOS7){
        keybordBar.barTintColor = [UIColor lightGrayColor];
    }
    
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    NSMutableArray *buttonsArray = [NSMutableArray array];
    for (NSString *name in [leftDic allKeys]) {
        SEL selector = NSSelectorFromString([leftDic objectForKey:name]);
        UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(name, nil) style:UIBarButtonItemStyleBordered target:target action:selector];
        [buttonsArray addObject:buttonItem];
    }
    [buttonsArray addObject:spaceButtonItem];
    
    for (NSString *name in [rightDic allKeys]) {
        SEL selector = NSSelectorFromString([rightDic objectForKey:name]);
        UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(name, nil) style:UIBarButtonItemStyleDone target:target action:selector];
        [buttonsArray addObject:buttonItem];
    }
    
    keybordBar.items = buttonsArray;
    return keybordBar;
}

+ (UITextField *)createTextFieldWithFrame:(CGRect)frame
                              placeholder:(NSString *)placeholder
                                 fontSize:(CGFloat)fontSize
{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    if (placeholder.length > 0) {
        textField.placeholder = placeholder;
    }
    textField.font = PingFangSC_Regular(fontSize);
    textField.textAlignment = NSTextAlignmentLeft;
    textField.backgroundColor = [UIColor clearColor];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.keyboardAppearance = isNightModel?UIKeyboardAppearanceDark:UIKeyboardAppearanceLight;
    return textField;
}

//统一controller的标题
+ (UILabel *)createTitleLabel:(NSString *)title
{
    UILabel *titleLable =[Tools initLabel:CGRectMake(0, 0, 200, 44) content:NSLocalizedString(title, @"标题") color:RGBCOLOR(255, 255, 255) font:PingFangSC_Regular(20) aliment:NSTextAlignmentCenter];
    //    [Tools initLabel:  frame: color: font: aliment:];
    titleLable.shadowColor = [UIColor colorWithRed:202 / 255.0 green:81 / 255.0 blue:0 / 255.0 alpha:0.5];
    titleLable.shadowOffset = CGSizeMake(0.0f, -1);
    if (title.length > 9) {
        titleLable.font = PingFangSC_Regular(16);
        titleLable.numberOfLines = 2;
    }
    return titleLable;
}

+(UIView *)createNavView:(UIImage *)image
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    view.backgroundColor = [UIColor clearColor];
    
    UIImageView * imageView = [[UIImageView alloc]initWithImage:image];
    [view addSubview:imageView];
    
    return view;
}

//适配方法
+ (float)getCurrentDistinction
{
    if (IS_IPHONE_5) {
        return (548 - 460);
    }
    else
    {
        return 0;
    }
}


//判断时区 （分享用）
+ (BOOL)isInChina
{
    BOOL result = NO;
    
    if([[[NSTimeZone localTimeZone] name] rangeOfString:@"Asia/Chongqing"].location == 0 ||
       [[[NSTimeZone localTimeZone] name] rangeOfString:@"Asia/Harbin"].location == 0 ||
       [[[NSTimeZone localTimeZone] name] rangeOfString:@"Asia/Hong_Kong"].location == 0 ||
       [[[NSTimeZone localTimeZone] name] rangeOfString:@"Asia/Macau"].location == 0 ||
       [[[NSTimeZone localTimeZone] name] rangeOfString:@"Asia/Shanghai"].location == 0 ||
       [[[NSTimeZone localTimeZone] name] rangeOfString:@"Asia/Taipei"].location == 0)
    {
        result = YES;
    }
    return result;
}

+ (NSString *)getUrl:(NSString *)pKey{
    return @"";
}

+(NSString *)getOpenUDID
{
    return [OpenUDID value];
}

+(NSString *)returnNewsType:(NSInteger)type_
{
    NSString * typeContent = @"";
    switch (type_) {
        case 1:
            typeContent = @"Breaking News";
            break;
        case 2:
            typeContent = @"Top News";
            break;
        case 3:
            typeContent = @"Politics";
            break;
        case 4:
            typeContent = @"Business";
            break;
        case 5:
            typeContent = @"China Society";
            break;
        case 6:
            typeContent = @"Tech & Sci";
            break;
        case 7:
            typeContent = @"Leisure";
            break;
        default:
            break;
    }
    return typeContent;
}

// 转化成当前当地时区的时间 完整的时间
+(NSString *)wholeDateToString:(NSDate *)date
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    return dateString;
}

// 转化成当前当地时区的时间 时间仅包含（年、月）供收藏排序用
+(NSString *)dateToString:(NSDate *)date
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    return dateString;
}

//返回当前时间长度
+(NSTimeInterval)returnCurrentDateLength
{
    NSTimeInterval length;
    
    length = [[NSDate date] timeIntervalSince1970];
    
    NSLog(@"====%@, length = %f", [NSDate date], length);
    return length;
}

//设置内容行距(摒弃，无法正确计算多行内容的高度)
+(void)setContentSpaceLine:(NSString *)contentStr withLabel:(UILabel *)label
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:contentStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:8];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attributedString length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}

+(NSString *)changeLetterLowercase:(NSString *)source
{
    NSString * result = @"";
    
    result = [source lowercaseString];
    
    return result;
}

// IOS7 自适应宽度 or 高度
// isWidthMax = YES (计算宽度，value则为定高)
+(CGSize)adjustViewWidthOrHeight:(NSString *)content font:(UIFont *)font widthOrHeightValue:(float)value isWidthMax:(BOOL)isWidthMax
{
    CGSize size = CGSizeZero;
    
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    
    if(isWidthMax){
        size = [content boundingRectWithSize:CGSizeMake(MAXFLOAT, value) options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    }
    else{
        size = [content boundingRectWithSize:CGSizeMake(value, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
    }
    
    return size;
}

// nav title
+ (NSString *)sectionTitleIndex:(int)index defaultTitle:(NSString *)titleStr
{
    NSString * title = @"";
    switch (index) {
        case -1:
            title = titleStr;
            break;
            
        case 0:
            title = @"Home";
            break;
        case 1:
            title = @"Top News";
            break;
        case 2:
            title = @"Politics";
            break;
        case 3:
            title = @"Business";
            break;
        case 4:
            title = @"China Society";
            break;
        case 5:
            title = @"Tech & Sci";
            break;
        case 6:
            title = @"Leisure";
            break;
            
        default:
            break;
    }
    
    return title;
}


// 获取前一天或后一天的日期（day负值：前一天）
+(NSString *)getPriousorLaterDateFromDate:(NSDate *)date withDay:(int)day

{
    NSString * dateStr = @"";
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:day];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    dateStr = [dateFormatter stringFromDate:mDate];
    
    return dateStr;
}

//提示框
-(UIView*)makePrompt:(NSString*)passWord
{
    promptView=[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-40, SCREEN_HEIGHT/2-30, 80, 80)];
    promptView.alpha=1;
    promptView.backgroundColor=[UIColor blackColor];
    //[view addSubview:promptView];
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    lab.text=passWord;
    lab.textColor=[UIColor whiteColor];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.font=PingFangSC_Medium(14);
    lab.numberOfLines=0;
    [promptView addSubview:lab];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(apper) userInfo:nil repeats:YES];
    return promptView;
}
//修改字符串
-(NSInteger)stringFindString:(NSString *)str
{   NSUInteger count = 0;
    
    
    NSString * string1 = str;
    
    NSString * string2 = @"\n";
    for (int i = 0; i < string1.length - string2.length + 1; i++) {
        
        if ([[string1 substringWithRange:NSMakeRange(i, string2.length)] isEqualToString:string2]) {
            
            
            count++;
            
        }
        
        
    }
    
    return count;
}

-(NSString*)makeUser_active:(NSString *)user_active andUser_id:(NSString *)user_id
{
    NSMutableString *str=[[NSMutableString alloc]initWithCapacity:0];
    //    NSString* openUDID = [OpenUDID value];
    //获取 idfa
    //    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSString* deviceName = [Tools getCurrentDeviceModel];
    NSString * openIos=[[UIDevice currentDevice] systemVersion];
    NSString *openCersion=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    str=[NSMutableString stringWithFormat:@"dev_id=%@&dev_os=ios%@&dev_type=%@&tinfo_version=%@&user_active=%@&source=app&user_id=%@&channel=appstore",[USER_DEFAULT objectForKey:@"idfa"],openIos,deviceName,openCersion,user_active,user_id];

    return str;
}
//app 运行时长统计参数
+(NSString *)makeUseTimeUserid:(NSString *)user_id
                  current_time:(long)current_time
                     exit_time:(long)exit_time
                    start_time:(long)start_time
                      use_time:(long)use_time
{
    //    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSString* deviceName = [Tools getCurrentDeviceModel];
    deviceName = [deviceName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * openIos=[[UIDevice currentDevice] systemVersion];
    NSString *openCersion=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString * pramStr = [NSString stringWithFormat:@"?dev_type=%@&dev_id=%@&dev_os=%@&mobile_type=1&time=%ld&tinfo_version=%@&userid=%@&exit_time=%ld&start_time=%ld&use_time=%ld",deviceName,[USER_DEFAULT objectForKey:@"idfa"],openIos,current_time,openCersion,user_id,exit_time,start_time,use_time];
    return pramStr;
};

//意见反馈
+(NSString *)makeFeedback_save:(NSString *)user_id
                  current_time:(long)current_time
                       content:(NSString *)content
                       contact:(NSString *)contact
{
    //    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSString* deviceName = [Tools getCurrentDeviceModel];
    deviceName = [deviceName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * openIos=[[UIDevice currentDevice] systemVersion];
    NSString *openCersion=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString * pramStr = [NSString stringWithFormat:@"?dev_type=%@&dev_id=%@&dev_os=%@&mobile_type=1&time=%ld&tinfo_version=%@&content=%@&contact=%@&userid=%@",deviceName,[USER_DEFAULT objectForKey:@"idfa"],openIos,current_time,openCersion,content,contact,user_id];
    return pramStr;
};


+(NSString *)getCurrentDeviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone9,1"])    return @"iPhone 7 (CDMA)";
    if ([platform isEqualToString:@"iPhone9,3"])    return @"iPhone 7 (GSM)";
    if ([platform isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus (CDMA)";
    if ([platform isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus (GSM)";
    
    
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}
- (NSString*)stringByURLEncodingStringParameter:(NSString *)ee
{
    // NSURL's stringByAddingPercentEscapesUsingEncoding: does not escape
    // some characters that should be escaped in URL parameters, like / and ?;
    // we'll use CFURL to force the encoding of those
    //
    // We'll explicitly leave spaces unescaped now, and replace them with +'s
    //
    // Reference: <a href="%5C%22http://www.ietf.org/rfc/rfc3986.txt%5C%22" target="\"_blank\"" onclick='\"return' checkurl(this)\"="" id="\"url_2\"">http://www.ietf.org/rfc/rfc3986.txt</a>
    
    NSString *resultStr ;
    
    CFStringRef originalString = (__bridge CFStringRef) ee;
    CFStringRef leaveUnescaped = CFSTR(" ");
    CFStringRef forceEscaped = CFSTR("!*'();:@&=+$,/?%#[]");
    
    CFStringRef escapedStr;
    escapedStr = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                         originalString,
                                                         leaveUnescaped,
                                                         forceEscaped,
                                                         kCFStringEncodingUTF8);
    
    if( escapedStr )
    {
        NSMutableString *mutableStr = [NSMutableString stringWithString:(__bridge NSString *)escapedStr];
        CFRelease(escapedStr);
        
        // replace spaces with plusses
        [mutableStr replaceOccurrencesOfString:@" "
                                    withString:@"%20"
                                       options:0
                                         range:NSMakeRange(0, [mutableStr length])];
        resultStr = mutableStr;
    }
    return resultStr;
}

-(void)apper
{
    promptView.alpha=0;
}

+ (NSString *)checkNullValueForString:(id)object
{
    if([object isKindOfClass:[NSNull class]])
    {
        return @"";
    }
    else if(!object)
    {
        return @"";
    }
    else if ([object isKindOfClass:[NSString class]])
    {
        NSString *string = (NSString *)object;
        if ([string isEqualToString:@"(null)"])
        {
            return @"";
        }
        else if ([string isEqualToString:@"null"])
        {
            return @"";
        }
        else
        {
            return [NSString stringWithFormat:@"%@",string];
        }
    }
    else if ([object isKindOfClass:[NSNumber class]])
    {
        return [NSString stringWithFormat:@"%@",object];
    }
    else
    {
        return @"";
    }
}

//返回请求投票问题 id数据
+(NSMutableArray *)voteIDs
{
    if (!_voteIDs) {
        _voteIDs = [NSKeyedUnarchiver unarchiveObjectWithFile:MYVoteIDFile];
        
        if (!_voteIDs) {
            _voteIDs = [NSMutableArray array];
        }
    }
    return _voteIDs;
}

//保存请求的投票问题 id列表
+(void)saveVoteID:(int)voteid
{
    // 第一次启动手动调用doctorList创建数组，否则数据为空
    [self voteIDs];
    NSString *voteidStr = [NSString stringWithFormat:@"%d",voteid];
    
    [_voteIDs removeObject:voteidStr];
    
    [_voteIDs insertObject:voteidStr atIndex:0];
    
    // 存进沙盒
    [NSKeyedArchiver archiveRootObject:_voteIDs toFile:MYVoteIDFile];
}

+ (void)deleteVoteID:(int)voteid
{
    NSString *voteidStr = [NSString stringWithFormat:@"%d",voteid];
    [_voteIDs removeObject:voteidStr];
    
    // 存进沙盒
    [NSKeyedArchiver archiveRootObject:voteidStr toFile:MYVoteIDFile];
    
}
+ (void)deleteVoteIDs:(NSArray *)voteids
{
    [_voteIDs removeObjectsInArray:voteids];
    
    // 存进沙盒
    [NSKeyedArchiver archiveRootObject:_voteIDs toFile:MYVoteIDFile];
}

//将图片保存到本地
+ (void)SaveImageToLocal:(UIImage*)image Keys:(NSString*)key {
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    //[preferences persistentDomainForName:LocalPath];
    [preferences setObject:UIImagePNGRepresentation(image) forKey:key];
}


+ (void)SaveStringToLocal:(NSString*)str Keys:(NSString*)key {
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    //[preferences persistentDomainForName:LocalPath];
    [preferences setObject:str forKey:key];
}


//本地是否有相关图片
+ (BOOL)LocalHaveImage:(NSString*)key {
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    //[preferences persistentDomainForName:LocalPath];
    NSData* imageData = [preferences objectForKey:key];
    if (imageData) {
        return YES;
    }
    return NO;
}

//从本地获取图片
+ (UIImage*)GetImageFromLocal:(NSString*)key {
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    //[preferences persistentDomainForName:LocalPath];
    NSData* imageData = [preferences objectForKey:key];
    UIImage* image;
    if (imageData) {
        image = [UIImage imageWithData:imageData];
    }
    else {
        NSLog(@"未从本地获得图片");
    }
    return image;
}
+ (NSString *)GetStrFromLocal:(NSString*)key {
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    //[preferences persistentDomainForName:LocalPath];
    NSString *str = [preferences objectForKey:key];
    NSString *str1;
    if (str) {
        str1 = str;
    }
    else {
        NSLog(@"meiyou");
    }
    return str1;
}
#pragma mark - 是否WIFI
+ (BOOL)IsEnableWIFI
{
    Reachability *hostReach = [Reachability reachabilityWithHostName:SERVER_ADDRESS];
    NetworkStatus netStatus = [hostReach currentReachabilityStatus];
    
    if (netStatus == ReachableViaWiFi) {
        return YES;
    }
    else{
        return NO;
    }
    //    return ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable);
}
#pragma mark - 是否3G
+ (BOOL)IsEnable3G
{
    Reachability *hostReach = [Reachability reachabilityWithHostName:SERVER_ADDRESS];
    NetworkStatus netStatus = [hostReach currentReachabilityStatus];
    
    if (netStatus == ReachableViaWWAN) {
        return YES;
    }
    else{
        return NO;
    }
    //    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}

#pragma mark - 是否没网
+(BOOL)IsNotReachable
{
    Reachability *hostReach = [Reachability reachabilityWithHostName:SERVER_ADDRESS];
    NetworkStatus netStatus = [hostReach currentReachabilityStatus];
    
    if (netStatus == NotReachable) {
        return YES;
    }
    else{
        return NO;
    }
    
}
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
#pragma mark - 获取沙盒Document的文件目录
+ (NSString *)getDocumentDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
#pragma mark - 获取沙盒Library的文件目录
+ (NSString *)getLibraryDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}
#pragma mark - 获取沙盒Library/Caches的文件目录
+ (NSString *)getCachesDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}
#pragma mark - 获取沙盒Preference的文件目录
+ (NSString *)getPreferencePanesDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES) lastObject];
}
#pragma mark - 获取沙盒tmp的文件目录
+ (NSString *)getTmpDirectory{
    return
    NSTemporaryDirectory();
}
#pragma mark - 根据路径返回目录或文件的大小
+ (double)sizeWithFilePath:(NSString *)path{
    // 1.获得文件夹管理者
    NSFileManager *manger = [NSFileManager defaultManager];
    // 2.检测路径的合理性
    BOOL dir = NO;
    BOOL exits = [manger fileExistsAtPath:path isDirectory:&dir];
    if (!exits) return 0;
    // 3.判断是否为文件夹
    if (dir) { // 文件夹, 遍历文件夹里面的所有文件
        // 这个方法能获得这个文件夹下面的所有子路径(直接\间接子路径)
        NSArray *subpaths = [manger subpathsAtPath:path];
        int totalSize = 0;
        for (NSString *subpath in subpaths) {
            NSString *fullsubpath = [path stringByAppendingPathComponent:subpath];
            BOOL dir = NO;
            [manger fileExistsAtPath:fullsubpath isDirectory:&dir];
            if (!dir) { // 子路径是个文件
                NSDictionary *attrs = [manger attributesOfItemAtPath:fullsubpath error:nil];
                totalSize += [attrs[NSFileSize] intValue];
            }
        }
        return totalSize / (1024 * 1024.0);
    } else { // 文件
        NSDictionary *attrs = [manger attributesOfItemAtPath:path error:nil];
        return [attrs[NSFileSize] intValue] / (1024.0 * 1024.0);
    }
}
#pragma mark - 得到指定目录下的所有文件
+ (NSArray *)getAllFileNames:(NSString *)dirPath{
    
    // 获得此程序的沙盒路径
    NSArray *patchs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // 获取Documents路径
    // [patchs objectAtIndex:0]
    NSString *documentsDirectory = [patchs objectAtIndex:0];
    NSString *fileDirectory = [documentsDirectory stringByAppendingPathComponent:dirPath];
    
    
    NSArray *files = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:fileDirectory error:nil];
    return files;
}
#pragma mark - 删除指定目录或文件
+ (BOOL)clearCachesWithFilePath:(NSString *)path{
    NSFileManager *mgr = [NSFileManager defaultManager];
    return [mgr removeItemAtPath:path error:nil];
}


#pragma mark - 清空指定目录下文件
+ (BOOL)clearCachesFromDirectoryPath:(NSString *)dirPath{
    ////    //获得全部文件数组
    //    NSArray *fileAry =  [Tools getAllFileNames:dirPath];
    //    //遍历数组
    //    BOOL flag = NO;
    //    for (NSString *fileName in fileAry) {
    //        NSString *filePath = [dirPath stringByAppendingPathComponent:fileName];
    //        flag = [Tools clearCachesWithFilePath:filePath];
    //    }
    
    BOOL flag = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *subDirList = [fileManager contentsOfDirectoryAtPath:dirPath error:NULL];
    for (NSString *fileName in subDirList) {
        //
        NSString *fullPath = [dirPath stringByAppendingPathComponent:fileName];
        if ([fileManager fileExistsAtPath:fullPath]) {
            flag = [fileManager removeItemAtPath:fullPath error:nil];
            
        }
    }
    
    
    //    NSString *extension = dirPath;
    //    NSFileManager *fileManager = [NSFileManager defaultManager];
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
    //                                          NSUserDomainMask,
    //                                          YES);
    //    NSString *documentsDirectory= [paths objectAtIndex:0];
    //
    //    NSArray *contents = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:NULL];
    //    NSEnumerator *e= [contents objectEnumerator];
    //    NSString *filename;
    //    while ((filename
    //            = [e nextObject])) {
    //
    //        if ([[filename
    //              pathExtension] isEqualToString:extension]) {
    //
    //            [fileManager
    //             removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:filename] error:NULL];
    //        }
    //    }
    
    return flag;
}

+ (BOOL)clearCachesDirectory
{
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   ,^{
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
                       
                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                       NSLog(@"files :%ld",[files count]);
                       for (NSString *p in files) {
                           NSError *error;
                           NSString *path = [cachPath stringByAppendingPathComponent:p];
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                           }
                       }
                       //                       [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];
                   });
    
    
    return YES;
}

+(int)getHeightWithContent:(NSString *)Content
{
    int total_height = 0;
    NSMutableAttributedString  *attributedString =[[NSMutableAttributedString alloc]initWithString:Content];
    CTTextAlignment alignment = kCTJustifiedTextAlignment;
    
    CGFloat paragraphSpacing = 0.0;
    CGFloat paragraphSpacingBefore = 0.0;
    CGFloat firstLineHeadIndent = 0.0;
    CGFloat headIndent = 0.0;
    CGFloat SpecifierLineSpacing=2.0;
    
    
    CTParagraphStyleSetting settings[] =
    {
        {kCTParagraphStyleSpecifierAlignment, sizeof(CTTextAlignment), &alignment},
        {kCTParagraphStyleSpecifierFirstLineHeadIndent, sizeof(CGFloat), & firstLineHeadIndent},
        {kCTParagraphStyleSpecifierHeadIndent, sizeof(CGFloat), &headIndent},
        {kCTParagraphStyleSpecifierParagraphSpacing, sizeof(CGFloat), &paragraphSpacing},
        {kCTParagraphStyleSpecifierParagraphSpacingBefore, sizeof(CGFloat), &paragraphSpacingBefore},
        {kCTParagraphStyleSpecifierLineSpacing,sizeof(CGFloat),&SpecifierLineSpacing}
        
    };
    
    CTParagraphStyleRef style = CTParagraphStyleCreate(settings ,8);
    
    //设置字体及大小
    CTFontRef helveticaBold = CTFontCreateWithName((CFStringRef)@"PingFangSC-Regular",16,NULL);
    [attributedString addAttribute:(id)kCTFontAttributeName value:(__bridge id)helveticaBold range:NSMakeRange(0,[attributedString length])];
    [attributedString addAttribute:(id)kCTParagraphStyleAttributeName value:(__bridge id)style range:NSMakeRange(0 , [attributedString length])];
    CFRelease(helveticaBold);
    CFRelease(style);
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedString);    //string 为要计算高度的NSAttributedString
    CGRect drawingRect = CGRectMake(0, 0, SCREEN_WIDTH-70, 100000);  //这里的高要设置足够大
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, drawingRect);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0,0), path, NULL);
    CGPathRelease(path);
    CFRelease(framesetter);
    
    NSArray *linesArray = (NSArray *) CTFrameGetLines(textFrame);
    
    CGPoint origins[[linesArray count]];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    
    int line_y = (int) origins[[linesArray count] -1].y;  //最后一行line的原点y坐标
    
    CGFloat ascent;
    CGFloat descent;
    CGFloat leading;
    if (linesArray.count) {
        CTLineRef line = (__bridge CTLineRef) [linesArray objectAtIndex:[linesArray count]-1];
        CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
        
        total_height = 100000 - line_y + (int) descent +1;//+1为了纠正descent转换成int小数点后舍去的值
        
        CFRelease(textFrame);
        
        return total_height;
    }else
        return 0;
    
}

/**
 *根据给定的size的宽高比自动缩放原图片、自动判断截取位置,进行图片截取
 * UIImage image 原始的图片
 * CGSize size 截取图片的size
 */
+(UIImage *)clipImage:(UIImage *)image toRect:(CGSize)size{
    //8:5  2:1
    //被切图片宽比例比高比例小 或者相等，以图片宽进行放大
    //    if (image.size.width*size.height <= image.size.height*size.width) {
    
    //        //以被剪裁图片的宽度为基准，得到剪切范围的大小
    //        CGFloat width  = image.size.width;
    //        CGFloat height = image.size.width * size.height / size.width;
    //
    //        // 调用剪切方法
    //        // 这里是以中心位置剪切，也可以通过改变rect的x、y值调整剪切位置
    //        return [self imageFromImage:image inRect:CGRectMake(0, (image.size.height -height)/2, width, height)];
    
    //    }else{
    //        //被切图片宽比例比高比例大，以图片高进行剪裁
    //
    // 以被剪切图片的高度为基准，得到剪切范围的大小
    
    CGFloat height = image.size.height;
    NSLog(@"%lf",image.size.width);
    CGFloat width  = image.size.height * 8.0 / 5.0;
    CGFloat ly = (image.size.width -width)/2;
    // 调用剪切方法
    // 这里是以中心位置剪切，也可以通过改变rect的x、y值调整剪切位置
    return [self imageFromImage:image inRect:CGRectMake((image.size.width -width)/2, 0, width, height)];
    
    //    }
    //    return nil;
}
+(UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect{
    
    //将UIImage转换成CGImageRef
    CGImageRef sourceImageRef = [image CGImage];
    
    //按照给定的矩形区域进行剪裁
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    
    //将CGImageRef转换成UIImage
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    //返回剪裁后的图片
    return newImage;
}
//获取随机uuid
+ (NSString *)randomUUIDString
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}


/**
 高斯模糊
 */
+(UIImage *)coreBlurImage:(UIImage *)image withBlurNumber:(CGFloat)blur
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage= [CIImage imageWithCGImage:image.CGImage];
    //设置filter
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey]; [filter setValue:@(blur) forKey: @"inputRadius"];
    //模糊图片
    CIImage *result=[filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage=[context createCGImage:result fromRect:[result extent]];
    UIImage *blurImage=[UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    return blurImage;
}



/**
 MD5加密
 */
+ (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

/*
 *第二种方法，利用Emoji表情最终会被编码成Unicode，因此，
 *只要知道Emoji表情的Unicode编码的范围，
 *就可以判断用户是否输入了Emoji表情。
 */
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    // 过滤所有表情。returnValue为NO表示不含有表情，YES表示含有表情
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    returnValue = YES;
                }
            }
        } else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                returnValue = YES;
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff) {
                returnValue = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                returnValue = YES;
            }
        }
    }];
    return returnValue;
}

//把大长串的数字做单位处理
+ (NSString *)changeAsset:(NSString *)amountStr
{
    
    if (amountStr && ![amountStr isEqualToString:@""])
    {
        NSInteger num = [amountStr integerValue];
        if (num<10000)
        {
            return amountStr;
        }
        else
        {
            NSString *str = [NSString stringWithFormat:@"%f",num/10000.0];
            str = [self decimalwithFormat:@"0.0" floatV:[str floatValue]];
            NSRange range = [str rangeOfString:@"."];
            str = [str substringToIndex:range.location+2];
            if ([str hasSuffix:@".0"])
            {
                return [NSString stringWithFormat:@"%@W",[str substringToIndex:str.length-2]];
            }
            else
                return [NSString stringWithFormat:@"%@W",str];
        }
    }else{
        return @"0";
    }
    
}

//格式话小数 四舍五入类型
+ (NSString *) decimalwithFormat:(NSString *)format  floatV:(float)floatV
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:format];
    
    return  [numberFormatter stringFromNumber:[NSNumber numberWithFloat:floatV]];
}

//特殊字符转码工具
+(NSString *)encodeStrCFBridgingRelease:(NSString *)str
{
    //    NSString *encodeStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, NULL, (CFStringRef)@"!*'();:@&=+ $,./?%#[]", kCFStringEncodingUTF8));
    
    NSString *encodeStr = (__bridge_transfer  NSString*) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)str, NULL, (__bridge CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 );
    
    return encodeStr;
}

//获取 webview html源码
+(NSString *)getWebviewHTMLContent:(id)webView
{
    
    __block NSString *_htmlStr;
    if ([webView class] == [WKWebView class]) {
        NSString *doc = @"document.body.outerHTML";
        //        NSString *doc = @"document.documentElement.outerHTML.toString()";
        [webView evaluateJavaScript:doc
                  completionHandler:^(id _Nullable htmlStr, NSError * _Nullable error) {
                      if (error) {
                          NSLog(@"JSError:%@",error);
                      }
                      NSLog(@"html:%@",htmlStr);
                      _htmlStr = htmlStr;
                  }] ;
    }else{
        NSString *doc     = @"document.body.outerHTML";
        NSString *htmlStr = [webView stringByEvaluatingJavaScriptFromString:doc];
        NSLog(@"----%@",htmlStr);
    }
    
    return _htmlStr;
}
+(NSString *)threeCount:(NSString *)str
{
    str = [NSString stringWithFormat:@"%@",str];
    NSString *tstr = @"00";
    if ([str containsString:@"."]) {
        tstr = [str componentsSeparatedByString:@"."][1];
        str = [str componentsSeparatedByString:@"."][0];
    }
    int devideCount = 3;
    NSMutableArray *items = @[].mutableCopy;
    int charCount = str.length;
    int start = charCount - devideCount;
    while (start >= 0) {
        NSString *c = [str substringWithRange:NSMakeRange(start, devideCount)];
        [items insertObject:c atIndex:0];
        start -= devideCount;
    }
    if (items.count * devideCount < charCount) {
        [items insertObject:[str substringToIndex:start + devideCount] atIndex:0];
    }
    NSString *newStr = [items componentsJoinedByString:@","];
    newStr = [newStr stringByAppendingString:[NSString stringWithFormat:@".%@",tstr]];
    
    NSLog(@"%@", newStr);
    return newStr;
}

//tableview footer H
+(UIView *)creatTableViewFooterView
{
    UIView *footerView = [[UIView alloc] init];
    footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    footerView.backgroundColor = WhiteColor;
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, SCREEN_WIDTH, 12);
    label.center = CGPointMake(SCREEN_WIDTH/2, TableViewFooterH/2);
    label.font = PingFangSC_Regular(12);
    label.text = @"已显示全部";
    label.textColor = ColorGrayText;
    label.textAlignment = NSTextAlignmentCenter;
    [footerView addSubview:label];
    
    return footerView;
    
}
+(UIView *)creatTableViewFooterViewWithFrame:(CGRect)frame
{
    UIView *footerView = [[UIView alloc] init];
    footerView.frame = frame;
    footerView.backgroundColor = WhiteColor;
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, frame.size.width, 12);
    label.center = CGPointMake( frame.size.width/2, TableViewFooterH/2);
    label.font = PingFangSC_Regular(12);
    label.text = @"已显示全部";
    label.textColor = ColorGrayText;
    label.textAlignment = NSTextAlignmentCenter;
    [footerView addSubview:label];
    
    footerView.layer.cornerRadius = 0.;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:footerView.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight)  cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = footerView.bounds;
    maskLayer.path = maskPath.CGPath;
    footerView.layer.mask = maskLayer;
    
    return footerView;
    
}

+(NSString *)getStringSizeWithFloat:(float)sender
{
    NSString *sizeStr;
    if (sender>=1024) {
        sizeStr = [NSString stringWithFormat:@"%.2fGB",sender/1024];
    }else if (sender >= 1){
        sizeStr = [NSString stringWithFormat:@"%.2fMB",sender];
    }else{
        sizeStr = [NSString stringWithFormat:@"%.2fKB",sender * 1024];
    }
    
    return sizeStr;
}

+(UIImageView *)makeLeadingView:(UIImage *)image
{
    UIImageView *imageV = [[UIImageView alloc]initWithImage:image];
    return imageV;
}
+(NSString *)JiaMiUserId
{
    NSString *userid = [[SingleTon getInstance].landScuessDic valueForKey:@"returnuid"];
    if (userid) {
        NSString *qwer = [RSA DESEncryptWithBase64:[NSString stringWithFormat:@"%@",userid] key:@"qazwsxedcrfv"];
        NSString *newQwer =[[Tools alloc] stringByURLEncodingStringParameter:qwer];
        return newQwer;
    }
    else
    {
        return @"";
    }
}
+(NSString *)JiaMiUserId:(NSString *)userId
{
    if (userId) {
        NSString *qwer = [RSA DESEncryptWithBase64:[NSString stringWithFormat:@"%@",userId] key:@"qazwsxedcrfv"];
        NSString *newQwer =[[Tools alloc] stringByURLEncodingStringParameter:qwer];
        
        return newQwer;
    }
    else
    {
        return @"";
    }
}
+(NSString *)jiemi:(NSString *)pass
{
    if (pass) {
        NSString *qwer = [RSA DESDecryptBase64:[NSString stringWithFormat:@"%@",pass] key:@"qazwsxedcrfv"];
        NSString *newQwer =[[Tools alloc] stringByURLEncodingStringParameter:qwer];
        
        return newQwer;
    }
    else
    {
        return @"";
    }
}
//判断是否是手机号
+(BOOL)validateMobile:(NSString*)mobileNum
{
    if (mobileNum.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    /**
     25     * 大陆地区固话及小灵通
     26     * 区号：010,020,021,022,023,024,025,027,028,029
     27     * 号码：七位或八位
     28     */
    //  NSString * PHS = @"^(0[0-9]{2})\\d{8}$|^(0[0-9]{3}(\\d{7,8}))$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//获取当前控制器
+ (UIViewController *)getCurrentVC
{
    //获得当前活动窗口的根视图
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}
@end

