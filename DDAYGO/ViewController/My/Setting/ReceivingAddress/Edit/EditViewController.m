//
//  EditViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/29.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "EditViewController.h"
#import "PrefixHeader.pch"
#import "ZP_MyTool.h"
#import "ZP_FrontPageReceivingAddressModel.h"
@interface EditViewController ()
@property (strong, nonatomic) IBOutlet UIButton * acquiescence;
@property (nonatomic, strong) NSMutableArray * newsData;
@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self countrycode];
    [self allData];
    self.title = @"編輯地址";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"保存", nil)  style:UIBarButtonItemStylePlain target:self action:@selector(EditAddress)];
    self.navigationItem.rightBarButtonItem = item;
    self.ContactnumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.ZipcodeaddressTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.ContactnumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
    self.ContactpersonTextField.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
    self.ReceivingaddressTextField.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
    self.ZipcodeaddressTextField.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
    [self.navigationItem.rightBarButtonItem setTintColor:ZP_WhiteColor];
    
}

// 国别
- (void)countrycode {
    self.RegionLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"countrycode"];
    switch ([[[NSUserDefaults standardUserDefaults] objectForKey:@"countrycode"] integerValue]) {
        case 886:
            self.RegionLabel.text = @"臺灣";
            break;
            
        case 86:
            self.RegionLabel.text = @"中国";
            break;
            
        case 852:
            self.RegionLabel.text = @"香港";
            break;
            
        default:
            break;
    }
}

// 保存点击事件
- (void)EditAddress {
    [self acquiring];
    NSLog(@"保存");
}

// 保存修改后的数据
- (void)acquiring {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"adsid"] = self.model.addressid;
    dic[@"name"] = self.ContactpersonTextField.text;
    dic[@"phone"] = self.ContactnumberTextField.text;
    dic[@"cell"] = @"";
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
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else
            if ([dic[@"result"] isEqualToString:@"add_up_to_ten"]) {
                [SVProgressHUD showInfoWithStatus:@"添加失败，最多添加10條數據喲"];
            }else
                if ([dic[@"result"] isEqualToString:@"sys_err"]) {
                    [SVProgressHUD showInfoWithStatus:@"服務器連接至火星"];
                }else
                    //*************************************Token被挤掉***************************************************//
                    if ([obj[@"result"]isEqualToString:@"token_not_exist"]) {
                        Token = nil;
                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"symbol"];
                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"countrycode"];
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
                        UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"您的账号已在其他地方登陆,您已被迫下线,如果非本人登录请尽快修改密码",nil) preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                            ZPLog(@"取消");
                        }];
                        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"確定",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
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
        //        [SVProgressHUD showInfoWithStatus:@"服务器链接失败"];
    }];
}

// 获取地址数据
- (void)allData {
    [self cellWithdic:_model];
}

- (void)cellWithdic:(ZP_FrontPageReceivingAddressModel *)model {
    _ContactpersonTextField.text = model.eeceiptname;
    _ContactnumberTextField.text = model.eeceiptphone;
    _ReceivingaddressTextField.text = model.addressdetail;
    _ZipcodeaddressTextField.text = model.zipcode;
    
}
// 设置默认地址
- (IBAction)acquiescence:(UIButton *)sender {
    sender.selected = !sender.selected;
}


@end
