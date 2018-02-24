//
//  BindingIntroduce.m
//  DDAYGO
//
//  Created by Summer on 2017/11/27.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "BindingIntroduce.h"
#import "PromptBox.h"
#import "ZP_MyTool.h"
#import "PrefixHeader.pch"
@interface BindingIntroduce ()

@end

@implementation BindingIntroduce

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ButStatusAttribute];
    self.title = NSLocalizedString(@"綁定介紹人", nil);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    self.BindingIntroduceTextField.keyboardType = UIKeyboardTypeASCIICapable;
    self.BindingIntroduceTextField.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
    self.BindingIntroducscrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滚动时键盘隐藏
    
}

// 按钮状态属性
- (void)ButStatusAttribute {
    self.BinDingBut.alpha = 0.5;
    self.BinDingBut.userInteractionEnabled = NO;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ButStatus:) name:UITextFieldTextDidChangeNotification object:self.BindingIntroduceTextField];
}
- (void)ButStatus:(UIButton *)sender {
    if (self.BindingIntroduceTextField.text.length > 0) {
        self.BinDingBut.userInteractionEnabled = YES;
        self.BinDingBut.alpha = 1;
    }else {
        self.BinDingBut.userInteractionEnabled = NO;
        self.BinDingBut.alpha = 0.5;
    }
}
// 绑定推荐人
- (IBAction)BindingIntroduceTextField:(id)sender {
#pragma make -- 提示框
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"介紹人一旦绑定后将无法更改，您确定要绑定此介紹人吗？",nil) preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:MyLocal(@"cancel") style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        ZPLog(@"取消");
    }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:MyLocal(@"ok") style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [SVProgressHUD showWithStatus:@"请稍后..."];
        [self allData];
    }];
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)allData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"acc"] = self.BindingIntroduceTextField.text;
    dic[@"token"] = Token;
    [ZP_MyTool requesIntroduce:dic success:^(id obj) {
        NSDictionary * dic = obj;
        if ([dic[@"result"]isEqualToString:@"ok"]) {
            [SVProgressHUD showSuccessWithStatus:@"綁定成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else
            if ([dic[@"result"]isEqualToString:@"failure"]) {
                [SVProgressHUD showInfoWithStatus:@"綁定失敗"];
            }else
                if ([dic[@"result"]isEqualToString:@"no"]) {
                    [SVProgressHUD showInfoWithStatus:@"賬戶不存在"];
                }else
                    if ([dic[@"result"]isEqualToString:@"abnormal_message"]) {
                        [SVProgressHUD showInfoWithStatus:@"異常訊息"];
                    }else
                        //*************************************Token被挤掉***************************************************//
                        if ([obj[@"result"]isEqualToString:@"token_not_exist"]) {
                            Token = nil;
                            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
                            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"symbol"];
                            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"countrycode"];
                            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"headerImage"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"NameLabel"];
                            ZPICUEToken = nil;
                            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"icuetoken"];
                            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"state"];
                            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"headerImage"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"NameLabel"];
                            [[SDImageCache sharedImageCache] clearDisk];
                            [[NSUserDefaults standardUserDefaults]synchronize];
#pragma make -- 提示框
                            UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Prompt", nil) message:NSLocalizedString(@"Your account has been logged in other places, you have been forced to go offline, please change the password as soon as possible if you are not logged in.",nil) preferredStyle:UIAlertControllerStyleAlert];
                            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                ZPLog(@"取消");
                            }];
                            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Determine",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                [self.navigationController popToRootViewControllerAnimated:NO];
                                //跳转
                                if ([[[UIApplication sharedApplication] keyWindow].rootViewController isKindOfClass:[UITabBarController class]]) {
                                    UITabBarController * tbvc = [[UIApplication sharedApplication] keyWindow].rootViewController;
                                    [tbvc setSelectedIndex:0];
                                }
                            }];
                            [alert addAction:defaultAction];
                            [alert addAction:cancelAction];
                            [self presentViewController:alert animated:YES completion:nil];
                        }
        //****************************************************************************************//
    } failure:^(NSError * error) {
        
    }];
}

@end
