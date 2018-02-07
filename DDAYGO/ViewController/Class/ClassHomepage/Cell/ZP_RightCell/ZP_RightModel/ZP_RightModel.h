//
//  ZP_RightModel.h
//  DDAYGO
//
//  Created by Summer on 2017/10/26.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZP_RightModel : NSObject
@property (nonatomic, strong) NSString * contentLabel;

@property (nonatomic, strong) NSNumber * fatherid;
@property (nonatomic, strong) NSNumber * producttypeid;
+ (NSMutableArray *)arrayWithArray:(NSArray *)dic;
@end
