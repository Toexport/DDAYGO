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
    self.title = MyLocal(@"Edit address");
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:MyLocal(@"save")  style:UIBarButtonItemStylePlain target:self action:@selector(EditAddress)];
    self.navigationItem.rightBarButtonItem = item;
    self.ContactnumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.ZipcodeaddressTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.ContactnumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
    self.ContactpersonTextField.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
    self.ReceivingaddressTextField.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
    self.ZipcodeaddressTextField.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
    [self.navigationItem.rightBarButtonItem setTintColor:ZP_WhiteColor];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(adjustStatusBar:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

// 国别
- (void)countrycode {
    
    self.RegionLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"countrycode"];
    switch ([[[NSUserDefaults standardUserDefaults] objectForKey:@"countrycode"] integerValue]) {
        case 886:
            self.RegionLabel.text = MyLocal(@"Taiwan");
            break;
            
        case 86:
            self.RegionLabel.text = MyLocal(@"China");
            break;
            
        case 852:
            self.RegionLabel.text = MyLocal(@"HongKong");
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
            [SVProgressHUD showSuccessWithStatus:MyLocal(@"Modify success")];
            [self.navigationController popViewControllerAnimated:YES];
        }else
            if ([dic[@"result"] isEqualToString:@"add_up_to_ten"]) {
                [SVProgressHUD showInfoWithStatus:MyLocal(@"Add failure, and you can only add up to 10 data.")];
            }else
                //*************************************Token被挤掉***************************************************//
                if ([obj[@"result"]isEqualToString:@"token_not_exist"]) {
                    //        清除所有的数据
                    Token = nil;
                    DDAYGO_REMOVE_TOKEN; DDAYGO_REMOVE_SYMBOL; DDAYGO_REMOVE_COUNTRYCODE; DDAYGO_REMOVE_ICUETOKEN; DDAYGO_REMOVE_STATE; DDAYGO_REMOVE_HEADERIMAGE; DDAYGO_REMOVE_NAMELABEL; DD_ChangeStaus;
                    ZPICUEToken = nil;
                    [[SDImageCache sharedImageCache] clearDisk];
#pragma make -- 提示框
                    [self logouttt];
                }
        //****************************************************************************************//
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
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
