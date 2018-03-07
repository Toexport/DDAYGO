//
//  BindingEmailController.m
//  DDAYGO
//
//  Created by Summer on 2017/11/6.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "BindingEmailController.h"
#import "PrefixHeader.pch"
#import "ZP_MyTool.h"
#import "PromptBox.h"
#import "TextView.h"
@interface BindingEmailController ()
@property (weak, nonatomic) IBOutlet TextView * ZPEmailTextFiled;
//@property (weak, nonatomic) IBOutlet TextView * ZPCodeTextField;
//@property (weak, nonatomic) IBOutlet TextView * ZPPswTextField;
@property (weak, nonatomic) IBOutlet UIButton * BinDing;
//@property (nonatomic, strong) NSString * codeStr; // 验证码
@end

@implementation BindingEmailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.title = MyLocal(@"Binding email");
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    self.BindingEmailscrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滚动时键盘隐藏
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(adjustStatusBar:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}
// UI
- (void)initUI {
    [self ButStatusAttribute];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //    self.BinDing.layer.cornerRadius = 8.0;
    //    self.BinDing.layer.masksToBounds = YES;
    self.ZPEmailTextFiled.textField.keyboardType = UIKeyboardTypeEmailAddress;
    self.ZPEmailTextFiled.textField.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
//    [self.ZPEmailTextFiled.textField.placeholder = MyLocal(@"ZPEmailTextFiled")];
    self.ZPEmailTextFiled.textField.placeholder = MyLocal(@"ZPEmailTextFiled");
    //    [_ZPCodeTextField.functionBtn addTarget:self action:@selector(getMSNCode) forControlEvents:UIControlEventTouchUpInside];
    //    _ZPCodeTextField.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    //    _ZPPswTextField.showBtn                    = NO;
    //    _ZPPswTextField.showEyeBtn                 = YES;
    //    [_ZPPswTextField.functionBtn addTarget:self action:@selector(secureTextEntry) forControlEvents:UIControlEventTouchUpInside];
}

// 按钮状态属性
- (void)ButStatusAttribute {
    self.BinDing.alpha = 0.5;
    self.BinDing.userInteractionEnabled = NO;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ButStatus:) name:UITextFieldTextDidChangeNotification object:self.ZPEmailTextFiled.textField];
}
- (void)ButStatus:(UIButton *)sender {
    
    if (self.ZPEmailTextFiled.textField.text.length > 0) {
        self.BinDing.userInteractionEnabled = YES;
        self.BinDing.alpha = 1;
    }else {
        self.BinDing.userInteractionEnabled = NO;
        self.BinDing.alpha = 0.5;
    }
}
//  绑定邮箱成功与失败
- (IBAction)BindingEmail:(id)sender {
    if (![self validateEmail:_ZPEmailTextFiled.textField.text]) {
        [SVProgressHUD showInfoWithStatus:MyLocal(@"Incorrect email format.")];
        return;
    }
    
    //    if (_ZPCodeTextField.textField.text.length < 1) {
    //        [SVProgressHUD showInfoWithStatus:@"验证码不能为空"];
    //        ZPLog(@"请输入验证码");
    //        return;
    //    }
    //    if (![_ZPCodeTextField.textField.text isEqualToString:_codeStr]) {
    //        [SVProgressHUD showInfoWithStatus:@"请输入正确验证码"];
    //        NSLog(@"请输入正确验证码");
    //        return;
    //    }
    [SVProgressHUD showWithStatus:MyLocal(@"Please later…")];
    [self allData]; // 数据
    //    ZPLog(@"----");
}

