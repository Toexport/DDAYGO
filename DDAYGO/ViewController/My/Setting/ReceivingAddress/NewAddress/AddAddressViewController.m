//
//  AddAddressViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/22.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "AddAddressViewController.h"
#import "PrefixHeader.pch"
#import "ZP_MyTool.h"
@interface AddAddressViewController ()
@property (strong, nonatomic) IBOutlet UIButton * acquiescence;

@end

@implementation AddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self countrycode];
    self.ContactnumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.ZipcodeaddressTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.ContactnumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
    self.ContactpersonTextField.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
    self.ReceivingaddressTextField.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
    self.ZipcodeaddressTextField.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(adjustStatusBar:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

- (void)setContentDic:(NSDictionary *)contentDic {
    if (contentDic) {
        self.title = MyLocal(@"new address");
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithTitle:MyLocal(@"save") style:UIBarButtonItemStylePlain target:self action:@selector(saveAddress)];
        self.navigationItem.rightBarButtonItem = item;
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
        self.AddAddressScrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滚动时键盘隐藏
        
    }
}

// 国别
- (void)countrycode {
    self.regionLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"countrycode"];
    switch ([[[NSUserDefaults standardUserDefaults] objectForKey:@"countrycode"] integerValue]) {
        case 886:
            self.regionLabel.text = MyLocal(@"Taiwan");
            break;
            
        case 86:
            self.regionLabel.text = MyLocal(@"China");
            break;
            
        case 852:
            self.regionLabel.text = MyLocal(@"HongKong");
            break;
        default:
            break;
    }
}

//  保存按钮
- (void)saveAddress {
    [self allData];
    
}

//  数据
- (void)allData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"adsid"] = @"0";
    dic[@"name"] = self.ContactpersonTextField.text;
    dic[@"phone"] = self.ContactnumberTextField.text;
    dic[@"cell"] = @"";
    dic[@"email"] = @"";
    dic[@"zipcode"] = self.ZipcodeaddressTextField.text;
    dic[@"address"] = self.ReceivingaddressTextField.text;
    dic[@"isdefault"] = [NSNumber numberWithBool: _acquiescence.selected];
    dic[@"token"] = Token;
    ZPLog(@"%@",dic);
    
    [ZP_MyTool requesnewAaddress:dic success:^(id obj) {
        NSDictionary * dic = obj;
        ZPLog(@"%@",obj);
        if ([dic[@"result"] isEqualToString:@"ok"]) {
            ZPLog(@"加入成功");
            [SVProgressHUD showSuccessWithStatus:MyLocal(@"Add success")];
            [self.navigationController popViewControllerAnimated:YES];
        }else
            if ([dic[@"result"] isEqualToString:@"add_up_to_ten"]) {
                [SVProgressHUD showInfoWithStatus:MyLocal(@"Add failure, and you can only add up to 10 data.")];
            }else
                    if ([dic[@"result"] isEqualToString:@"name_err"]) {
                        [SVProgressHUD showInfoWithStatus:MyLocal(@"name cannot be empty.")];
                    }else
                        if ([dic[@"result"] isEqualToString:@"phone_err"]) {
                            [SVProgressHUD showInfoWithStatus:MyLocal(@"phone number cannot be empty.")];
                        }else
                            if ([dic[@"result"] isEqualToString:@"address_err"]) {
                                [SVProgressHUD showInfoWithStatus:MyLocal(@"address cannot be empty.")];
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
                                    UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"reminding", nil) message:NSLocalizedString(@"account exists",nil) preferredStyle:UIAlertControllerStyleAlert];
                                    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:MyLocal(@"cancel",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                        ZPLog(@"取消");
                                    }];
                                    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"ok",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
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

// 设置默认地址
- (IBAction)acquiescence:(UIButton *)sender {
    
    sender.selected = !sender.selected;
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



