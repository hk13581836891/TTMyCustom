//
//  TimeTool.m
//  Tian_IOS
//
//  Created by mac on 2017/4/25.
//  Copyright © 2017年 RichyLeo. All rights reserved.
//

#import "TimeTool.h"

@implementation TimeTool
+ (NSString *)LiveChangeTimeToweek:(id)newTime
{
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null],   @"星期日",@"星期一", @"星期二", @"星期三", @"星期四", @"星期五",@"星期六", nil];
    NSTimeInterval time= [newTime doubleValue];//因为时差问题要加8小时 == 28800 sec
    NSDate * date= [NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    
    return [weekdays objectAtIndex:theComponents.weekday];
}
+ (NSString *)LiveChangeTimeToYMD:(id)newTime
{
    NSString *timeTmp;
    //    long long newstime = [newTime longLongValue];
    NSTimeInterval time=[newTime doubleValue];//因为时差问题要加8小时 == 28800 sec
    NSDate * date= [NSDate dateWithTimeIntervalSince1970:time];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth | NSCalendarUnitDay| NSCalendarUnitYear fromDate:date];
    NSInteger day = [components day];
    NSInteger month= [components month];
    NSInteger year = [components year];

    timeTmp = [NSString stringWithFormat:@"%02ld-%02ld-%02ld",(long)year,(long)month,(long)day];
    return timeTmp;
}
+ (NSString *)LiveChangeTimeToMD:(id)newTime
{
    NSString *timeTmp;
    //    long long newstime = [newTime longLongValue];
    NSTimeInterval time=[newTime doubleValue];//因为时差问题要加8小时 == 28800 sec
    NSDate * date= [NSDate dateWithTimeIntervalSince1970:time];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth | NSCalendarUnitDay| NSCalendarUnitHour |NSCalendarUnitMinute fromDate:date];
    NSInteger day = [components day];
    NSInteger month= [components month];
    //    NSInteger hour = [components hour];
    //    NSInteger minute = [components minute];
    timeTmp = [NSString stringWithFormat:@"%02ld-%02ld",(long)month,(long)day];
    return timeTmp;
}
+ (NSString *)LiveChangeTimeToHM:(id)newTime
{
    NSString *timeTmp;
    //    long long newstime = [newTime longLongValue];
    NSTimeInterval time=[newTime doubleValue];
    NSDate * date= [NSDate dateWithTimeIntervalSince1970:time];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth | NSCalendarUnitDay| NSCalendarUnitHour |NSCalendarUnitMinute fromDate:date];
//    NSInteger day = [components day];
//    NSInteger month= [components month];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    timeTmp = [NSString stringWithFormat:@"%02ld:%02ld",(long)hour,(long)minute];
    return timeTmp;
}
+ (NSString *)changeTimeToMDHM:(id)newTime{
    NSString *timeTmp;
    
    long long newstime = [newTime longLongValue];
    NSDate * date= [NSDate dateWithTimeIntervalSince1970:newstime/1000];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit |NSMinuteCalendarUnit fromDate:date];
    NSInteger day = [components day];
    NSInteger month= [components month];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    timeTmp = [NSString stringWithFormat:@"%02ld-%02ld %02ld:%02ld", (long)month,(long)day,(long)hour,(long)minute];
    return timeTmp;

}

+ (NSString *)changeTimeToYMDHM:(id)newTime{
    NSString *timeTmp;
    
    long long newstime = [newTime longLongValue];
    NSDate * date= [NSDate dateWithTimeIntervalSince1970:newstime/1000];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit |NSMinuteCalendarUnit fromDate:date];
    NSInteger year = [components year];
    NSInteger day = [components day];
    NSInteger month= [components month];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    timeTmp = [NSString stringWithFormat:@"%02ld.%02ld.%02ld %02ld:%02ld",(long)year ,(long)month,(long)day,(long)hour,(long)minute];
    return timeTmp;
    
}
+ (NSString *)changeTimeToYMD:(id)newTime{
    NSString *timeTmp;
    
    long long newstime = [newTime longLongValue];
    NSDate * date= [NSDate dateWithTimeIntervalSince1970:newstime/1000];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit |NSMinuteCalendarUnit fromDate:date];
    NSInteger year = [components year];
    NSInteger day = [components day];
    NSInteger month= [components month];
    timeTmp = [NSString stringWithFormat:@"%04ld.%02ld.%02ld",(long)year, (long)month,(long)day];
    return timeTmp;

}

