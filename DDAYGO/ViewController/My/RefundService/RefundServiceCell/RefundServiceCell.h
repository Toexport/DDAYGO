//
//  RefundServiceCell.h
//  DDAYGO
//
//  Created by Summer on 2018/1/10.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefundServiceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *shopnameLabel; // 商家
@property (weak, nonatomic) IBOutlet UILabel *StateLabel; // 状态
@property (weak, nonatomic) IBOutlet UILabel *WaitStateLabel; // 等待状态
@property (weak, nonatomic) IBOutlet UILabel *ItemLabel; // 时间
/**********view*********/
@property (weak, nonatomic) IBOutlet UIImageView *MaimImageView;
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;

@end
