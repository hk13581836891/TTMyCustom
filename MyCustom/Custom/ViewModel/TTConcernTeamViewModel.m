//
//  TTConcernTeamViewModel.m
//  MyCustom
//
//  Created by houke on 2018/9/14.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "TTConcernTeamViewModel.h"
#import "MJExtension.h"

@interface TTConcernTeamViewModel ()

@property (nonatomic, strong) NSMutableArray *teamTypeArr;
@property (nonatomic, strong) NSMutableArray *teamArr;
@end

@implementation TTConcernTeamViewModel

-(NSMutableArray *)concernTeamArr
{
    if (!_concernTeamArr) {
        _concernTeamArr = [NSMutableArray array];
    }
    return _concernTeamArr;
}

-(NSMutableArray *)teamTypeArr
{
    if (!_teamTypeArr) {
        _teamTypeArr = [NSMutableArray array];
    }
    return _teamTypeArr;
}
-(NSMutableArray *)recommendTeamArr{
    if (!_recommendTeamArr) {
        _recommendTeamArr = [NSMutableArray array];
    }
    return _recommendTeamArr;
}
-(NSMutableArray *)teamArr{
    if (!_teamArr) {
        _teamArr = [NSMutableArray array];
    }
    return _teamArr;
}
-(NSMutableArray *)categoryTeamArr{
    if (!_categoryTeamArr) {
        _categoryTeamArr = [NSMutableArray array];
    }
    return _categoryTeamArr;
}
#pragma mark 获取已关注球队列表
-(void)getConcernTeamList:(void(^)(bool))finish
{
//    NSString * followList = [TTInitInterfaceManager getUrlWithKey:Init_app url:@"custom_follow_list"];
//    followList = [NSString stringWithFormat:@"%@?userId=%@&pageNumber=1&pageSize=20",followList,USERID];
    NSString *url = @"http://api.ttplus.cn/custom_news/follow_list?userId=61&pageNumber=1&pageSize=20";
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

#pragma mark 获取推荐球队列表
-(void)getRecommendTeamDataList:(void (^)(bool))finish
{
//    NSString *secondaryUrl = [TTInitInterfaceManager getUrlWithKey:Init_app url:@"custom_secondary"];
//    secondaryUrl = [NSString stringWithFormat:@"%@?pid=%@&userId=%@&pageNumber=1&pageSize=30",secondaryUrl,pid,USERID];
    NSString *url = [NSString stringWithFormat:@"http://api.ttplus.cn/custom_news/secondary?pid=%@&userId=61&pageNumber=1&pageSize=30",@(0)];
    [HttpTool httpPost:url params:nil success:^(id responseObject) {
        if ([[responseObject objectForKey:@"type"] isEqualToString:@"success"]) {
            NSArray *tempArr = [TTConcernTeamModel objectArrayWithKeyValuesArray:[responseObject objectForKey:@"content"]];
            [self.recommendTeamArr addObjectsFromArray:tempArr];
            finish(true);
        }else{
            finish(false);
        }
    } failure:^(NSError *error) {
        finish(false);
    }];
}

#pragma mark 获取球队类型id
-(void)getTeamTypeList
{
    //    NSString *rootUrl = [TTInitInterfaceManager getUrlWithKey:Init_app url:@"custom_root"];
    NSString *url = @"http://api.ttplus.cn/custom_news/root";
    [HttpTool httpPost:url params:nil success:^(id responseObject) {
        if ([[responseObject objectForKey:@"type"] isEqualToString:@"success"]) {
            NSArray *tempArr = [TTConcernTeamModel objectArrayWithKeyValuesArray:[responseObject objectForKey:@"content"]];
            [self.teamTypeArr addObjectsFromArray:tempArr];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)getCategoryTeamList:(NSNumber *)categoryId finish:(void (^)(bool))finish{
//    NSString *secondaryUrl = [TTInitInterfaceManager getUrlWithKey:Init_app url:@"custom_secondary"];
//    secondaryUrl = [NSString stringWithFormat:@"%@?pid=%@&userId=%@&pageNumber=1&pageSize=30",secondaryUrl,pid,USERID];
    NSString *url = [NSString stringWithFormat:@"http://api.ttplus.cn/custom_news/secondary?pid=%@&userId=61&pageNumber=1&pageSize=100",categoryId];
    [HttpTool httpPost:url params:nil success:^(id responseObject) {
        if ([[responseObject objectForKey:@"type"] isEqualToString:@"success"]) {
            if (self.categoryTeamArr) {
                [self.categoryTeamArr removeAllObjects];
            }
            
            NSArray *tempArr = [TTConcernTeamModel objectArrayWithKeyValuesArray:[responseObject objectForKey:@"content"]];
            [self.categoryTeamArr addObjectsFromArray:tempArr];
            
            finish(true);
        }else{
            finish(false);
        }
    } failure:^(NSError *error) {
        finish(false);
    }];
}
#pragma mark 球队关注或取消关注
-(void)concernCancelTeam:(NSNumber *)wordId status:(NSString *)status finish:(void (^)(bool))finish{
    NSString *url = [NSString stringWithFormat:@"http://api.ttplus.cn/custom_news/follow?userId=61&wordId=%@&status=%@",wordId,status];
    [HttpTool httpPost:url params:nil success:^(id responseObject) {
        if ([[responseObject objectForKey:@"type"] isEqualToString:@"success"]) {
            
            finish(true);
        }else{
            finish(false);
        }
    } failure:^(NSError *error) {
        finish(false);
    }];
}

-(void)pushToConcerTeam{}
-(void)getBack{}
@end















