//
//  TTSubscribeAuthorViewModel.m
//  MyCustom
//
//  Created by houke on 2018/9/13.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "TTSubscribeAuthorViewModel.h"
#import "MJExtension.h"

@interface TTSubscribeAuthorViewModel ()

@end

@implementation TTSubscribeAuthorViewModel
-(NSMutableArray *)authorArr
{
    if (!_authorArr) {
        _authorArr = [NSMutableArray array];
    }
    return _authorArr;
}
-(NSMutableArray *)subscribeNewsArr{
    if (!_subscribeNewsArr) {
        _subscribeNewsArr = [NSMutableArray arrayWithCapacity:10];
    }
    return _subscribeNewsArr;
}
#pragma mark 我的订阅

-(void)getSubscribeList:(void (^)(NSInteger))finish {
    NSString *url = @"http://apidev.ttplus.cn/subscribe/editor_page?pageNumber=1&pageSize=10&userId=61";
    [HttpTool httpGet:url params:nil success:^(id responseObject) {
        if ([[responseObject objectForKey:@"type"] isEqualToString:@"success"]) {
            NSArray *tempArr = [responseObject objectForKey:@"content"];
            if (tempArr.count > 0) {
                finish(tempArr.count);
            }else{
                finish(0);
            }
        }else{
            finish(0);
        }
    } failure:^(NSError *error) {
        finish(0);
    }];
}
#pragma mark 推荐大咖
-(void) getRecommendAutorList:(void (^)(BOOL))finish {
    NSString *url = @"http://apidev.ttplus.cn/editor/suggest?userId=50004&limit=100";
    [HttpTool httpGet:url params:nil success:^(id responseObject) {
        
        if ([[responseObject objectForKey:@"type"] isEqual:@"success"]) {
            
            NSArray *array = [TTSubscribeAuthorModel objectArrayWithKeyValuesArray:[[responseObject objectForKey:@"content"] objectForKey:@"list"]];
            [self.authorArr addObjectsFromArray:array];
            
            self.authorArr = [NSMutableArray arrayWithArray:[self.authorArr subarrayWithRange:NSMakeRange(0, 5)]];
            finish(YES);
        }else{
            finish(NO);
        }
        
    } failure:^(NSError *error) {
        finish(NO);
    }];
}
#pragma mark 订阅作者新闻
-(void)getSubscribeAuthorNewsList:(void (^)(bool))finish
{
    NSString *url = @"http://apidev.ttplus.cn/subscribe/user?userid=5x4EhhMRX4s%3D&pagenum=0";
    [HttpTool httpPost:url params:nil success:^(id responseObject) {
        [self.subscribeNewsArr addObjectsFromArray:[TTSubscribeAuthorModel objectArrayWithKeyValuesArray:[responseObject objectForKey:@"rows"]]];
        finish(true);
    } failure:^(NSError *error) {
      finish(false);
    }];
}

#pragma mark 订阅或取消订阅作者
-(void)addSubscribe:(NSString *)editorid finish:(void (^)(bool))finish{
    //    addSubscrStr=[NSString stringWithFormat:@"%@?editorid=%@&userid=%@",[TTInitInterfaceManager getUrlWithKey:Init_app url:@"removesub"],[Tools JiaMiUserId:_cellModel.authorId],[Tools JiaMiUserId]];
    NSString *url = [NSString stringWithFormat:@"http://apidev.ttplus.cn/subscribe/add?editorid=%@&userid=%@",[EncryptTool JiaMiUserId:editorid], [EncryptTool JiaMiUserId:@"61"]];
    [HttpTool httpPost:url params:nil success:^(id responseObject) {
        if ([[responseObject valueForKey:@"returncode"]intValue]==1) {
            finish(true);
        }else{
            finish(false);
        }
    } failure:^(NSError *error) {
        finish(false);
    }];
}
-(void)removeSubscribe:(NSString *)editorid finish:(void (^)(bool))finish{
//    addSubscrStr=[NSString stringWithFormat:@"%@?editorid=%@&userid=%@",[TTInitInterfaceManager getUrlWithKey:Init_app url:@"addsub"],[Tools JiaMiUserId:_cellModel.authorId],[Tools JiaMiUserId]];
    NSString *url = [NSString stringWithFormat:@"http://apidev.ttplus.cn/subscribe/remove?editorid=%@&userid=%@",[EncryptTool JiaMiUserId:editorid], [EncryptTool JiaMiUserId:@"61"]];
    [HttpTool httpPost:url params:nil success:^(id responseObject) {
        if ([[responseObject valueForKey:@"returncode"]intValue]==1) {
            finish(true);
        }else{
            finish(false);
        }
    } failure:^(NSError *error) {
        finish(false);
    }];
}

@end
