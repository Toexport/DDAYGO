//
//  RegisterController.m
//  DDAYGO
//
//  Created by Login on 2017/10/18.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "RegisterController.h"
#import "TextView.h"
#import "PrefixHeader.pch"
#import "UINavigationBar+Awesome.h"
#import "ZP_NetorkingTools.h"
#import "ZP_LoginTool.h"
#import "UIButton+countDown.h"
#import "ZP_HomeTool.h"
#import "ZP_PositionModel.h"
#import "RegistrationAgreementController.h"
@interface RegisterController () {
    UIButton * _chooseCityBtn;
}
@property (weak, nonatomic) IBOutlet TextView * ZPAccountNumberTextFiled; // 账号
@property (weak, nonatomic) IBOutlet TextView * ZPPswTextField; // 密码
@property (weak, nonatomic) IBOutlet TextView * ZPEmailTextFiled;  // 邮箱
@property (weak, nonatomic) IBOutlet TextView * ZPCountryTextField;  // 国家
@property (weak, nonatomic) IBOutlet UIButton * RegBtn; // 注册按钮
@property (weak, nonatomic) IBOutlet UIButton * agreeBtn; 

//@property (nonatomic, strong) NSString * codeStr;
@property (nonatomic, strong) NSNumber * CountCode;

@end

@implementation RegisterController

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
    self.ZPAccountNumberTextFiled.textField.placeholder = MyLocal(@"ZPEmailTextFieldID");
    self.ZPPswTextField.textField.placeholder = MyLocal(@"ZPPswTextFieldID");
    self.ZPEmailTextFiled.textField.placeholder = MyLocal(@"ZPEmailTextFiled()");
    self.ZPCountryTextField.textField.placeholder = MyLocal(@"ZPCountry");
    self.title = NSLocalizedString(@"registration", nil);
    [self ButStatusAttribute];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    self.RegisterscrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滚动时键盘隐藏
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //    _RegBtn.layer.cornerRadius = 8.0;
    //    _RegBtn.layer.masksToBounds = YES;
    //    [_ZPCodeTextField.functionBtn addTarget:self action:@selector(getMSNCode) forControlEvents:UIControlEventTouchUpInside];
    //    _ZPCodeTextField.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.ZPAccountNumberTextFiled.textField.keyboardType = UIKeyboardTypeASCIICapable;
    self.ZPEmailTextFiled.textField.keyboardType = UIKeyboardTypeASCIICapable;
    [self.ZPCountryTextField.functionBtn setTitle:NSLocalizedString(@"Click select", nil) forState:UIControlStateNormal];
    self.ZPCountryTextField.textField.enabled = NO;
    [self.ZPCountryTextField.functionBtn addTarget:self action:@selector(choseCountry) forControlEvents:UIControlEventTouchUpInside];
    self.ZPPswTextField.showBtn                    = NO;
    self.ZPPswTextField.showEyeBtn                 = YES;
    //    _ZPPswTextField.textField.keyboardType = UIKeyboardTypeNamePhonePad;
    [self.ZPPswTextField.functionBtn addTarget:self action:@selector(secureTextEntry) forControlEvents:UIControlEventTouchUpInside];
}
// 按钮状态属性
- (void)ButStatusAttribute {
    self.RegBtn.userInteractionEnabled = NO;
    self.RegBtn.alpha = 0.5;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ButStatus:) name:UITextFieldTextDidChangeNotification object:self.ZPPswTextField.textField];
}
- (void)ButStatus:(UIButton *)sender {
    if (self.ZPPswTextField.textField.text.length > 0) {
        self.RegBtn.userInteractionEnabled = YES;
        self.RegBtn.alpha = 1;
    }else {
        self.RegBtn.userInteractionEnabled = NO;
        self.RegBtn.alpha = 0.5;
    }
}
//  注册
- (IBAction)rEgBut:(id)sender {
    if (![self JudgeTheillegalCharacter:self.ZPAccountNumberTextFiled.textField.text]) {
        [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"account format is not correct.", nil)];
        return;
    }
    //    if (_ZPEmailTextFiled.textField.text.length < 1) {
    //        [SVProgressHUD showInfoWithStatus:@"验证码不能为空"];
    //        ZPLog(@"请输入验证码");
    //        return;
    //    }
    if (self.ZPPswTextField.textField.text.length < 6||self.ZPPswTextField.textField.text.length >20) {
        [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"password number must not be less than 6 digits greater than 20 digits.", nil)];
        ZPLog(@"密码不足6位");
        return;
    }
    //    if (![self validateEmail:_ZPEmailTextFiled.textField.text]) {
    //        [SVProgressHUD showInfoWithStatus:@"请输入正确邮箱"];
    //        NSLog(@"请输入正确邮箱");
    //        return;
    //    }
    //    if (![self judgePassWordLegal:_ZPPswTextField.textField.text]) {
    //        [SVProgressHUD showInfoWithStatus:@"密码必须8-20大小写数字组合"];
    //        ZPLog(@"密码不足8位");
    //        return;
    //    }
    if (self.ZPCountryTextField.textField.text.length < 1) {
        [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"Choose country", nil)];
        ZPLog(@"选择国家");
        return;
    }
    if (!self.agreeBtn.selected) {
        [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"Agree to a deal", nil)];
        ZPLog(@"同意协议");
        return;
    }
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Registering...", nil)];
    [self allData];
    
}

