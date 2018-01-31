//
//  EditorViewCell.h
//  DDAYGO
//
//  Created by Login on 2017/9/19.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZP_ShoppingModel.h"
@interface EditorViewCell : UITableViewCell
@property (nonatomic, strong) UIButton * button;  // 选择按钮
@property (nonatomic, strong) UIImageView * Mainfigure;  // 主图
@property (nonatomic, strong) UILabel * titleLabel;   // 标题
@property (nonatomic, strong) UILabel * MerchandiseIntroducedLabel; //  文字介绍
@property (nonatomic, strong) UILabel * descLabel;    //    颜色
@property (nonatomic, strong) UILabel * SizeLanbel;  // 尺码
@property (nonatomic, strong) UIButton * Reducebutton;   // 减少按钮
@property (nonatomic, strong) UILabel * numLabel;  // 数量
@property (nonatomic, strong) UIButton * addButton;  // 增加
@property (nonatomic, copy) void (^btnClickBlock) (NSString * str);
@property (nonatomic, strong) ZP_CartsModel * productamountmodel; // 库存
- (void)cellWithModel:(ZP_CartsModel *)model;
@end

