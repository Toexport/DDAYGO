//
//  YueTixianController.m
//  DDAYGO
//
//  Created by Summer on 2017/12/4.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "YueTixianController.h"
#import "ZP_ExtractController.h"
#import "PrefixHeader.pch"
#import "ZP_MyTool.h"
@interface YueTixianController ()<UITextFieldDelegate>

@end

@implementation YueTixianController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    self.title = NSLocalizedString(@"提現", nil);
    UIBarButtonItem * ExtractBut = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_withdrawals_record"] style:UIBarButtonItemStyleDone target:self action:@selector(Extract)];
    ExtractBut.tintColor = ZP_WhiteColor;
    self.amountText.keyboardType = UIKeyboardTypeNumberPad;
    self.PaymentAccountText.keyboardType = UIKeyboardTypeNumberPad;
    self.reservedPhoneText.keyboardType = UIKeyboardTypeNumberPad;
    self.emailText.keyboardType = UIKeyboardTypeASCIICapable;
    self.navigationItem.rightBarButtonItem = ExtractBut;
    self.TikuanscrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滚动时键盘隐藏
}

- (void)Extract {
    ZPLog(@"跳转");
        ZP_ExtractController * Extract = [[ZP_ExtractController alloc]init];
        Extract.supplierId = self.SupplierId;
        [self.navigationController pushViewController:Extract animated:YES];
}

- (IBAction)CompleteButton:(id)sender {
    //这个是判断金额不能小于1
    if ([_amountText.textField.text intValue] < 1) {
        [SVProgressHUD showInfoWithStatus:@"请输入正确金额"];
        return;
    }
    // 这个是判断 至少输入一个 字
    if (_payeeText.textField.text.length < 1) {
        [SVProgressHUD showInfoWithStatus:@"请输入联系人"];
        return;
    }
    if (_CollectingBankText.textField.text.length < 1) {
        [SVProgressHUD showInfoWithStatus:@"请输入收款银行"];
        return;
    }
    if (_PaymentAccountText.textField.text.length < 1) {
        [SVProgressHUD showInfoWithStatus:@"请输入收款账号"];
        return;
    }
    if (_reservedPhoneText.textField.text.length  < 1) {
        [SVProgressHUD showInfoWithStatus:@"请输入电话"];
        return;
    }
    if (![self validateEmail:_emailText.textField.text]) {
        [SVProgressHUD showInfoWithStatus:@"郵箱格式不正確"];
        return;
    }
    if (_emailText.textField.text.length < 1) {
        [SVProgressHUD showInfoWithStatus:@"请输入邮箱"];
        return;
    }
        
    [self AllData];
}

// 数据
- (void)AllData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    dic[@"sid"] = _SupplierId;
    dic[@"amount"] = _amountText.textField.text;
    dic[@"bankcardname"] = [_payeeText.textField.text stringByAddingPercentEscapesUsingEncoding:kCFStringEncodingUTF8];
//    NSUTF8StringEncoding
    dic[@"bankname"] = [_CollectingBankText.textField.text stringByAddingPercentEscapesUsingEncoding:kCFStringEncodingUTF8];
    dic[@"bankcardno"] = _PaymentAccountText.textField.text;
    dic[@"phone"] = _reservedPhoneText.textField.text;
    dic[@"email"] = _emailText.textField.text;
    
    [ZP_MyTool requesAddSupplierTakeOut:dic success:^(id obj) {
        if ([obj[@"result"]isEqualToString:@"ok"]) {
            [SVProgressHUD showSuccessWithStatus:@"申請成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else
            if ([obj[@"result"]isEqualToString:@"apply_count_err"]) {
                [SVProgressHUD showInfoWithStatus:@"超过每日可提现次数  每日限制一次"];
            }else
                if ([obj[@"result"]isEqualToString:@"takeamount_err"]) {
                    [SVProgressHUD showInfoWithStatus:@"可提现金额不足"];
                    
                }
    } failure:^(NSError *error) {
        NSLog(@"error %@",error);
    }];
}

#pragma mark - - - - - - - - - - - - - - - private methods 私有方法 - - - - - - - - - - - - - -
- (BOOL)validateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}

@end

