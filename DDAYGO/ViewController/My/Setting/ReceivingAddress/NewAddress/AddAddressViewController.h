//
//  AddAddressViewController.h
//  DDAYGO
//
//  Created by Login on 2017/9/22.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PromptBoxView.h"
@interface AddAddressViewController : PromptBoxView
@property (strong ,nonatomic)NSDictionary * contentDic;
@property (strong, nonatomic) IBOutlet UIScrollView * AddAddressScrollView;
@property (weak, nonatomic) IBOutlet UITextField * ContactpersonTextField; //联系人
@property (weak, nonatomic) IBOutlet UITextField * ContactnumberTextField; // 联系电话
//@property (weak, nonatomic) IBOutlet UITextField * ReceivingareaTextField; // 收货地区
@property (weak, nonatomic) IBOutlet UILabel * regionLabel; // 地區Label
@property (weak, nonatomic) IBOutlet UITextField * ReceivingaddressTextField; //收货地址
@property (weak, nonatomic) IBOutlet UITextField * ZipcodeaddressTextField;  // 邮编
@property (nonatomic, strong) NSNumber * oid;

@end
