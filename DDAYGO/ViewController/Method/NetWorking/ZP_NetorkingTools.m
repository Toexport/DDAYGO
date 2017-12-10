//
//  ZP_NetorkingTools.m
//  DDAYGO
//
//  Created by Summer on 2017/10/25.
//  Copyright © 2017年 Summer. All rights reserved.
//
#import <AFNetworking.h>
#import "ZP_NetorkingTools.h"
#import "UserDefultManage.h"
#import "PrefixHeader.pch"
@implementation ZP_NetorkingTools
static AFHTTPSessionManager *_manager = nil;

//get请求
+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    _manager = [AFHTTPSessionManager manager];
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript", @"text/html",@"image/jpeg", nil];
    NSString * tipCode = [UserDefultManage objectForKey:@"token"];
    
    if (tipCode.length >10) {
        
        [_manager.requestSerializer setValue:tipCode forHTTPHeaderField:@"token"];
    }

    [_manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        if (success) {
            
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {

            failure(error);
        }
    }];
}

//  POST请求
+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id ))success failure:(void (^)(NSError *))failure {
    
    if (!_manager) {
        
        _manager = [AFHTTPSessionManager manager];
    }
    NSString * tipCode = [UserDefultManage objectForKey:@"token"];
    if (tipCode.length > 10) {
        [_manager.requestSerializer setValue:tipCode forHTTPHeaderField:@"token"];
    }
    _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript", @"text/html",@"image/jpeg", nil];

    [_manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            
            failure(error);
        }
    }];
 }

@end
