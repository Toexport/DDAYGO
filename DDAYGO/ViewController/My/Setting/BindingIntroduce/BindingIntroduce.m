//
//  BindingIntroduce.m
//  DDAYGO
//
//  Created by Summer on 2017/11/27.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "BindingIntroduce.h"
#import "PromptBox.h"
#import "ZP_MyTool.h"
#import "PrefixHeader.pch"
@interface BindingIntroduce ()

@end

@implementation BindingIntroduce

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"绑定推荐人", nil);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
     _BindingIntroduceTextField.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
    
}

// 绑定推荐人
- (IBAction)BindingIntroduceTextField:(id)sender {
    [self allData];
//    [[PromptBox getInstance] showDialogBoxWithOperation:DDABuildingICUC FinishBlock:nil];
}
- (void)allData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"acc"] = _BindingIntroduceTextField.text;
    dic[@"token"] = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    [ZP_MyTool requesIntroduce:dic success:^(id obj) {
        NSDictionary * dic = obj;
        if ([dic[@"result"]isEqualToString:@"ok"]) {
            [SVProgressHUD showSuccessWithStatus:@"绑定成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            if ([dic[@"result"]isEqualToString:@"failure"]) {
                [SVProgressHUD showInfoWithStatus:@"绑定失败"];
        }else {
            if ([dic[@"result"]isEqualToString:@"no"]) {
                [SVProgressHUD showInfoWithStatus:@"账户不存在"];
        }else {
             if ([dic[@"result"]isEqualToString:@"abnormal_message"]) {
                [SVProgressHUD showInfoWithStatus:@"异常讯息"];
                 
                    }
                }
            }
        }
    } failure:^(NSError * error) {
        
    }];
}

//  键盘弹起
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}

@end
