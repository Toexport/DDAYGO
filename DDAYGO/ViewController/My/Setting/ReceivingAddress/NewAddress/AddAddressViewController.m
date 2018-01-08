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
    _ContactnumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    _ZipcodeaddressTextField.keyboardType = UIKeyboardTypeNumberPad;
}

- (void)setContentDic:(NSDictionary *)contentDic {
    if (contentDic) {
        self.title = NSLocalizedString(@"新增地址", nil);
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAddress)];
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
            _regionLabel.text = @"臺灣";
            break;
            
        case 86:
            _regionLabel.text = @"中国";
            break;
            
        case 852:
            _regionLabel.text = @"香港";
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
    dic[@"name"] = _ContactpersonTextField.text;
    dic[@"phone"] = _ContactnumberTextField.text;
    dic[@"cell"] = @"";
    dic[@"email"] = @"";
    dic[@"zipcode"] = _ZipcodeaddressTextField.text;
    dic[@"address"] = _ReceivingaddressTextField.text;
    dic[@"isdefault"] = [NSNumber numberWithBool: _acquiescence.selected];
    dic[@"token"] = Token;
    ZPLog(@"%@",dic);
    
    [ZP_MyTool requesnewAaddress:dic success:^(id obj) {
        NSDictionary * dic = obj;
        
        ZPLog(@"%@",obj);
        if ([dic[@"result"] isEqualToString:@"ok"]) {
            ZPLog(@"加入成功");
            [SVProgressHUD showSuccessWithStatus:@"添加成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            if ([dic[@"result"] isEqualToString:@"add_up_to_ten"]) {
                [SVProgressHUD showInfoWithStatus:@"添加失败，最多只能添加10條數據喲"];
        }else {
            if ([dic[@"result"] isEqualToString:@"sys_err"]) {
                [SVProgressHUD showInfoWithStatus:@"服務器連接至火星"];
        }else {
            if ([dic[@"result"] isEqualToString:@"name_err"]) {
                [SVProgressHUD showInfoWithStatus:@"姓名不能為空"];
        }else {
            if ([dic[@"result"] isEqualToString:@"phone_err"]) {
                [SVProgressHUD showInfoWithStatus:@"電話號碼不能為空"];
        }else {
            if ([dic[@"result"] isEqualToString:@"address_err"]) {
                [SVProgressHUD showInfoWithStatus:@"地址不能為空"];
            }
                
            
                    }
                }
            }
        }
    }
    } failure:^(NSError * error) {
//        ZPLog(@"%@",error);
        [SVProgressHUD showInfoWithStatus:@"服務器鏈接失敗"];
    }];
}

// 设置默认地址
- (IBAction)acquiescence:(UIButton *)sender {
    
    sender.selected = !sender.selected;
}

@end



