//
//  FirstViewCell.h
//  DDAYGO
//
//  Created by Login on 2017/9/12.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewCell : UITableViewCell


@property (nonatomic, strong) NSArray * Allarr;
@property (nonatomic, copy) void(^firstBlock)(NSInteger tag,NSString * name);
@property (nonatomic, strong) NSNumber * sendCode;
@property (nonatomic, strong) NSNumber * code;
- (void)first:(NSArray *)sup;

@end
