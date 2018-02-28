//
//  ForgetPswController.m
//  DDAYGO
//
//  Created by Login on 2017/10/18.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ForgetPswController.h"
#import "TextView.h"
#import "PrefixHeader.pch"
#import "UINavigationBar+Awesome.h"
#import "ZP_LoginTool.h"
@interface ForgetPswController ()
@property (weak, nonatomic) IBOutlet TextView * ZPEmailTextField;
@property (weak, nonatomic) IBOutlet TextView * ZPCodeTextField;
@property (weak, nonatomic) IBOutlet TextView * ZPPswTextField;
@property (weak, nonatomic) IBOutlet TextView * ZPConPswTextField;
@property (weak, nonatomic) IBOutlet UIButton * DetermineBut;
@property (nonatomic, strong) NSString * codeStr;
@property (nonatomic, strong) NSString * verifyemail;

@end

@implementation ForgetPswController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self secureTextEntry];
    _ForgetPswscrollView.bounces = NO;
    [self initUI];
}
// UI
- (void)initUI {
    self.title = NSLocalizedString(@"Forgot password", nil);
    [self ButStatusAttribute];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    self.ForgetPswscrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滚动时键盘隐藏
    self.ZPEmailTextField.textField.keyboardType =  UIKeyboardTypeASCIICapable;
    self.ZPCodeTextField.textField.keyboardType =  UIKeyboardTypeNumberPad;
    self.ZPPswTextField.textField.keyboardType = UIKeyboardTypeDefault;
    self.ZPConPswTextField.textField.keyboardType = UIKeyboardTypeDefault;
    self.ZPEmailTextField.textField.placeholder = MyLocal(@"ZPEmailTextFieldID");
    self.ZPCodeTextField.textField.placeholder = MyLocal(@"ZPCodeTextField");
    self.ZPPswTextField.textField.placeholder = MyLocal(@"ZPPswTextField");
    self.ZPConPswTextField.textField.placeholder = MyLocal(@"ZPPswTextField");
    [self.ZPCodeTextField.functionBtn addTarget:self action:@selector(getMSNCode) forControlEvents:UIControlEventTouchUpInside];
    //    _ZPPswTextField.showBtn                  = NO;
    //    _ZPPswTextField.showEyeBtn               = YES;
    //    [_ZPPswTextField.functionBtn addTarget:self action:@selector(secureTextEntry) forControlEvents:UIControlEventTouchUpInside];
    //    self.ZPConPswTextField.showBtn                  = NO;
    //    self.ZPConPswTextField.showEyeBtn               = YES;
    //    [self.ZPConPswTextField.functionBtn addTarget:self action:@selector(secureTextEntry) forControlEvents:UIControlEventTouchUpInside];
    self.ZPCodeTextField.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
}
// 按钮状态属性
- (void)ButStatusAttribute {
    self.DetermineBut.alpha = 0.5;
    self.DetermineBut.userInteractionEnabled = NO;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ButStatus:) name:UITextFieldTextDidChangeNotification object:self.ZPConPswTextField.textField];
}

- (void)ButStatus:(UIButton *)sender {
    if (self.ZPConPswTextField.textField.text.length > 0) {
        self.DetermineBut.userInteractionEnabled = YES;
        self.DetermineBut.alpha = 1;
    }else {
        self.DetermineBut.userInteractionEnabled = NO;
        self.DetermineBut.alpha = 0.5;
    }
}
// 数据（第一步）
// 获取验证码
- (void)getMSNCode {
    NSLog(@"获取验证码");
    if (_ZPEmailTextField.textField.text == nil) {
        [SVProgressHUD showInfoWithStatus:MyLocal(@"account cannot be empty.")];
    }
    [self.ZPCodeTextField.functionBtn startWithTime:60 title:NSLocalizedString(@"obtain", nil) titleColor:[UIColor whiteColor]countDownTitle:@"s" countDownTitleColor:[UIColor whiteColor] mainColor:ZP_PayColor countColor:ZP_PayColor];
    [self qurestCode];  // 开始获取验证码
}

//  发生网络请求 --> 获取验证码
- (void)qurestCode {
    ZPLog(@"发生网络请求 --> 获取验证码");
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"acc"] = [self.ZPEmailTextField.textField.text stringByReplacingOccurrencesOfString:@" " withString:@""]; // 防止輸入帶有空格
    [ZP_LoginTool requestForgetPsw1:dic success:^(id obj) {
        NSDictionary * dic = obj;
        _verifyemail = dic[@"verifyemail"];
        ZPLog(@"%@",dic);
        
        if ([dic[@"result"] isEqualToString:@"ok"]) {
            [SVProgressHUD showSuccessWithStatus:MyLocal(@"Send success")];
            ZPLog(@"发送成功");
            _codeStr = dic[@"code"];
        }else
            if ([dic[@"result"] isEqualToString:@"acc_null_err"]) {
                [SVProgressHUD showInfoWithStatus:MyLocal(@"account cannot be empty.")];
                
            }else
                if ([dic[@"result"] isEqualToString:@"acc_email_err"]) {
                    [SVProgressHUD showInfoWithStatus:MyLocal(@"Account does not exist")];
                    [_ZPCodeTextField.functionBtn cancelCountDownWith:MyLocal(@"obtain")];//这句代码是倒计时清0
                }else
                    if ([dic[@"result"] isEqualToString:@"send_error"]) {
                        [SVProgressHUD showInfoWithStatus:MyLocal(@"Verification code sent failed, please try again later")];
                        [_ZPCodeTextField.functionBtn cancelCountDownWith:MyLocal(@"obtain")];
                    }
        
    } failure:^(NSError * error) {
        ZPLog(@"%@", error);
    }];
}

