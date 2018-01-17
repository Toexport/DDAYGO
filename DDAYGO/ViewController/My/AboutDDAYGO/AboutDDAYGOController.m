//
//  AboutDDAYGOController.m
//  DDAYGO
//
//  Created by Summer on 2018/1/17.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import "AboutDDAYGOController.h"
#import "PrefixHeader.pch"
@interface AboutDDAYGOController ()

@end

@implementation AboutDDAYGOController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

// UI
- (void)initUI {
    self.title = NSLocalizedString(@"Setting", nil) ;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_WhiteColor}];   // 更改导航栏字体颜色
}

@end
