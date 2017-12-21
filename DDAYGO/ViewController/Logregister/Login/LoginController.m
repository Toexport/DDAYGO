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
@interface LoginController ()

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
    self.LoginscrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滚动时键盘隐藏
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
    
    _ZPEmailTextField.textField.keyboardType = UIKeyboardTypeEmailAddress;
    
    _ZPPswTextField.showBtn                  = NO;
    _ZPPswTextField.showEyeBtn               = YES;
    [_ZPPswTextField.functionBtn addTarget:self action:@selector(secureTextEntry) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)LoginClick:(id)sender {
    if (![self validateEmail:_ZPEmailTextField.textField.text]) {
        [SVProgressHUD showInfoWithStatus:@"邮箱格式不正确"];
        }
    [self allData];
}

- (void)allData {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"email"] = _ZPEmailTextField.textField.text;
    dic[@"pwd"] = [self md5:_ZPPswTextField.textField.text];
    dic[@"countrycode"] = CountCode;
    
    NSLog(@"count %@",CountCode);
    
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"loginData"];
    [ZP_LoginTool requestLogin:dic success:^(id obj) {
        NSLog(@"obj---%@",obj);
        NSDictionary * aadic = obj;
        Token = aadic[@"token"];
        [[NSUserDefaults standardUserDefaults] setObject:Token forKey:@"token"];// Token缓存本地
        [[NSUserDefaults standardUserDefaults] synchronize]; // Token缓存本地
    
        [[NSUserDefaults standardUserDefaults] setObject:aadic[@"symbol"] forKey:@"symbol"]; // 台币缓存本地
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults] setObject:aadic[@"countrycode"] forKey:@"countrycode"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [SVProgressHUD showSuccessWithStatus:@"登录成功!"];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        
//        if ([aadic[@"result"] isEqualToString:@"ok"]) {
//            [ZP_LoginTool getAccountInfo:aadic[@"token"] success:^(id obj) {
//                NSDictionary * tempDic = obj;
//                NSDictionary *asdic = @{@"address":tempDic[@"address"],@"aid":tempDic[@"aid"],@"avatarimg":tempDic[@"avatarimg"],@"countrycode":tempDic[@"countrycode"],@"email":tempDic[@"email"],@"nickname":tempDic[@"nickname"],@"phone":tempDic[@"phone"],@"realname":tempDic[@"realname"],@"sex":tempDic[@"sex"],@"state":tempDic[@"state"],@"token":aadic[@"token"]};
//                [[NSUserDefaults standardUserDefaults] setObject:asdic forKey:@"userInfo"];
//                [[NSUserDefaults standardUserDefaults] setObject:aadic[@"token"] forKey:@"token"];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//                DD_HASLOGIN = YES;
//                [SVProgressHUD showSuccessWithStatus:@"登录成功!"];
//                [self.navigationController popToRootViewControllerAnimated:YES];
//            } failure:^(NSError *error) {
//                NSLog(@"%@",error);
//            }];
//        }else {
//            if ([aadic[@"result"]isEqualToString:@"acc_pwd_err"]) {
//                [SVProgressHUD showInfoWithStatus:@"邮箱或密码不正确"];
//            }
//        }
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

#pragma mark - 安全输入
-(void)secureTextEntry {
    _ZPPswTextField.textField.secureTextEntry = !_ZPPswTextField.textField.secureTextEntry;
    
    if (_ZPPswTextField.textField.secureTextEntry) {
        [_ZPPswTextField.functionBtn setImage:[UIImage imageNamed:@"ic_login_close.png"] forState:UIControlStateNormal];
    }else {
        [_ZPPswTextField.functionBtn setImage:[UIImage imageNamed:@"ic_login_open.png"] forState:UIControlStateNormal];
    }
}

//  键盘触摸
- (void)touchesBegan {
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //  设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //  将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
}
// 触发事件
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_ZPEmailTextField resignFirstResponder];
    [_ZPPswTextField resignFirstResponder];
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
@end

