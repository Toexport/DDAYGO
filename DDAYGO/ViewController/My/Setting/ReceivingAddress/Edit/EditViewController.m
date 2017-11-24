//
//  EditViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/29.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "EditViewController.h"
#import "PrefixHeader.pch"
@interface EditViewController ()

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self touchesBegan];
    self.title = @"编辑地址";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"保存", nil)  style:UIBarButtonItemStylePlain target:self action:@selector(EditAddress)];
    self.navigationItem.rightBarButtonItem = item;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
}
// 保存点击事件
- (void)EditAddress {
    
    NSLog(@"保存");
    [self allData];
}
- (void)allData {
    ZPLog(@"数据");
}
// 键盘触摸
- (void)touchesBegan {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];

}
// 触发事件
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
        [_ContactpersonTextField resignFirstResponder];
        [_ContactnumberTextField resignFirstResponder];
        [_ReceivingareaTextField resignFirstResponder];
        [_ReceivingaddressTextField resignFirstResponder];
        [_ZipcodeaddressTextField resignFirstResponder];
}

@end
