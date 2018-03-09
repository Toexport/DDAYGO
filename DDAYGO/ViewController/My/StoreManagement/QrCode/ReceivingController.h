//
//  ReceivingController.h
//  DDAYGO
//
//  Created by Login on 2017/10/10.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PromptBoxView.h"
@interface ReceivingController : PromptBoxView

// 设备尺寸的宽、高
#define ScreenW  CGRectGetWidth([UIScreen mainScreen].bounds)
#define ScreenH CGRectGetHeight([UIScreen mainScreen].bounds)

// NSUserDefaults 数据缓存
#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]

// 用于设置屏幕的亮度
#define SCREEN_BRIGHT @"screenBrights" // 保存得系统亮度
#define ISQRCONTROLLER @"isQRController"// 记录是否是从二维码页面退到前台（即在二维码页面时，按"home"键）

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