// 数据
- (void)allData {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"email"] = self.ZPAccountNumberTextFiled.textField.text;
    dict[@"pwd"] = [self md5:self.ZPPswTextField.textField.text];
    dict[@"emailverify"] = self.ZPEmailTextFiled.textField.text;
    //这里是不是国家
    dict[@"countrycode"] = self.CountCode;
    [ZP_LoginTool requestRegiser:dict success:^(id obj) {
        ZPLog(@"%@",obj);
        NSDictionary * dic = obj;
        if ([dic[@"result"] isEqualToString:@"ok"]) {
            NSLog(@"注册成功");
//            [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Registered successfully", nil)];
            CountCode = self.CountCode;   // 保存国家
            REGISTERED_SUCCESSFULLY;
//            [self.navigationController popViewControllerAnimated:YES];
            
        }else
            if ([dic[@"result"] isEqualToString:@"sys_err"]) {
                [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"Registration failed", nil)];
            }else
                if ([dic[@"result"] isEqualToString:@"email_null_err"]) {
                    [SVProgressHUD showInfoWithStatus:MyLocal(@"account cannot be empty.")];
                }else
                    if ([dic[@"result"] isEqualToString:@"email_format_err"]) {
                        [SVProgressHUD showInfoWithStatus:MyLocal(@"Incorrect account format")];
                    }else
                        if ([dic[@"result"] isEqualToString:@"email_key_err"]) {
                            [SVProgressHUD showInfoWithStatus:MyLocal(@"registered account cannot begin with an ICUE.")];
                        }else
                            if ([dic[@"result"] isEqualToString:@"email_format2_err"]) {
                                [SVProgressHUD showInfoWithStatus:MyLocal(@"account cannot contain the ddaygo character.")];
                            } else
                                if ([dic[@"result"] isEqualToString:@"pwd_null_err"]) {
                                    [SVProgressHUD showInfoWithStatus:MyLocal(@"password cannot be empty.")];
                                }else
                                    if ([dic[@"result"] isEqualToString:@"email_exist_err"]) {
                                        [SVProgressHUD showInfoWithStatus:MyLocal(@"Account already exists")];
                                    }else
                                        if ([dic[@"result"] isEqualToString:@"emailverify_formart_err"]) {
                                            [SVProgressHUD showInfoWithStatus:MyLocal(@"Email format error")];
                                        }else
                                            if ([dic[@"result"] isEqualToString:@"emailverify_exist_err"]) {
                                                [SVProgressHUD showInfoWithStatus:MyLocal(@"mailbox has been bound.")];
                                            }else
                                                if ([dic[@"result"] isEqualToString:@"verify_send_err"]) {
                                                    [SVProgressHUD showInfoWithStatus:MyLocal(@"Mailbox validation letter delivery failed.")];
                                                }
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
        //        [SVProgressHUD showInfoWithStatus:@"服务器链接失败"];
    }];
}


#pragma mark - - - - - - - - - - - - - - - event response 事件相应 - - - - - - - - - - - - - -


