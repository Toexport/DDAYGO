//
//  LoginController.m
//  DDAYGO
//
//  Created by Login on 2017/10/17.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "LoginController.h"
#import "TextView.h"
#import "ForgetPswController.h"
#import "PrefixHeader.pch"
#import "UINavigationBar+Awesome.h"
#import "ZP_LoginTool.h"
@interface LoginController () {
    BOOL keyboardIsShown;
}

@property (weak, nonatomic) IBOutlet TextView * ZPEmailTextField;
@property (weak, nonatomic) IBOutlet TextView * ZPPswTextField;
@property (weak, nonatomic) IBOutlet UIButton * LoginBtn;
@property (nonatomic, strong) UIView * Boview;


@end

@implementation LoginController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.title = NSLocalizedString(@"Login", nil) ;

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
//    self.LoginscrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滚动时键盘隐藏
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
    
}
- (void)initUI {
    _LoginBtn.layer.cornerRadius             = 8.0;
    _LoginBtn.layer.masksToBounds            = YES;
    
    _ZPEmailTextField.textField.keyboardType =  UIKeyboardTypeASCIICapable;
    _ZPPswTextField.textField.keyboardType = UIKeyboardTypeDefault;
    _ZPPswTextField.showBtn                  = NO;
    _ZPPswTextField.showEyeBtn               = YES;
    [_ZPPswTextField.functionBtn addTarget:self action:@selector(secureTextEntry) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)LoginClick:(id)sender {
    if (![self validateEmail:_ZPEmailTextField.textField.text]) {
        [SVProgressHUD showInfoWithStatus:@"賬號格式不正確"];
        }
    [self allData];
}
// 数据
- (void)allData {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"email"] = [self.ZPEmailTextField.textField.text stringByReplacingOccurrencesOfString:@" " withString:@""]; // 防止輸入帶有空格
    dic[@"pwd"] = [self md5:_ZPPswTextField.textField.text];
    dic[@"countrycode"] = CountCode;
//    NSLog(@"count %@",CountCode);
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"loginData"];
    [ZP_LoginTool requestLogin:dic success:^(id obj) {
        NSLog(@"obj---%@",obj);
    if ([obj[@"result"]isEqualToString:@"ok"]) {
        NSDictionary * aadic = obj;
        Token = aadic[@"token"];
        [[NSUserDefaults standardUserDefaults] setObject:Token forKey:@"token"];// Token缓存本地
        [[NSUserDefaults standardUserDefaults] synchronize]; // Token缓存本地
        [[NSUserDefaults standardUserDefaults] setObject:aadic[@"symbol"] forKey:@"symbol"]; // 台币缓存本地
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] setObject:aadic[@"result"] forKey:@"result"]; // 是否是供货商
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] setObject:aadic[@"countrycode"] forKey:@"countrycode"];  // 国别缓存本地
        [[NSUserDefaults standardUserDefaults] synchronize];  // 国别缓存本地
        [SVProgressHUD showSuccessWithStatus:@"登錄成功!"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else {
        if ([obj[@"result"]isEqualToString:@"failure"]) {
            [SVProgressHUD showInfoWithStatus:@"登錄失敗"];
        }else {
            if ([obj[@"result"]isEqualToString:@"acc_pwd_err"]) {
                [SVProgressHUD showInfoWithStatus:@"賬號或密碼錯誤"];
        }else {
            if ([obj[@"result"]isEqualToString:@"acc_null_err"]) {
                [SVProgressHUD showInfoWithStatus:@"賬號為空"];
        }else {
            if ([obj[@"result"]isEqualToString:@"pwd_null_err"]) {
                [SVProgressHUD showInfoWithStatus:@"密碼為空"];
        }else {
            if ([obj[@"result"]isEqualToString:@"sys_err"]) {
                [SVProgressHUD showInfoWithStatus:@"系統錯誤"];
        }else {
            if ([obj[@"result"]isEqualToString:@"token_err"]) {
                [SVProgressHUD showInfoWithStatus:@"token 已存在"];
                                }
                            }
                        }
                    }
                }
            }
        }
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
}

- (IBAction)forgetPsdClick:(id)sender {
    
    self.hidesBottomBarWhenPushed = YES;
    ForgetPswController *forget = [[ForgetPswController alloc]init];
    [self.navigationController pushViewController:forget animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}

#pragma mark - - - - - - - - - - - - - - - private methods 私有方法 - - - - - - - - - - - - - -
- (BOOL)validateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}
- (BOOL)judgePassWordLegal:(NSString *)pass {
    
    BOOL result ;
    // 判断长度大于8位后再接着判断是否同时包含数字和大小写字母
    NSString * regex =@"(?![0-9A-Z]+$)(?![0-9a-z]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    result = [pred evaluateWithObject:pass];
    
    return result;
    
}

//  MD5加密方法
-(NSString *)md5:(NSString *)input {
    const char * cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
//    CC_MD5(cStr, strlen(cStr),digest); // This is the md5 call
    CC_MD5(cStr, (CC_LONG)strlen(cStr),digest); // This is the md5 call
    NSMutableString * output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH *2];
    for (int i = 0; i<CC_MD5_DIGEST_LENGTH; i ++) {
        [output appendFormat:@"%02x",digest[i]];
    }
    return output;
}

#pragma mark - 安全输入
-(void)secureTextEntry {
    _ZPPswTextField.textField.secureTextEntry = !_ZPPswTextField.textField.secureTextEntry;
    
    if (_ZPPswTextField.textField.secureTextEntry) {
        [_ZPPswTextField.functionBtn setImage:[UIImage imageNamed:@"ic_login_close.png"] forState:UIControlStateNormal];
    }else {
        [_ZPPswTextField.functionBtn setImage:[UIImage imageNamed:@"ic_login_open.png"] forState:UIControlStateNormal];
    }
}


@end

