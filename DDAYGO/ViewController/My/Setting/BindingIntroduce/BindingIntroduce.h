//
//  BindingIntroduce.h
//  DDAYGO
//
//  Created by Summer on 2017/11/27.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PromptBoxView.h"
@interface BindingIntroduce : PromptBoxView
@property (strong, nonatomic) IBOutlet UIScrollView * BindingIntroducscrollView;
@property (strong, nonatomic) IBOutlet UITextField * BindingIntroduceTextField;
@property (weak, nonatomic) IBOutlet UIButton * BinDingBut;

@end
