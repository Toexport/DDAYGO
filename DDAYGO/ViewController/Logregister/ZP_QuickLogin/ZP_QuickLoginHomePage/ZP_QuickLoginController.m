//
//  ZP_QuickLoginController.m
//  DDAYGO
//
//  Created by Summer on 2017/12/18.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_QuickLoginController.h"
#import "TextView.h"
#import "PrefixHeader.pch"
#import "ZP_LoginTool.h"
#import "ZP_HomeTool.h"
#import "ZP_PositionModel.h"
#import "UINavigationBar+Awesome.h"
#import "RegistrationAgreementController.h"
@interface ZP_QuickLoginController ()
{
    BOOL userL;
    
}
@property (weak, nonatomic) IBOutlet TextView * ZPEmailTextField;
@property (weak, nonatomic) IBOutlet TextView * ZPPswTextField;
@property (weak, nonatomic) IBOutlet UIButton * LoginBtn;
//@property (nonatomic, strong) UIView * Boview;
@property (weak, nonatomic) IBOutlet UIButton * ProtocolBut;

@end

@implementation ZP_QuickLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(adjustStatusBar:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

// UI
- (void)initUI {
    self.title = NSLocalizedString(@"ICUE Quick login", nil);
    self.ZPEmailTextField.textField.placeholder = MyLocal(@"ZPEmailICUE");
    self.ZPPswTextField.textField.placeholder = MyLocal(@"ZPPswTextField");
    [self ButStatusAttribute];
    self.QuickLoginscrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滚动时键盘隐
    //    _LoginBtn.layer.cornerRadius             = 8.0;
    //    _LoginBtn.layer.masksToBounds            = YES;
    self.ZPEmailTextField.textField.keyboardType = UIKeyboardTypeASCIICapable;
    self.ZPPswTextField.showBtn                  = NO;
    self.ZPPswTextField.showEyeBtn               = YES;
    [self.ZPPswTextField.functionBtn addTarget:self action:@selector(secureTextEntry) forControlEvents:UIControlEventTouchUpInside];
}

// 按钮状态属性
- (void)ButStatusAttribute {
    self.LoginBtn.userInteractionEnabled = NO;
    self.LoginBtn.alpha = 0.5;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ButStatus:) name:UITextFieldTextDidChangeNotification object:self.ZPPswTextField.textField];
}
- (void)ButStatus:(UIButton *)sender {
    if (self.ZPPswTextField.textField.text.length > 0) {
        self.LoginBtn.userInteractionEnabled = YES;
        self.LoginBtn.alpha = 1;
    }else {
        self.LoginBtn.userInteractionEnabled = NO;
        self.LoginBtn.alpha = 0.5;
    }
}

//  登录
- (IBAction)LoginClick:(id)sender {
    if (_ZPEmailTextField.textField.text.length < 1) {
        [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"E-mail address cannot be empty.", nil)];
        return;
    }
    if (_ZPPswTextField.textField.text.length < 1) {
        [SVProgressHUD showWithStatus:NSLocalizedString(@"password cannot be empty.", nil)];
        return;
    }
    if (!_ProtocolBut.selected) {
        [SVProgressHUD showInfoWithStatus:MyLocal(@"Please choose to agree to the user agreement.")];
        ZPLog(@"同意协议");
        return;
    }
    
    _LoginBtn.userInteractionEnabled = NO;

    [SVProgressHUD showWithStatus:NSLocalizedString(@"Logging in...", nil)];
    [self AllData];
    ZPLog(@"数据");
}


