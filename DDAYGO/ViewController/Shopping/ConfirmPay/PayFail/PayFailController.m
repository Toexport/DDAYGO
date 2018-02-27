//
//  PayFailController.m
//  DDAYGO
//
//  Created by Login on 2017/10/20.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "PayFailController.h"
#import "PrefixHeader.pch"
@interface PayFailController ()

@end

@implementation PayFailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =MyLocal(@"Pay failure");
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
    
}

@end
