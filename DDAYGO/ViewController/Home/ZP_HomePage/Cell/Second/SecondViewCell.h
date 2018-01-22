//
//  SecondViewCell.h
//  DDAYGO
//
//  Created by Login on 2017/9/12.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewCell : UITableViewCell
@property (nonatomic, copy) void(^SecondBlock)(NSInteger tag);

- (void)Second:(NSArray *)sup;
@end
