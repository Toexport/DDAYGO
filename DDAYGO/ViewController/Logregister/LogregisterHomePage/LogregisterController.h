//
//  LogregisterController.h
//  DDAYGO
//
//  Created by Login on 2017/10/17.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PromptBoxView.h"
@interface LogregisterController : PromptBoxView
@property (weak, nonatomic) IBOutlet UIScrollView * LogregisterscrollView;
@property (nonatomic, assign) NSInteger type; //识别号

@end