// 完成按钮
- (IBAction)DetermineBut:(id)sender {
    
    if (self.ZPPswTextField.textField.text.length < 6 || self.ZPPswTextField.textField.text.length >20) {
        [SVProgressHUD showInfoWithStatus:MyLocal(@"password number should not be less than 6 digits greater than 20 digits.")];
        ZPLog(@"密码不足6位");
        return;
    }
    if (_ZPCodeTextField.textField.text.length < 1) {
        [SVProgressHUD showInfoWithStatus:MyLocal(@"Verify that the code cannot be empty.")];
        ZPLog(@"请输入验证码");
        return;
    }
    
    if (![_ZPCodeTextField.textField.text isEqualToString:_codeStr]) {
        
        [SVProgressHUD showErrorWithStatus:MyLocal(@"Verification code error")];
        return;
    }
    
    //    if (![self judgePassWordLegal:self.ZPConPswTextField.textField.text]) {
    //        [SVProgressHUD showInfoWithStatus:@"密碼必須8-20大小寫數字組合"];
    //        ZPLog(@"密码不足8位");
    //        return;
    //    }
    if (![self.ZPPswTextField.textField.text isEqualToString: self.ZPConPswTextField.textField.text]) {
        [SVProgressHUD showInfoWithStatus:MyLocal(@"two passwords do not match.")];
    }else {
        [SVProgressHUD showWithStatus:MyLocal(@"Changing password...")];
        [self AllData];
        
    }
}

// 修改密码数据（第二步）
- (void)AllData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"acc"] = [self.ZPEmailTextField.textField.text stringByReplacingOccurrencesOfString:@" " withString:@""]; // 防止輸入帶有空格
    dic[@"verifyemail"] = _verifyemail;
    dic[@"npwd"] = [self md5:_ZPPswTextField.textField.text];
    dic[@"npwd"] = [self md5:_ZPConPswTextField.textField.text];
    [ZP_LoginTool requestForgetPsw2:dic success:^(id obj) {
        NSDictionary * dic = obj;
        _verifyemail = dic[@"verifyemail"];
        if ([dic[@"result"] isEqualToString:@"ok"]) {
            [SVProgressHUD showSuccessWithStatus:MyLocal(@"Password recovered")];
            //            _verifyemail = dic[@"verifyemail"];
            [self.navigationController popViewControllerAnimated:YES];
        }else
            if ([dic[@"result"] isEqualToString:@"acc_null_err"]) {
                [SVProgressHUD showInfoWithStatus:MyLocal(@"Account is empty")];
            }else
                if ([dic[@"result"] isEqualToString:@"verifyemail_null_err"]) {
                    [SVProgressHUD showInfoWithStatus:MyLocal(@"Verify that the mailbox is empty.")];
                }else
                    if ([dic[@"result"] isEqualToString:@"npwd_null_err"]) {
                        [SVProgressHUD showInfoWithStatus:MyLocal(@"Password is empty")];
                    }else
                        if ([dic[@"result"] isEqualToString:@"sys_err"]) {
                            [SVProgressHUD showInfoWithStatus:MyLocal(@"Modify failure")];
                        }
        ZPLog(@"%@",dic);
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
}

#pragma mark - - - - - - - - - - - - - - - private methods 私有方法 - - - - - - - - - - - - - -
//- (BOOL)validateEmail:(NSString *)email {
////     邮箱正则式
//    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//    return [emailTest evaluateWithObject:email];
//}

- (BOOL)JudgeTheillegalCharacter:(NSString *)content {
    //    提示标签不能输入特殊字符
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    return [emailTest evaluateWithObject:content];
}

//- (BOOL)judgePassWordLegal:(NSString *)pass {
//    BOOL result ;
//
//// 判断长度大于8位后再接着判断是否同时包含数字和大小写字母
//    NSString * regex =@"(?![0-9A-Z]+$)(?![0-9a-z]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    result = [pred evaluateWithObject:pass];
//    return result;
//}

//  安全输入
-(void)secureTextEntry {
    _ZPPswTextField.textField.secureTextEntry = !_ZPPswTextField.textField.secureTextEntry;
    if (_ZPPswTextField.textField.secureTextEntry) {
        [_ZPPswTextField.functionBtn setImage:[UIImage imageNamed:@"ic_login_close.png"] forState:UIControlStateNormal];
    }else {
        [_ZPPswTextField.functionBtn setImage:[UIImage imageNamed:@"ic_login_open.png"] forState:UIControlStateNormal];
    }
}

//安全输入

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

@end