+ (NSString *)changeTimeToHM:(id)newTime{
    NSString *timeTmp;
    
    long long newstime = [newTime longLongValue];
    NSDate * date= [NSDate dateWithTimeIntervalSince1970:newstime/1000];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit |NSMinuteCalendarUnit fromDate:date];
    NSInteger day = [components day];
    NSInteger month= [components month];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    timeTmp = [NSString stringWithFormat:@"%02ld:%02ld",(long)hour,(long)minute];
    return timeTmp;
}
+ (NSString *)changeTimeToMD:(id)newTime{
    NSString *timeTmp;
    
    long long newstime = [newTime longLongValue];
    NSDate * date= [NSDate dateWithTimeIntervalSince1970:newstime/1000];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit |NSMinuteCalendarUnit fromDate:date];
    NSInteger day = [components day];
    NSInteger month= [components month];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    timeTmp = [NSString stringWithFormat:@"%02ld-%02ld",(long)month,(long)day];
    return timeTmp;
}

+(NSString *)compareCurrentTime:(id)compareDate
{
//    long long newstime = [compareDate longLongValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[compareDate longLongValue]/1000];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:date toDate:[NSDate date] options:0];
    components = [calendar components:(NSCalendarUnitSecond) fromDate:date toDate:[NSDate date] options:0];
    if (components.second < 60) {
        return [NSString stringWithFormat:@"刚刚"];
    }
    components = [calendar components:(NSCalendarUnitMinute) fromDate:date toDate:[NSDate date] options:0];
    if (components.minute < 60) {
        return [NSString stringWithFormat:@"%ld分钟前",components.minute];
    }
    components = [calendar components:(NSCalendarUnitHour) fromDate:date toDate:[NSDate date] options:0];
    if (components.hour < 24) {
       return [NSString stringWithFormat:@"%ld小时前",components.hour];
    }
    components = [calendar components:(NSCalendarUnitMonth) fromDate:date toDate:[NSDate date] options:0];
    NSDateFormatter *formatter = [NSDateFormatter new];
    if ([calendar component:(NSCalendarUnitYear) fromDate:date] == [calendar component:(NSCalendarUnitYear) fromDate:[NSDate date]]) {
        formatter.dateFormat =  @"MM-dd HH:mm";
        return [formatter stringFromDate:date];
    }
    formatter.dateFormat =  @"yyyy-MM-dd HH:mm";
    return [formatter stringFromDate:date];

//    long long newstime = [compareDate longLongValue];
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:newstime/1000];
//    NSTimeInterval  timeInterval = [[NSDate dateWithTimeIntervalSince1970:newstime / 1000] timeIntervalSinceNow];
//    timeInterval = -timeInterval;
//    long temp = 0;
//    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit |NSMinuteCalendarUnit fromDate:date];
//    NSInteger day = [components day];
//    NSInteger month= [components month];
//    NSInteger hour = [components hour];
//    NSInteger minute = [components minute];
//    NSInteger year = [components year];
//
//    NSString *result;
//    if (timeInterval < 60) {
//        result = [NSString stringWithFormat:@"刚刚"];
//    }
//    else if((temp = timeInterval/60) <60){
//        result = [NSString stringWithFormat:@"%ld分钟前",temp];
//    }
//
//    else if((temp = temp/60) <24){
//        result = [NSString stringWithFormat:@"%ld小时前",temp];
//    }else if((temp = temp/24) <30){
////        result = [NSString stringWithFormat:@"%ld天前",temp];
//        result = [NSString stringWithFormat:@"%02ld-%02ld %02ld:%02ld", (long)month,(long)day,(long)hour,(long)minute];
//    }
//
//    else if((temp = temp/30) <12){
////        result = [NSString stringWithFormat:@"%ld月前",temp];
//
//        //获取当前年份
//        NSDate *now = [NSDate date];
//        NSCalendar *calendar = [NSCalendar currentCalendar];
//        NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
//        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
//
//        NSInteger currentYear =(NSInteger) [dateComponent year];
//        if (year == currentYear) {
//            result = [NSString stringWithFormat:@"%02ld-%02ld %02ld:%02ld", (long)month,(long)day,(long)hour,(long)minute];
//        }else{
//            result = [NSString stringWithFormat:@"%04ld-%02ld-%02ld %02ld:%02ld", (long)year, (long)month,(long)day,(long)hour,(long)minute];
//        }
//
//    }
//    else{
//        temp = temp/12;
////        result = [NSString stringWithFormat:@"%ld年前",temp];
//        result = [NSString stringWithFormat:@"%04ld-%02ld-%02ld %02ld:%02ld", (long)year, (long)month,(long)day,(long)hour,(long)minute];
//    }
//    return  result;
}

//播放时长转化
+ (NSString *)timeFormatted:(int)totalSeconds{
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    
    NSString *duration ;
    if (hours>0) {
        duration = [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
    }else{
        duration = [NSString stringWithFormat:@"%02d:%02d",minutes, seconds];
    }
    return duration;
}

//获取当前时间戳  （以毫秒为单位）
+ (NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    
    return timeSp;
    
}

@end
