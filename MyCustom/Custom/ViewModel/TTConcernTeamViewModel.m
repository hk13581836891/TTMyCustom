//
//  TTConcernTeamViewModel.m
//  MyCustom
//
//  Created by houke on 2018/9/14.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "TTConcernTeamViewModel.h"
#import "MJExtension.h"

@implementation TTConcernTeamViewModel

-(NSMutableArray *)concernTeamArr
{
    if (!_concernTeamArr) {
        _concernTeamArr = [NSMutableArray array];
    }
    return _concernTeamArr;
}

//获取已关注球队列表
-(void)getConcernTeamList:(void(^)(bool))finish
{
//    NSString * followList = [TTInitInterfaceManager getUrlWithKey:Init_app url:@"custom_follow_list"];
//    followList = [NSString stringWithFormat:@"%@?userId=%@&pageNumber=1&pageSize=20",followList,USERID];
    NSString *url = @"http://apidev.ttplus.cn/custom_news/follow_list?userId=61&pageNumber=1&pageSize=20";
    [HttpTool httpPost:url params:nil success:^(id responseObject) {
        if ([[responseObject objectForKey:@"type"] isEqualToString:@"success"]) {
            if (self.concernTeamArr) {
                [self.concernTeamArr removeAllObjects];
            }
            NSArray *tempArr = [TTConcernTeamModel objectArrayWithKeyValuesArray:[responseObject objectForKey:@"content"]];
            [self.concernTeamArr addObjectsFromArray:tempArr];
            finish(true);
        }else{
            finish(false);
        }
    } failure:^(NSError *error) {
        finish(false);
    }];
}
@end
