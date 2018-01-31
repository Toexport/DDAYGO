//
//  ZP_BusinessNameCell.h
//  DDAYGO
//
//  Created by Summer on 2018/1/31.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZP_InformationModel.h"
@interface ZP_BusinessNameCell : UITableViewCell
@property (nonatomic, strong) UILabel * merchantsLabel;
//@property (nonatomic, strong) ZP_InformationModel * model;
- (void)InformationModel:(ZP_InformationModel *)model;
@end
