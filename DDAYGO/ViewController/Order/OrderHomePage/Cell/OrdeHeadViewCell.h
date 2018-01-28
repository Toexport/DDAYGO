//
//  OrdeHeadViewCell.h
//  DDAYGO
//
//  Created by Summer on 2018/1/28.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrdeHeadViewCell : UITableViewCell
@property (nonatomic ,strong) UILabel * OrderLabel;            //  订单Name
@property (nonatomic, strong) UILabel * IDLabel;              //  ID号
@property (nonatomic, strong) UILabel * DateLabel;           //  日期
@property (nonatomic, strong) UILabel * TradingLabel;      //  交易状态
@property (nonatomic, strong) UIButton * DeleteBut;       // 删除按钮
@end