//  数据 ICUE登入（如返回首次登入则调用55再请求）
- (void)AllData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"acc"] = [_ZPEmailTextField.textField.text stringByReplacingOccurrencesOfString:@" " withString:@""]; // 防止輸入帶有空格
    dic[@"pwd"] = [_ZPPswTextField.textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    [ZP_LoginTool requesForFirstTimeLogin:dic success:^(id obj) {
        [SVProgressHUD dismiss];
        NSDictionary * adic = obj;
        ZPLog(@"%@",obj);
        //目前不是参数的类型··可能会崩,s
        
        if ([adic[@"result"]isEqualToString:@"first_login"]) {
            
            [self getPosttion];  //  调用55的接口
        }else {
            _LoginBtn.userInteractionEnabled = YES;
            if ([adic[@"result"]isEqualToString:@"ok"]) {
                Token = obj[@"token"];
                ZPICUEToken = obj[@"icuetoken"];
                [[NSUserDefaults standardUserDefaults] setObject:Token forKey:@"token"];// Token缓存本地
                [[NSUserDefaults standardUserDefaults] setObject:ZPICUEToken forKey:@"icuetoken"];
                [[NSUserDefaults standardUserDefaults] setObject:obj[@"symbol"] forKey:@"symbol"]; // 台币缓存本地
                [[NSUserDefaults standardUserDefaults] setObject:obj[@"countrycode"] forKey:@"countrycode"];  // 国别缓存本地
                [[NSUserDefaults standardUserDefaults] synchronize];  // 国别缓存本地
                [SVProgressHUD showSuccessWithStatus:MyLocal(@"Login successful")];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else
                if ([adic[@"result"]isEqualToString:@"failure"]) {
                    //                [SVProgressHUD showInfoWithStatus:@"登錄失敗"];
                }else
                    if ([adic[@"result"]isEqualToString:@"acc_pwd_err"]) {
                        [SVProgressHUD showInfoWithStatus:MyLocal(@"Account or password error.")];
                    }else
                        if ([adic[@"result"]isEqualToString:@"acc_null_err"]) {
                            [SVProgressHUD showInfoWithStatus:MyLocal(@"Account is empty")];
                        }else
                            if ([adic[@"result"]isEqualToString:@"pwd_null_err"]) {
                                [SVProgressHUD showInfoWithStatus:MyLocal(@"Password is empty")];
                            }else
                                if ([adic[@"result"]isEqualToString:@"sys_err"]) {
                                    [SVProgressHUD showInfoWithStatus:MyLocal(@"System error")];
                                }else
                                    if ([adic[@"result"]isEqualToString:@"token_err"]) {
                                        [SVProgressHUD showInfoWithStatus:MyLocal(@"Token existing")];
                                    }else
                                        if ([adic[@"result"]isEqualToString:@"isnot_agent"]) {
                                             [SVProgressHUD showInfoWithStatus:MyLocal(@"The account is not an agent.")];
                                        }
        }
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
        _LoginBtn.userInteractionEnabled = YES;
    }];
}
//  调用55的接口
- (void)getPosttion {
    [self choseCountry];
}

// ICUE号首次登入 (55)
- (void)ForFirstTimeLogin {
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"acc"] = _ZPEmailTextField.textField.text;
    dict[@"pwd"] = _ZPPswTextField.textField.text;
    dict[@"countrycode"] = CountCode;
    [ZP_LoginTool requsetICUELogin:dict success:^(id obj) {
        NSDictionary * adic = obj;
        ZPLog(@"%@",obj);
        //目前不是参数的类型··可能会崩,s
        if ([adic[@"result"]isEqualToString:@"first_login"]) {
//            [SVProgressHUD showInfoWithStatus:@"首次登錄改成"];
        }else
            if ([adic[@"result"]isEqualToString:@"ok"]) {
                Token = obj[@"token"];
                ZPICUEToken = obj[@"icuetoken"];
                [[NSUserDefaults standardUserDefaults] setObject:Token forKey:@"token"];// Token缓存本地
                [[NSUserDefaults standardUserDefaults] setObject:ZPICUEToken forKey:@"icuetoken"];
                [[NSUserDefaults standardUserDefaults] setObject:obj[@"symbol"] forKey:@"symbol"]; // 货币符号缓存本地
                [[NSUserDefaults standardUserDefaults] setObject:obj[@"countrycode"] forKey:@"countrycode"];  // 国别缓存本地
                [[NSUserDefaults standardUserDefaults] synchronize];  // 国别缓存本地
                [SVProgressHUD showSuccessWithStatus:MyLocal(@"Login successful")];
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }else
                if ([adic[@"result"]isEqualToString:@"failure"]) {
                    [SVProgressHUD showInfoWithStatus:MyLocal(@"Login failed")];
                }else
                    if ([adic[@"result"]isEqualToString:@"country_err"]) {
                        [SVProgressHUD showInfoWithStatus:MyLocal(@"National coding error")];
                    }else
                        if ([adic[@"result"]isEqualToString:@"acc_null_err"]) {
                            [SVProgressHUD showInfoWithStatus:MyLocal(@"Account is empty")];
                        }else
                            if ([adic[@"result"]isEqualToString:@"pwd_null_err"]) {
                                [SVProgressHUD showInfoWithStatus:MyLocal(@"Password is empty")];
                            }else
                                if ([adic[@"result"]isEqualToString:@"sys_err"]) {
                                    [SVProgressHUD showInfoWithStatus:MyLocal(@"System error")];
                                }else
                                    if ([adic[@"result"]isEqualToString:@"token_err"]) {
                                        [SVProgressHUD showInfoWithStatus:MyLocal(@"Token existing")];
                                    }else
                                        if ([dict[@"result"]isEqualToString:@"isnot_agent"]) {
                                            [SVProgressHUD showInfoWithStatus:MyLocal(@"The account is not an agent.")];
 
        }
    } failure:^(NSError * error) {
//        [SVProgressHUD showInfoWithStatus:MyLocal(@"Server link failed")];
    }];
}

