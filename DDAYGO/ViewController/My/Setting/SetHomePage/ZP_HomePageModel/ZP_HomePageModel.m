//
//  ZP_HomePageModel.m
//  DDAYGO
//
//  Created by Summer on 2017/11/14.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_HomePageModel.h"
#import "PrefixHeader.pch"
@implementation ZP_HomePageModel
+ (instancetype)gEtHomePage:(NSDictionary *)Dic {
    return [[self alloc]initWithHomePageData:Dic];
}

- (instancetype)initWithHomePageData:(NSDictionary *)dic {
    if (self == [super init]) {
        self.avatarimg = [NSString stringWithFormat:@"%@%@",ImgAPI,dic[@"avatarimg"]];
        self.nickname = dic[@"nickname"];
        self.realname = dic[@"realname"];
        self.icueaccount = dic[@"icueaccount"];
        self.introducer = dic[@"introducer"];
        self.email = dic[@"email"];
        self.emailverify = dic[@"emailverify"];
    }
    return self;
}

+ (id)cheakNull:(id)dic {
    if ([dic isEqual:[NSNull null]]) {
        return @"";
    }
    return dic;
}

+ (NSMutableArray *)arrayWithArray:(NSArray *)array {
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for (NSDictionary * dic in array) {
        ZP_HomePageModel * model = [[ZP_HomePageModel alloc]init];
        model.avatarimg = [NSString stringWithFormat:@"%@%@",ImgAPI,dic[@"avatarimg"]];
        model.nickname = dic[@"nickname"];
        model.realname = dic[@"realname"];
        model.icueaccount = dic[@"icueaccount"];
        model.introducer = dic[@"introducer"];
        model.email = dic[@"email"];
        model.emailverify = dic[@"emailverify"];
        [arr addObject:model];
    }
    return arr;
}
@end
