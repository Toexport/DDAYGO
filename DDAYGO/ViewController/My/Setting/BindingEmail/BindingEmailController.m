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
@property (weak, nonatomic) IBOutlet TextView * ZPCodeTextField;
//@property (weak, nonatomic) IBOutlet TextView * ZPPswTextField;
@property (weak, nonatomic) IBOutlet UIButton * BinDing;
@property (nonatomic, strong) NSString * codeStr;
@end

@implementation BindingEmailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.title = NSLocalizedString(@"綁定郵箱", nil);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    self.BindingEmailscrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滚动时键盘隐藏
}
// UI
- (void)initUI {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.BinDing.layer.cornerRadius = 8.0;
    self.BinDing.layer.masksToBounds = YES;
    self.ZPEmailTextFiled.textField.keyboardType = UIKeyboardTypeEmailAddress;
    self.ZPEmailTextFiled.textField.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
//    [_ZPCodeTextField.functionBtn addTarget:self action:@selector(getMSNCode) forControlEvents:UIControlEventTouchUpInside];
//    _ZPCodeTextField.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
//    _ZPPswTextField.showBtn                    = NO;
//    _ZPPswTextField.showEyeBtn                 = YES;
//    [_ZPPswTextField.functionBtn addTarget:self action:@selector(secureTextEntry) forControlEvents:UIControlEventTouchUpInside];
}
//  绑定邮箱成功与失败
- (IBAction)BindingEmail:(id)sender {
    
    if (![self validateEmail:_ZPEmailTextFiled.textField.text]) {
        [SVProgressHUD showInfoWithStatus:@"郵箱格式不正確"];
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
//
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
            [SVProgressHUD showSuccessWithStatus:@"綁定成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else
            if ([obj[@"result"]isEqualToString:@"token_err"]) {
                [SVProgressHUD showInfoWithStatus:@"令牌無效"];
        }else
            if ([obj[@"result"]isEqualToString:@"emailverify_null_er"]) {
                [SVProgressHUD showInfoWithStatus:@"郵箱地址為空"];
        }else
            if ([obj[@"result"]isEqualToString:@"emailverify_format_err"]) {
                [SVProgressHUD showInfoWithStatus:@"郵箱地址格式錯誤"];
                        
        }else
            if ([obj[@"result"]isEqualToString:@"emailverify_exist_err"]) {
                [SVProgressHUD showInfoWithStatus:@"郵箱地址也被綁定"];
                
        }else
            if ([obj[@"result"]isEqualToString:@"failed_send_err"]) {
                [SVProgressHUD showInfoWithStatus:@"郵箱發送失敗"];
                                
        }else
            if ([obj[@"result"]isEqualToString:@"failed"]) {
                [SVProgressHUD showInfoWithStatus:@"操作失敗"];
        }
        
    } failure:^(NSError * error) {
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



@end
