//
//  ZP_LeftModel.h
//  DDAYGO
//
//  Created by Summer on 2017/10/26.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZP_LeftModel : NSObject
@property (nonatomic, strong) NSString * contentLabel; // 文字
@property (nonatomic, strong) NSNumber  * producttypeid ;
+ (instancetype)GetLeftData:(NSDictionary *)Dic;

+(NSMutableArray *)arrayWithArray:(NSArray *)array;
@end
