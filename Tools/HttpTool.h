//
//  HttpTool.h
//  Tian_IOS
//
//  Created by 杨锐 on 16/9/14.
//  Copyright © 2016年 RichyLeo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^success)(NSDictionary *response);
typedef void(^failure)(NSError *error);
@interface HttpTool : NSObject
+ (void)httpGet:(NSString *)baseUrl params:(id)params target:(id)target success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

+ (void)httpGetHeader:(NSString *)baseUrl params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

+ (void)httpPost:(NSString *)baseUrl params:(id)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

//竞猜添加无target
+ (void)httpGet:(NSString *)baseUrl params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

//IAP
+ (void)postWithUrl:(NSString *)url body:(NSData *)body showLoading:(BOOL)show success:(void(^)(NSDictionary *response))success failure:(void(^)(NSError *error))failure;
@end
