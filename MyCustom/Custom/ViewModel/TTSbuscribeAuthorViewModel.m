//
//  TTSbuscribeAuthorViewModel.m
//  MyCustom
//
//  Created by houke on 2018/9/13.
//  Copyright © 2018年 houke. All rights reserved.
//

#import "TTSbuscribeAuthorViewModel.h"
#import "MJExtension.h"

@interface TTSbuscribeAuthorViewModel ()

@end

@implementation TTSbuscribeAuthorViewModel
-(NSMutableArray *)authorArr
{
    if (!_authorArr) {
        _authorArr = [NSMutableArray array];
    }
    return _authorArr;
}

-(void) getRecommendAutorList:(void (^)(BOOL))finish {
    NSString *url = @"http://apidev.ttplus.cn/editor/suggest?userId=50004&limit=100";
    [HttpTool httpGet:url params:nil success:^(id responseObject) {
        
        if ([[responseObject objectForKey:@"type"] isEqual:@"success"]) {
            
            NSArray *array = [TTSbuscribeAuthorModel objectArrayWithKeyValuesArray:[[responseObject objectForKey:@"content"] objectForKey:@"list"]];
            [self.authorArr addObjectsFromArray:array];
            
            self.authorArr = [NSMutableArray arrayWithArray:[self.authorArr subarrayWithRange:NSMakeRange(0, 10)]];
            finish(YES);
        }else{
            finish(NO);
        }
        
    } failure:^(NSError *error) {
        finish(NO);
    }];
}
@end