// 选择国家
- (void)choseCountry {
    [self PositionallData];
    ZPLog(@"选择国家");
}
//  国家列表数据
- (void)PositionallData {
    
    [ZP_HomeTool requesPosition:nil success:^(id obj) {
        _LoginBtn.userInteractionEnabled = YES;
        NSArray * arr = [ZP_PositionModel arrayWithArray:obj];
        PositionView * position = [[PositionView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, ZP_height)];
        [position Position:arr];
        position.ThirdBlock = ^(NSString *ContStr,NSNumber *code) {
            CountCode = code;
#pragma make -- 提示框
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"reminding", nil) message:NSLocalizedString(@"Once the locale is set, it cannot be changed.",nil) preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:MyLocal(@"Cancel",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                ZPLog(@"取消");
            }];
            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"ok",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                // 接口55
                [self ForFirstTimeLogin];
            }];
            [alert addAction:defaultAction];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
            
        };
        //  显示
        [position showInView:self.navigationController.view];
    } failure:^(NSError *error) {
        _LoginBtn.userInteractionEnabled = YES;
        [SVProgressHUD showInfoWithStatus:MyLocal(@"Server link failed")];
    }];
}

//#pragma mark - - - - - - - - - - - - - - - private methods 私有方法 - - - - - - - - - - - - - -
//- (BOOL)validateEmail:(NSString *)email {
//
//    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//
//    return [emailTest evaluateWithObject:email];
//
//}

#pragma mark - 安全输入

-(void)secureTextEntry {
    _ZPPswTextField.textField.secureTextEntry = !_ZPPswTextField.textField.secureTextEntry;
    
    if (_ZPPswTextField.textField.secureTextEntry) {
        [_ZPPswTextField.functionBtn setImage:[UIImage imageNamed:@"ic_login_close.png"] forState:UIControlStateNormal];
    }else {
        [_ZPPswTextField.functionBtn setImage:[UIImage imageNamed:@"ic_login_open.png"] forState:UIControlStateNormal];
    }
}

#pragma mark - 用戶協議
- (IBAction)UserAgreementBut:(UIButton *)sender {
    sender.selected = !sender.selected;
}

#pragma mark - 用戶服务協議
- (IBAction)yonghufuwuxieyi:(id)sender {
    RegistrationAgreementController * RegistrationAgreement = [[RegistrationAgreementController alloc]init];
    RegistrationAgreement.title = MyLocal(@"terms service");
    RegistrationAgreement.type = 222;
    [self.navigationController pushViewController:RegistrationAgreement animated:YES];
    ZPLog(@"用户服务协议 ");
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