//- (void)getMSNCode{
//    if (![self validateEmail:_ZPEmailTextFiled.textField.text]) {
//
//        [SVProgressHUD showInfoWithStatus:@"邮箱格式不正确"];
//        return;
//    }
//
//    __weak typeof (self) WeakSelf = self;
//    [_ZPCodeTextField.functionBtn startWithTime:60 title:NSLocalizedString(@"重新获取", nil) titleColor:[UIColor whiteColor]countDownTitle:@"s" countDownTitleColor:[UIColor whiteColor] mainColor:ZP_PayColor countColor:ZP_PayColor];
//    [WeakSelf qurestCode];  // 开始获取验证码
//}
//
////  发生网络请求 --> 获取验证码
//- (void)qurestCode {
//    ZPLog(@"发生网络请求 --> 获取验证码");
//    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
//    dict[@"email"] = _ZPEmailTextFiled.textField.text;
//
//    [ZP_LoginTool requestVerificationcode:dict success:^(id obj) {
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
//}

// 选择国家
- (void)choseCountry {
    self.ZPCountryTextField.functionBtn.userInteractionEnabled = NO;
    [self PositionallData];
    ZPLog(@"选择国家");
}
//  国家列表数据
- (void)PositionallData {
    [ZP_HomeTool requesPosition:nil success:^(id obj) {
        self.ZPCountryTextField.functionBtn.userInteractionEnabled = YES;
        NSArray * arr = [ZP_PositionModel arrayWithArray:obj];
        //        ZPLog(@"%@",obj);
        PositionView * position = [[PositionView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, ZP_height)];
        [position Position:arr];
        position.ThirdBlock = ^(NSString *ContStr,NSNumber *code) {
            //            NSLog(@"c = %@ %@",ContStr,code);
            self.CountCode = code;
            self.ZPCountryTextField.textField.text = ContStr;
        };
        //  显示
        [position showInView:self.navigationController.view];
        
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
        self.ZPCountryTextField.functionBtn.userInteractionEnabled = YES;
        //        [SVProgressHUD showInfoWithStatus:@"服务器链接失败"];
    }];
}

- (IBAction)agreeClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    ZPLog(@"同意");
    
}

- (IBAction)userServerClick:(id)sender {
    RegistrationAgreementController * RegistrationAgreement = [[RegistrationAgreementController alloc]init];
    RegistrationAgreement.title = MyLocal(@"terms service");
    RegistrationAgreement.type = 222;
    [self.navigationController pushViewController:RegistrationAgreement animated:YES];
    
    ZPLog(@"用户服务协议");
}
#pragma mark - - - - - - - - - - - - - - - private methods 私有方法 - - - - - - - - - - - - - -
- (BOOL)validateEmail:(NSString *)email {
    //     邮箱正则式
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}

- (BOOL)JudgeTheillegalCharacter:(NSString *)content {
    //    提示标签不能输入特殊字符
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    return [emailTest evaluateWithObject:content];
    
}

//- (BOOL)judgePassWordLegal:(NSString *)pass {
//
//    BOOL result ;
//    // 判断长度大于8位后再接着判断是否同时包含数字和大小写字母
//    NSString * regex =@"(?![0-9A-Z]+$)(?![0-9a-z]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$";
//
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//
//    result = [pred evaluateWithObject:pass];
//
//    return result;
//
//}

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

#pragma mark - - - - - - - - - - - - - - delegate 视图委托 - - - - - - - - - - - - - -
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (self.ZPCountryTextField.textField == textField) {
        [self choseCountry];
        return NO;
    }
    return YES;
}

#pragma mark - 安全输入
-(void)secureTextEntry {
    self.ZPPswTextField.textField.secureTextEntry = !self.ZPPswTextField.textField.secureTextEntry;
    
    if (self.ZPPswTextField.textField.secureTextEntry) {
        [self.ZPPswTextField.functionBtn setImage:[UIImage imageNamed:@"ic_login_close.png"] forState:UIControlStateNormal];
    }else {
        [self.ZPPswTextField.functionBtn setImage:[UIImage imageNamed:@"ic_login_open.png"] forState:UIControlStateNormal];
    }
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
