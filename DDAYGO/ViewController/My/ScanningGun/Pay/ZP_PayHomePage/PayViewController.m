//
//  PayViewController.m
//  DDAYGO
//
//  Created by Login on 2017/10/10.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "PayViewController.h"
#import "PayViewCell.h"
#import "PrefixHeader.pch"
#import "UINavigationBar+Awesome.h"
#import "ZP_MyTool.h"
#import "DataViewController.h"
#import "ZP_PayView.h"
@interface PayViewController () <UITableViewDelegate, UITableViewDataSource> {
    
    NSString * money;
}
@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self AllData];
    self.title = @"付款";
    self.view.backgroundColor = ZP_WhiteColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: ZP_textWite}];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"ic_bar_return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
}

- (void)backAction {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
// 數據
- (void)AllData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    dic[@"shopname"] = self.Oname;
    dic[@"shopcode"] = self.Oid;
    ZPLog(@"%@_%@",dic[@"shopname"] = self.Oname,dic[@"shopcode"] = self.Oid);
}

//  点击确认按钮需要的参数
- (void)btnClick {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    dic[@"amount"] = money; // 这个是在view上选择支付金额
    dic[@"shopcode"] = self.Oid; // 这个必须要
    dic[@"countrycode"] = @"886";
    dic[@"payway"] = @"allpay_balance";   // 这个是在view上选择支付方式
    dic[@"icuetoken"] = ZPICUEToken;
    
//    这是是在选择支付方式后点击确定后跳转的数据加OID回调
    [ZP_MyTool requesQrCodePay:dic success:^(id obj) {
        if ([obj[@"result"]isEqualToString:@"ok"]) {
            NSLog(@"obj = %@",obj);
            DataViewController * vc = [[DataViewController alloc]init];
            vc.jump_URL = obj[@"para"];
            vc.jump_HeadURL = obj[@"uri"];
            vc.Oid = obj[@"oid"];
            [self.navigationController pushViewController:vc animated:YES];
        }else
            if ([obj[@"result"]isEqualToString:@"country_err"]) {
                [SVProgressHUD showInfoWithStatus:@"國家不匹配"];
        }else
            if ([obj[@"result"]isEqualToString:@"国家不匹配"]) {
                [SVProgressHUD showInfoWithStatus:@"支付方式錯誤"];
        }else
            if ([obj[@"result"]isEqualToString:@"icuetoken_err"]) {
                [SVProgressHUD showInfoWithStatus:@"ICUE身份錯誤"];
        }else
            if ([obj[@"result"]isEqualToString:@"shopcode_err"]) {
                [SVProgressHUD showInfoWithStatus:@"二維碼錯誤，錯誤的商家ID"];
        }else
            if ([obj[@"result"]isEqualToString:@"qrpay_state_err"]) {
                [SVProgressHUD showInfoWithStatus:@"商家已關閉掃碼支付"];
        }else
            if ([obj[@"result"]isEqualToString:@"qrpay_state_err"]) {
                [SVProgressHUD showInfoWithStatus:@"付款金額必須大於0"];
        }else
            if ([obj[@"result"]isEqualToString:@"addorder_err"]) {
                [SVProgressHUD showInfoWithStatus:@"訂單生成失敗"];
                
        }
    } failure:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
}
// UI
- (void)initUI {
    [self.tableView registerNib:[UINib nibWithNibName:@"PayViewCell" bundle:nil] forCellReuseIdentifier:@"PayViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = ZP_WhiteColor;
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor orangeColor]];
}

#pragma mark - tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PayViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PayViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果
    [cell initWithName:self.Oname NameId:_Oid];
    cell.PayBlock = ^(NSString * text) {
        money = text;
        [self btnClick];
       
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 350;
}

@end
