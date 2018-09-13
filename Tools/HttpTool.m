//
//  HttpTool.m
//  Tian_IOS
//
//  Created by 杨锐 on 16/9/14.
//  Copyright © 2016年 RichyLeo. All rights reserved.
//

#import "HttpTool.h"

@implementation HttpTool
+ (void)httpGet:(NSString *)baseUrl params:(id)params target:(id)target success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    [self http:@"GET" baseUrl:baseUrl params:params target:target success:success failure:failure];
}

+ (void)httpPost:(NSString *)baseUrl params:(id)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    [self http:@"POST" baseUrl:baseUrl params:params target:nil success:success failure:failure];
}


+ (void)http:(NSString *)type baseUrl:(NSString *)baseUrl params:(id)params target:(id)target success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure {
    
    if(!baseUrl)
    {
        baseUrl = @"";
        return;
    }
    if ([baseUrl containsString:@"(null)"]) {
        baseUrl = [baseUrl stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject: @"text/html"];
//    [manager.requestSerializer setTimeoutInterval:TimeoutInterval];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    NSString *dev_os = [[UIDevice currentDevice] systemVersion];
    NSString *tinfo_version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *newUserAgent = [NSString stringWithFormat:@"(ttplus/%@/iOS%@)",tinfo_version,dev_os];//自定义需要拼接的字符串
    [manager.requestSerializer setValue:newUserAgent forHTTPHeaderField:@"User-Agent"];
    if ([type isEqualToString:@"POST"]) {
        NSString *URLString = baseUrl;
        if ([URLString containsString:@"footOdds/betOdds"] || [URLString containsString:@"footOdds/tgoldToGussBill"]|| [URLString containsString:@"ruowei/order"]|| [URLString containsString:@"mobile_package/list"]|| [URLString containsString:@"mobile_package/record_list"]||[URLString containsString:@"footOdds/gussBillToTgold"]) {
            
//            [manager.requestSerializer setValue:SECRET_KEY forHTTPHeaderField:@"API_KEY"];
//            [manager.requestSerializer setValue:USERID forHTTPHeaderField:@"USER_ID"];
//            [manager.requestSerializer setValue:[[USER_DEFAULT objectForKey:@"user"] objectForKey:@"apiValueMd5"]  forHTTPHeaderField:@"API_VALUE"];
        }
       
        [manager POST:baseUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
           
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                if ([responseObject isKindOfClass:[NSData class]]) {
                    responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                }
                success(responseObject);
                
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
          
        }];
    }
    else {
        [manager GET:baseUrl parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                if ([responseObject isKindOfClass:[NSData class]]) {
                    responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                }
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
           
        }];
    }
}

+ (void)httpsPostPay:(NSString *)baseUrl params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    AFSecurityPolicy *securitePolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securitePolicy.allowInvalidCertificates = YES;
    [securitePolicy setValidatesDomainName:NO];
    manager.securityPolicy = securitePolicy;
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject: @"text/html"];
    NSString *dev_os = [[UIDevice currentDevice] systemVersion];
    NSString *tinfo_version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *newUserAgent = [NSString stringWithFormat:@"(ttplus/%@/iOS%@)",tinfo_version,dev_os];//自定义需要拼接的字符串
    [manager.requestSerializer setValue:newUserAgent forHTTPHeaderField:@"User-Agent"];
    if(!baseUrl)
    {
        baseUrl = @"";
        return;
    }
    if ([baseUrl containsString:@"(null)"]) {
        baseUrl = [baseUrl stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    }
    [manager POST:baseUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            if ([responseObject isKindOfClass:[NSData class]]) {
                responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            }
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        
    }];
  
}
+ (void)httpGet:(NSString *)baseUrl params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    if(!baseUrl)
    {
        baseUrl = @"";
        return;
    }
    if ([baseUrl containsString:@"(null)"]) {
        baseUrl = [baseUrl stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    
    if ([params isKindOfClass:[NSDictionary class]] && [params objectForKey:@"TimeoutInterval"]) {
        [manager.requestSerializer setTimeoutInterval:[[params objectForKey:@"TimeoutInterval"] floatValue]];
    }else{
       [manager.requestSerializer setTimeoutInterval:10];
    }
    NSString *dev_os = [[UIDevice currentDevice] systemVersion];
    NSString *tinfo_version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *newUserAgent = [NSString stringWithFormat:@"(ttplus/%@/iOS%@)",tinfo_version,dev_os];//自定义需要拼接的字符串
    [manager.requestSerializer setValue:newUserAgent forHTTPHeaderField:@"User-Agent"];
    [manager GET:baseUrl parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            if ([responseObject isKindOfClass:[NSData class]]) {
                responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            }
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        
    }];

}

+ (void)httpGetHeader:(NSString *)baseUrl params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    if(!baseUrl)
    {
        baseUrl = @"";
        return;
    }
    if ([baseUrl containsString:@"(null)"]) {
        baseUrl = [baseUrl stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                 @"text/html",
                                                 @"text/json",
                                                 @"text/javascript",
                                                 @"text/plain",
                                                 nil];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    [manager.requestSerializer setValue:@"c56cd1ad9c2d45158028c40fc95dad97" forHTTPHeaderField:@"token"];
    NSString *dev_os = [[UIDevice currentDevice] systemVersion];
    NSString *tinfo_version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *newUserAgent = [NSString stringWithFormat:@"(ttplus/%@/iOS%@)",tinfo_version,dev_os];//自定义需要拼接的字符串
    [manager.requestSerializer setValue:newUserAgent forHTTPHeaderField:@"User-Agent"];

        [manager GET:baseUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                if ([responseObject isKindOfClass:[NSData class]]) {
                    responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                }
                success(responseObject);
                
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
           
        }];
}

+ (void)postWithUrl:(NSString *)url body:(NSData *)body showLoading:(BOOL)show success:(void(^)(NSDictionary *response))success failure:(void(^)(NSError *error))failure
{
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
    request.timeoutInterval= 10;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString *dev_os = [[UIDevice currentDevice] systemVersion];
    NSString *tinfo_version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *newUserAgent = [NSString stringWithFormat:@"(ttplus/%@/iOS%@)",tinfo_version,dev_os];//自定义需要拼接的字符串
    [request setValue:newUserAgent forHTTPHeaderField:@"User-Agent"];
    // 设置body
    [request setHTTPBody:body];
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                 @"text/html",
                                                 @"text/json",
                                                 @"text/javascript",
                                                 @"text/plain",
                                                 nil];
    manager.responseSerializer = responseSerializer;
    
    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            if ([[dict objectForKey:@"type"] isEqual:@"success"]) {
                success(dict);
            }else{
                NSError *error = [NSError errorWithDomain:NSNetServicesErrorDomain code:100 userInfo:@{@"NSErrorUserInfoKey":[dict objectForKey:@"content"]}];
                failure(error);
                
            }
        } else {
            failure(error);
            
        }
    }] resume];
}

@end
