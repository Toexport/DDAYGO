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
     [self allData];
    self.title = @"編輯地址";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"保存", nil)  style:UIBarButtonItemStylePlain target:self action:@selector(EditAddress)];
    self.navigationItem.rightBarButtonItem = item;
    self.ContactnumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.ZipcodeaddressTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
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
    dic[@"name"] = _ContactpersonTextField.text;
    dic[@"phone"] = _ContactnumberTextField.text;
    dic[@"cell"] = @"";
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
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            if ([dic[@"result"] isEqualToString:@"add_up_to_ten"]) {
                [SVProgressHUD showInfoWithStatus:@"添加失败，最多添加10條數據喲"];
            }else {
                if ([dic[@"result"] isEqualToString:@"sys_err"]) {
                    [SVProgressHUD showInfoWithStatus:@"服務器連接至火星"];
                }
            }
        }
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
