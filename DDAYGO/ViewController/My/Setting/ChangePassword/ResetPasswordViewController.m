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
#import "HomePageViewController.h"
@interface ResetPasswordViewController ()

@end

@implementation ResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(adjustStatusBar:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

// UI
- (void)initUI {
    self.title = MyLocal(@"Change password");
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
        [SVProgressHUD showInfoWithStatus:MyLocal(@"password number cannot be less than 6 greater than 20.")];
        ZPLog(@"密码不足6位");
        return;
    }
    //    if (![self judgePassWordLegal:self.newpwTextfield.text]) {
    //        [SVProgressHUD showInfoWithStatus:@"密碼必須8-20大小寫數字組合"];
    //        ZPLog(@"密码不足8位");
    //        return;
    //    }
    if (self.newpwTextfield.text != self.againpwTextfield.text) {
        [SVProgressHUD showInfoWithStatus:MyLocal(@"two passwords do not match.")];
    }else {
        [SVProgressHUD showWithStatus: MyLocal(@"Please later…")];
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
            [SVProgressHUD showSuccessWithStatus:MyLocal(@"Modified successfully, please login again...")];
            [self.navigationController popToRootViewControllerAnimated:NO];
            //        清除所有的数据
            Token = nil;
            DDAYGO_REMOVE_TOKEN; DDAYGO_REMOVE_SYMBOL; DDAYGO_REMOVE_COUNTRYCODE; DDAYGO_REMOVE_ICUETOKEN; DD_ChangeStaus;
            ZPICUEToken = nil;
            [[SDImageCache sharedImageCache] clearDisk];
            [self.navigationController popViewControllerAnimated:YES];
            UITabBarController * tbvc  = [[UIApplication sharedApplication] keyWindow].rootViewController;
            [tbvc setSelectedIndex:0];
        }else
            if ([obj[@"result"]isEqualToString:@"token_err"]) {
                [SVProgressHUD showInfoWithStatus:MyLocal(@"token is invalid")];
            }else
                if ([obj[@"result"]isEqualToString:@"opwd_null_err"]) {
                    [SVProgressHUD showInfoWithStatus:MyLocal(@"original password cannot be null.")];
                }else
                    if ([obj[@"result"]isEqualToString:@"npwd_null_err"]) {
                        [SVProgressHUD showInfoWithStatus:MyLocal(@"new password cannot be empty.")];
                    }else
                        if ([obj[@"result"]isEqualToString:@"opwd_err"]) {
                            [SVProgressHUD showInfoWithStatus:MyLocal(@"Original password error")];
                        }else
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

// 热点被接入，子类重写
- (void)adjustStatusBar:(NSNotification *)notification {
    NSValue * rectValue = [notification.userInfo objectForKey:UIApplicationStatusBarFrameUserInfoKey];
    CGRect statusRect = [rectValue CGRectValue];
    CGFloat height = statusRect.size.height;
    if (height > 20) {
        appD.window.frame = CGRectMake(0, 0, ZP_Width, ZP_height);
    }else{
        appD.window.frame = CGRectMake(0, 0, ZP_Width, ZP_height);
    }
}
@end
