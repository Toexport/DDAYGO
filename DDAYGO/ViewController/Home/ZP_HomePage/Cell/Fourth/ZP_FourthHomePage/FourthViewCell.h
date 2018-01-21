//
//  FourthViewCell.h
//  DDAYGO
//
//  Created by Login on 2017/9/12.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#define zeroHeight 320.0/768.0 * ZP_Width
@interface FourthViewCell : UITableViewCell
typedef void (^FourthBlock)(id response);
@property (nonatomic, copy) void(^FourthBlock)(NSInteger tag);
@property (nonatomic, strong) NSArray * arrDara;
@property (nonatomic, strong) UILabel * Titlelabel; //标题
@property (nonatomic, strong) UIImageView * imageView1; // 图片1
@property (nonatomic ,strong) SDCycleScrollView * scrollView;
@property (nonatomic ,strong) FourthBlock fourthBlock1;
- (void)InformationWithDic:(NSDictionary *)dic;

@end
