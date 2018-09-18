//
//  TTSubscribeAuthorViewModel.h
//  MyCustom
//
//  Created by houke on 2018/9/13.
//  Copyright © 2018年 houke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTSubscribeAuthorModel.h"

@interface TTSubscribeAuthorViewModel : NSObject
@property (nonatomic, strong) NSMutableArray *authorArr;
@property (nonatomic, strong) NSMutableArray *subscribeNewsArr;
@property (nonatomic, strong) NSMutableArray *authorTypeArr;
@property (nonatomic, strong) NSMutableArray *mySubArr;
@property (nonatomic, strong) NSMutableArray *categoryArr;//分类作者新闻
@property (nonatomic, strong) NSMutableArray *mySubNewsArr;//我的订阅新闻列表

-(void)getSubscribeList:(void (^)(bool))finish ;
-(void)getRecommendAutorList:(void (^)(BOOL))finish;
-(void)getSubscribeAuthorNewsList:(void (^)(bool))finish;
-(void)getAuthorTypeList:(void (^)(bool))finish;
-(void)getMySubscribeAuthorNewsList:(void (^)(bool))finish;
-(void)getCategoryAuthNewsList:(NSNumber *)categoryId finish:(void (^)(bool))finish;

-(void)addSubscribe:(NSString *)editorid finish:(void (^)(bool))finish;
-(void)removeSubscribe:(NSString *)editorid finish:(void (^)(bool))finish;

-(void)pushToMySubscribe;
-(void)pushToSubscribeManager;
-(void)getBack;
-(void)reloadCategoryTableView;
@end
