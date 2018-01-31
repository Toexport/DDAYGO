//
//  AppraiseViewCell.h
//  DDAYGO
//
//  Created by Login on 2017/9/22.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppraiseViewCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView * FigureImage;       //  主图
@property (nonatomic, strong) UILabel * EvaluationLabel;      // 商品评分
@property (nonatomic, strong) UITextField * Evaluationtext;  // 产品评价
@property (nonatomic, strong) UIButton * scoreBut;          //按钮

@property (nonatomic, strong) NSMutableArray * scoreButArray;

@property (nonatomic, copy) void(^scoreBlock)(NSInteger tag);

- (void)score:(NSArray *)score;

- (void)Appraise:(NSDictionary *)dic;


@property (nonatomic, copy) void (^ savaData)(NSString *title);


@end
