//
//  YueTixianController.h
//  DDAYGO
//
//  Created by Summer on 2017/12/4.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextView.h"
@interface YueTixianController : UIViewController
@property (strong, nonatomic) IBOutlet UIScrollView * TikuanscrollView;

@property (strong, nonatomic) IBOutlet TextView * amountText;
@property (strong, nonatomic) IBOutlet TextView * payeeText;
@property (strong, nonatomic) IBOutlet TextView * CollectingBankText;
@property (strong, nonatomic) IBOutlet TextView * PaymentAccountText;
@property (strong, nonatomic) IBOutlet TextView * reservedPhoneText;
@property (strong, nonatomic) IBOutlet TextView * emailText;

@end
