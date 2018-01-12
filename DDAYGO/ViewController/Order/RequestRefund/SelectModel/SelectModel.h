//
//  SelectModel.h
//  DDAYGO
//
//  Created by Summer on 2018/1/12.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectModel : NSObject
@property (nonatomic, strong) NSNumber * reasonid; // ID
@property (nonatomic, strong) NSString * reasonstr; // 状态
+ (NSMutableArray *)arrayWithArray:(NSArray *)array;
@end