// 绑定邮箱数据
- (void)allData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    dic[@"emailverify"] = self.ZPEmailTextFiled.textField.text;
    [ZP_MyTool requesEmail:dic uccess:^(id obj) {
        ZPLog(@"%@",obj);
        if ([obj[@"result"]isEqualToString:@"ok"]) {
            [SVProgressHUD showSuccessWithStatus:MyLocal(@"Binding success")];
            [self.navigationController popViewControllerAnimated:YES];
        }else
            if ([obj[@"result"]isEqualToString:@"token_err"]) {
                [SVProgressHUD showInfoWithStatus:MyLocal(@"token is invalid")];
            }else
                if ([obj[@"result"]isEqualToString:@"emailverify_null_er"]) {
                    [SVProgressHUD showInfoWithStatus:MyLocal(@"E-mail address cannot be empty.")];
                }else
                    if ([obj[@"result"]isEqualToString:@"emailverify_format_err"]) {
                        [SVProgressHUD showInfoWithStatus:MyLocal(@"Email format error")];
                        
                    }else
                        if ([obj[@"result"]isEqualToString:@"emailverify_exist_err"]) {
                            [SVProgressHUD showInfoWithStatus:MyLocal(@"mailbox address has been bound.")];
                            
                        }else
                            if ([obj[@"result"]isEqualToString:@"failed_send_err"]) {
                                [SVProgressHUD showInfoWithStatus:MyLocal(@"Email failed")];
                                
                            }else
                                if ([obj[@"result"]isEqualToString:@"failed"]) {
                                    [SVProgressHUD showInfoWithStatus:MyLocal(@"Operation failure")];
                                }else
                                    //*************************************Token被挤掉***************************************************//
                                    if ([obj[@"result"]isEqualToString:@"token_not_exist"]) {
                                        Token = nil;
                                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
                                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"symbol"];
                                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"countrycode"];
            DD_ChangeStaus;
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
                                            [self.navigationController popToRootViewControllerAnimated:NO];
                                            //跳转
                                            if ([[[UIApplication sharedApplication] keyWindow].rootViewController isKindOfClass:[UITabBarController class]]) {
                                                UITabBarController * tbvc = [[UIApplication sharedApplication] keyWindow].rootViewController;
                                                [tbvc setSelectedIndex:0];
                                            }
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
        ZPLog(@"%@",error);
    }];
}

#pragma mark - - - - - - - - - - - - - - - event response 事件相应 - - - - - - - - - - - - - -
//- (void)getMSNCode{
//    if (![self validateEmail:_ZPEmailTextFiled.textField.text]) {
//
//        [SVProgressHUD showInfoWithStatus:MyLocal(@"Incorrect email format.")];
//        return;
//    }
//
//    __weak typeof (self) WeakSelf = self;
//    [_ZPCodeTextField.functionBtn startWithTime:60 title:NSLocalizedString(@"Incorrect email format.", nil) titleColor:[UIColor whiteColor]countDownTitle:@"s" countDownTitleColor:[UIColor whiteColor] mainColor:ZP_PayColor countColor:ZP_PayColor];
//    [WeakSelf qurestCode];  // 开始获取验证码
//}
//
////  发生网络请求 --> 获取验证码
//- (void)qurestCode {
//    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
//    dict[@"email"] = _ZPEmailTextFiled.textField.text;
//    [ZP_MyTool requestVerificationcode:dict success:^(id obj) {
//        NSDictionary * dic = obj;
//        ZPLog(@"%@",dic);
//        if ([dic[@"result"] isEqualToString:@"ok"]) {
//            [SVProgressHUD showSuccessWithStatus:@"发送成功!"];
//            ZPLog(@"发送成功");
//            _codeStr = dic[@"code"];
//        }else {
//            if ([dic[@"result"] isEqualToString:@"email_err"]) {
//                [SVProgressHUD showInfoWithStatus:@"邮箱已存在"];
//        }else {
//            if ([dic[@"result"] isEqualToString:@"Error"]) {
//                [SVProgressHUD showInfoWithStatus:@"已连接至火星"];
//
//                }
//            }
//        }
//    } failure:^(NSError * error) {
//        ZPLog(@"%@", error);
//    }];
//
//}

#pragma mark - - - - - - - - - - - - - - - private methods 私有方法 - - - - - - - - - - - - - -
- (BOOL)validateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}

////  密码显示与隐藏
//-(void)secureTextEntry {
//    _ZPPswTextField.textField.secureTextEntry = !_ZPPswTextField.textField.secureTextEntry;
//    if (_ZPPswTextField.textField.secureTextEntry) {
//        [_ZPPswTextField.functionBtn setImage:[UIImage imageNamed:@"ic_login_close.png"] forState:UIControlStateNormal];
//    }else {
//
//        [_ZPPswTextField.functionBtn setImage:[UIImage imageNamed:@"ic_login_open.png"] forState:UIControlStateNormal];
//    }
//}

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
