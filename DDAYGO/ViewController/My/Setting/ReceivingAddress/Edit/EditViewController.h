//
//  EditViewController.h
//  DDAYGO
//
//  Created by Login on 2017/9/29.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZP_FrontPageReceivingAddressModel.h"
#import "PromptBoxView.h"
@interface EditViewController : PromptBoxView
@property (weak, nonatomic) IBOutlet UIScrollView * EditscrollView; // 滚动视图
@property (weak, nonatomic) IBOutlet UITextField * ContactpersonTextField; //联系人
@property (weak, nonatomic) IBOutlet UITextField * ContactnumberTextField; // 联系电话
@property (weak, nonatomic) IBOutlet UILabel * RegionLabel;  // 地區Label
@property (weak, nonatomic) IBOutlet UITextField * ReceivingaddressTextField; //收货地址
@property (weak, nonatomic) IBOutlet UITextField * ZipcodeaddressTextField;  // 邮编
@property (nonatomic, strong) NSString * oid; // 地址id

@property (nonatomic, strong) ZP_FrontPageReceivingAddressModel *model;

@end
