//
//  BindingICUEViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/22.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "BindingICUEViewController.h"
#import "DialogBox.h"
#import "ZP_MyTool.h"
#import "PrefixHeader.pch"
@interface BindingICUEViewController ()

@end

@implementation BindingICUEViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ButStatusAttribute];
    self.title = NSLocalizedString(@"ICUC綁定", nil);
    self.PassWordtextField.secureTextEntry = YES;
    _AccountnumbertextField.keyboardType = UIKeyboardTypeASCIICapable;
    self.AccountnumbertextField.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
    self.PassWordtextField.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    self.BindingICUEscrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滚动时键盘隐藏
}

// 按钮状态属性
- (void)ButStatusAttribute {
    self.BindingBut.alpha = 0.5;
    self.BindingBut.userInteractionEnabled = NO;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ButStatus:) name:UITextFieldTextDidChangeNotification object:self.PassWordtextField];
}
- (void)ButStatus:(UIButton *)sender {
    if (self.PassWordtextField.text.length > 0) {
        self.BindingBut.userInteractionEnabled = YES;
        self.BindingBut.alpha = 1;
    }else {
        self.PassWordtextField.userInteractionEnabled = NO;
        self.PassWordtextField.alpha = 0.5;
    }
}
- (IBAction)buildingAction:(id)sender {
#pragma make -- 提示框
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"ICUE账号一旦绑定后将无法更改，您确定要绑定此ICUE账号吗？",nil) preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        ZPLog(@"取消");
    }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"確定",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [self allData];
    }];
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

// 数据
- (void)allData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"icueaccount"] = [self.AccountnumbertextField.text stringByReplacingOccurrencesOfString:@" " withString:@""]; // 防止輸入帶有空格
    dic[@"pwd"] = _PassWordtextField.text;
    dic[@"token"] = Token;
    ZPLog(@"%@",dic);
    [ZP_MyTool requestBindingICUE:dic success:^(id obj) {
        NSDictionary * dic = obj;
        if ([dic[@"result"] isEqualToString:@"ok"]) {
            ZPLog(@"加入成功");
            [SVProgressHUD showSuccessWithStatus:@"綁定成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else
            if ([dic[@"result"]isEqualToString:@"icue_err"]) {
                ZPLog(@"icue_err：icue號已被綁定");
                [SVProgressHUD showInfoWithStatus:@"ICUE號已被綁定"];
        }else
            if ([dic[@"result"]isEqualToString:@"sys_err"]) {
                [SVProgressHUD showInfoWithStatus:@"服務器連接至火星"];
                ZPLog(@"sys_err：系统错误");
        }else
            if ([dic[@"result"]isEqualToString:@"inter_err"]) {
                [SVProgressHUD showInfoWithStatus:@"服務器連接至火星"];
                ZPLog(@"inter_err：网络错误");
        }else
            if ([dic[@"result"]isEqualToString:@"acc_pwd_err"]) {
                [SVProgressHUD showInfoWithStatus:@"賬號或密碼錯誤"];
                ZPLog(@"acc_pwd_err：账号密码错误");
        }else
            if ([dic[@"result"]isEqualToString:@"invalid_user"]) {
                [SVProgressHUD showInfoWithStatus:@"無效的賬戶"];
                ZPLog(@"invalid_user:无效的账户");
        }else
            if ([dic[@"result"]isEqualToString:@"black_account"]) {
                [SVProgressHUD showInfoWithStatus:@"黑名單用戶"];
                ZPLog(@"black_account：黑名单用户");
        }else
            if ([dic[@"result"]isEqualToString:@"account_notexist"]) {
                [SVProgressHUD showInfoWithStatus:@"賬戶不存在"];
                ZPLog(@"account_notexist：账户不存在");
        }else
            if ([dic[@"result"]isEqualToString:@"permission_denied"]) {
                [SVProgressHUD showInfoWithStatus:@"無權限"];
                ZPLog(@"permission_denied：无权限");
        }else
            if ([dic[@"result"]isEqualToString:@"invalid_db_request"]) {
                [SVProgressHUD showInfoWithStatus:@"服務器連接至火星"];
                ZPLog(@"invalid_db_request:数据库请求错误");
        }else
            if ([dic[@"result"]isEqualToString:@"internal_error"]) {
                [SVProgressHUD showInfoWithStatus:@"服務器連接至火星"];
                ZPLog(@"internal_error：内部错误");
      }
    } failure:^(NSError * error) {
        
    }];
}
#pragma mark -- 安全输入
- (IBAction)showPwAction:(UIButton *)sender {
    
    _PassWordtextField.secureTextEntry = sender.selected;
    sender.selected =!sender.selected;
}

@end
