//
//  ZP_HomePageModel.h
//  DDAYGO
//
//  Created by Summer on 2017/11/14.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZP_HomePageModel : NSObject

@property (nonatomic, strong) NSString * avatarimg; // 头像路径
@property (nonatomic, strong) NSString * nickname; // 昵称
@property (nonatomic, strong) NSString * realname; // 真实姓名
@property (nonatomic, strong) NSString * icueaccount; // 绑定的ICUE号
@property (nonatomic, strong) NSString * introducer; // 绑定介绍人
@property (nonatomic, strong) NSString * email; // 账号
@property (nonatomic, strong) NSString * emailverify; // 邮箱
@property (nonatomic, strong) NSNumber * Oid;

+ (instancetype)gEtHomePage:(NSDictionary *)Dic;

+ (NSMutableArray *)arrayWithArray:(NSArray *)array;
@end
