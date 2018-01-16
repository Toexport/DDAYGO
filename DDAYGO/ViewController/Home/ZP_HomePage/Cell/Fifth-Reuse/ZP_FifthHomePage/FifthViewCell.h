//
//  FifthViewCell.h
//  DDAYGO
//
//  Created by Login on 2017/9/12.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FifthViewCell : UITableViewCell
@property (nonatomic, copy) void(^ThirdBlock)(NSInteger tag);
@property (nonatomic, strong) NSArray * arrData;
@end
