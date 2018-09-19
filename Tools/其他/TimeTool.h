//
//  TimeTool.h
//  Tian_IOS
//
//  Created by mac on 2017/4/25.
//  Copyright © 2017年 RichyLeo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeTool : NSObject

+ (NSString *)changeTimeToYMD:(id)newTime;
+ (NSString *)changeTimeToMDHM:(id)newTime;
+ (NSString *)changeTimeToHM:(id)newTime;
+ (NSString *)changeTimeToMD:(id)newTime;
+(NSString *)compareCurrentTime:(id)compareDate;
//播放时长转化
+ (NSString *)timeFormatted:(int)totalSeconds;

+ (NSString *)LiveChangeTimeToMD:(id)newTime;
+ (NSString *)LiveChangeTimeToHM:(id)newTime;
+ (NSString *)LiveChangeTimeToweek:(id)newTime;
+ (NSString *)LiveChangeTimeToYMD:(id)newTime;
+ (NSString *)changeTimeToYMDHM:(id)newTime;
+ (NSString *)getNowTimeTimestamp;
@end
