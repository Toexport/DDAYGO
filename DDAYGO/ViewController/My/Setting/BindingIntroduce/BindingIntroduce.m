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
    self.title = NSLocalizedString(@"綁定推薦人", nil);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    self.BindingIntroduceTextField.keyboardType = UIKeyboardTypeASCIICapable;
     self.BindingIntroduceTextField.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
    self.BindingIntroducscrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滚动时键盘隐藏
    
}

// 绑定推荐人
- (IBAction)BindingIntroduceTextField:(id)sender {
    [self allData];
//    [[PromptBox getInstance] showDialogBoxWithOperation:DDABuildingICUC FinishBlock:nil];
}
- (void)allData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"acc"] = self.BindingIntroduceTextField.text;
    dic[@"token"] = Token;
    [ZP_MyTool requesIntroduce:dic success:^(id obj) {
        NSDictionary * dic = obj;
        if ([dic[@"result"]isEqualToString:@"ok"]) {
            [SVProgressHUD showSuccessWithStatus:@"綁定成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else
            if ([dic[@"result"]isEqualToString:@"failure"]) {
                [SVProgressHUD showInfoWithStatus:@"綁定失敗"];
        }else
            if ([dic[@"result"]isEqualToString:@"no"]) {
                [SVProgressHUD showInfoWithStatus:@"賬戶不存在"];
        }else
             if ([dic[@"result"]isEqualToString:@"abnormal_message"]) {
                [SVProgressHUD showInfoWithStatus:@"異常訊息"];
                 
        }
    } failure:^(NSError * error) {
        
    }];
}

@end
