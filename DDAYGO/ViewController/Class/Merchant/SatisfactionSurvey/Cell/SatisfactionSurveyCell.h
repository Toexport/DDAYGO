//
//  SatisfactionSurveyCell.h
//  DDAYGO
//
//  Created by Summer on 2018/1/19.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SatisfactionSurveyModel.h"
@interface SatisfactionSurveyCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView * TouxiangImage; // 头像
@property (weak, nonatomic) IBOutlet UILabel * NameLabel;  // 名字
@property (weak, nonatomic) IBOutlet UILabel * TimeLabel; // 时间
@property (weak, nonatomic) IBOutlet UIButton * Button1;  // 按钮1
@property (weak, nonatomic) IBOutlet UIButton * Button2; // 按钮2
@property (weak, nonatomic) IBOutlet UIButton * Button3; // 按钮3
@property (weak, nonatomic) IBOutlet UIButton * Button4; // 按钮4
@property (weak, nonatomic) IBOutlet UIButton * Button5; // 按钮5
@property (weak, nonatomic) IBOutlet UILabel * FenshuLabel; // 分数
@property (weak, nonatomic) IBOutlet UILabel * PinglunneirongLabel; // 评论内容
@property (strong ,nonatomic) NSArray * commodityArray;
- (void)SatisfactionSurvey:(SatisfactionSurveyModel *) model;

@end
