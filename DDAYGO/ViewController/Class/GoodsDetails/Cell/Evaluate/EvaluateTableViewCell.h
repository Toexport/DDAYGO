//
//  EvaluateTableViewCell.h
//  DDAYGO
//
//  Created by 赵宁 on 2017/12/11.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EvaluateModel.h"
@interface EvaluateTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton * commodityBtn1;
@property (weak, nonatomic) IBOutlet UIButton * commodityBtn2;
@property (weak, nonatomic) IBOutlet UIButton * commodityBtn3;
@property (weak, nonatomic) IBOutlet UIButton * commodityBtn4;
@property (weak, nonatomic) IBOutlet UIButton * commodityBtn5;

//@property (weak, nonatomic) IBOutlet UIButton * logisticsBtn1;
//@property (weak, nonatomic) IBOutlet UIButton * logisticsBtn2;
//@property (weak, nonatomic) IBOutlet UIButton * logisticsBtn3;
//@property (weak, nonatomic) IBOutlet UIButton * logisticsBtn4;
//@property (weak, nonatomic) IBOutlet UIButton * logisticsBtn5;

@property (weak, nonatomic) IBOutlet UIImageView *AvatarImageView; // 头像
@property (weak, nonatomic) IBOutlet UILabel * usernameLabel; // 用户名
@property (weak, nonatomic) IBOutlet UILabel * timeLabel;  // 评价时间
@property (weak, nonatomic) IBOutlet UILabel * commodityLabel; // 评价内容
//@property (weak, nonatomic) IBOutlet UILabel * logisticsLabel;

@property (strong ,nonatomic) NSArray * commodityArray;
@property (strong ,nonatomic) NSArray * logisticsArray;

//- (void)updateData:(NSDictionary *)dic;
- (void)Evaluatemodel:(EvaluateModel *)model;

@end
