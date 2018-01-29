//
//  ZP_FrontPageReceivingAddressModel.h
//  DDAYGO
//
//  Created by Summer on 2017/11/13.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZP_FrontPageReceivingAddressModel : NSObject
@property (nonatomic, strong) NSNumber * addressid;  // 用户地址id
@property (nonatomic, strong) NSString * addressdetail; // 用户地址
@property (nonatomic, strong) NSString * aid;  // 用户ID
@property (nonatomic, strong) NSString * eeceiptname;  // 收件人名称
@property (nonatomic, strong) NSString * eeceiptphone;  // 号码
@property (nonatomic, strong) NSString * email; //  电子邮件
@property (nonatomic, strong) NSString * zipcode;  //  邮编
@property (nonatomic, strong) NSNumber * isdefault; 

+ (instancetype)GetFrontPageReceivingAddress:(NSDictionary *) dic;

+ (NSMutableArray *)arrayWithArray:(NSArray *)array;
@end

