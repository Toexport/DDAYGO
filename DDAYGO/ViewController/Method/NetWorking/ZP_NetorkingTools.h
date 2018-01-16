//
//  ZP_NetorkingTools.h
//  DDAYGO
//
//  Created by Summer on 2017/10/25.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZP_NetorkingTools : NSObject
// GET
+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(id ))success failure:(void (^)(NSError *))failure;

//  POST
+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

//  POST文件上传
+ (void)POST:(NSString *)URLString parameters:(id)parameters ContentArray:(NSArray *)dataArray success:(void (^)(id ))success failure:(void (^)(NSError *))failure;

@end
