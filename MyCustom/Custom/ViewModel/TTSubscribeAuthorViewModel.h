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

-(void)getSubscribeList:(void (^)(bool))finish;
-(void) getRecommendAutorList:(void (^)(BOOL))finish;
-(void)getSubscribeAuthorNewsList:(void (^)(bool))finish;
@end
