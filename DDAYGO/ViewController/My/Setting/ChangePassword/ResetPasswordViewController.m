//
//  ResetPasswordViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/22.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "PrefixHeader.pch"
#import "ZP_MyTool.h"
#import "MyViewController.h"
#import "HomeViewController.h"
@interface ResetPasswordViewController ()

@end

@implementation ResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

// UI
- (void)initUI {
    self.title = NSLocalizedString(@"修改密碼", nil);
    [self ButStatusAttribute];
    self.oldpwTextfield.secureTextEntry = YES;
    self.newpwTextfield.secureTextEntry = YES;
    self.againpwTextfield.secureTextEntry = YES;
    self.oldpwTextfield.keyboardType = UIKeyboardTypeDefault;
    self.newpwTextfield.keyboardType = UIKeyboardTypeDefault;
    self.againpwTextfield.keyboardType = UIKeyboardTypeDefault;
    self.oldpwTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
    self.newpwTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
    self.againpwTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    self.ResetPasswordscrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滚动时键盘隐藏
}

// 按钮状态属性
- (void)ButStatusAttribute {
    self.DetermineBut.alpha = 0.5;
    self.DetermineBut.userInteractionEnabled = NO;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ButStatus:) name:UITextFieldTextDidChangeNotification object:self.againpwTextfield];
}
- (void)ButStatus:(UIButton *)sender {
    if (self.againpwTextfield.text.length > 0) {
        self.DetermineBut.userInteractionEnabled = YES;
        self.DetermineBut.alpha = 1;
    }else {
        self.DetermineBut.userInteractionEnabled = NO;
        self.DetermineBut.alpha = 0.5;
    }
}

// 确定按钮
- (IBAction)DetermineBut:(id)sender {
    
    if (self.newpwTextfield.text.length < 6 || self.newpwTextfield.text.length > 20) {
        [SVProgressHUD showInfoWithStatus:@"密碼位數不能小於6大於20"];
        ZPLog(@"密码不足6位");
        return;
    }
//    if (![self judgePassWordLegal:self.newpwTextfield.text]) {
//        [SVProgressHUD showInfoWithStatus:@"密碼必須8-20大小寫數字組合"];
//        ZPLog(@"密码不足8位");
//        return;
//    }
    if (self.newpwTextfield.text != self.againpwTextfield.text) {
        [SVProgressHUD showInfoWithStatus:@"兩次密碼不一致"];
    }else {
    [SVProgressHUD showWithStatus:@"正在登录。。。"];
    [self allData];
    }
}

// 数据
- (void)allData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    dic[@"opwd"] = [self md5:self.oldpwTextfield.text];
    dic[@"npwd"] = [self md5:self.newpwTextfield.text];
    dic[@"npwd"] = [self md5:self.againpwTextfield.text];
    [ZP_MyTool requestRestPassword:dic success:^(id obj) {
        if ([obj[@"result"]isEqualToString:@"ok"]) {
            [SVProgressHUD showSuccessWithStatus:@"修改成功,请重新登录..."];
            Token = nil;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"symbol"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"countrycode"];
            ZPICUEToken = nil;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"icuetoken"];
            UITabBarController * tbvc  = [[UIApplication sharedApplication] keyWindow].rootViewController;
            [tbvc setSelectedIndex:0];
//            for (UIViewController *controller in self.navigationController.viewControllers) {
//                if ([controller isKindOfClass:[HomeViewController class]]) {
//                    [self.navigationController popToViewController:controller animated:YES];
//
//                }
//            }
            
        }else
            if ([obj[@"result"]isEqualToString:@"token_err"]) {
                [SVProgressHUD showInfoWithStatus:@"令牌無效"];
        }else
            if ([obj[@"result"]isEqualToString:@"opwd_null_err"]) {
                [SVProgressHUD showInfoWithStatus:@"原密碼不能為空"];
        }else
            if ([obj[@"result"]isEqualToString:@"npwd_null_err"]) {
                [SVProgressHUD showInfoWithStatus:@"新密碼不能為空"];
        }else
            if ([obj[@"result"]isEqualToString:@"opwd_err"]) {
                [SVProgressHUD showInfoWithStatus:@"原密碼錯誤"];
        }
        
        ZPLog(@"obj %@",obj);
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
}

//显示密码
- (IBAction)showpwAction:(UIButton *)sender {
    self.oldpwTextfield.secureTextEntry = sender.selected;
    self.newpwTextfield.secureTextEntry = sender.selected;
    self.againpwTextfield.secureTextEntry = sender.selected;
    sender.selected = !sender.selected;
}

//  MD5加密方法
-(NSString *)md5:(NSString *)input {
    const char * cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr),digest); // This is the md5 call
    NSMutableString * output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH *2];
    for (int i = 0; i<CC_MD5_DIGEST_LENGTH; i ++) {
        [output appendFormat:@"%02x",digest[i]];
    }
    return output;
}

#pragma mark - - - - - - - - - - - - - - - private methods 私有方法 - - - - - - - - - - - - - -
- (BOOL)validateEmail:(NSString *)email {
//  邮箱正则式
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
    
}

- (BOOL)JudgeTheillegalCharacter:(NSString *)content {
//  提示标签不能输入特殊字符
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    return [emailTest evaluateWithObject:content];
}

- (BOOL)judgePassWordLegal:(NSString *)pass {
    BOOL result ;
//  判断长度大于8位后再接着判断是否同时包含数字和大小写字母
    NSString * regex =@"(?![0-9A-Z]+$)(?![0-9a-z]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    result = [pred evaluateWithObject:pass];
    return result;
}

@end
