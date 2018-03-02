//
//  AddressViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/22.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "AddressViewController.h"
#import "AddressTableViewCell.h"
#import "AddAddressViewController.h"
#import "EditViewController.h"
#import "PrefixHeader.pch"
#import "ZP_MyTool.h"
@interface AddressViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UIButton * chooseCityBtn;
@property (nonatomic, strong)NSMutableArray * newsData;
@property (nonatomic, strong) NoDataView * NoDataView;
@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = MyLocal(@"goods address");
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    [self.tableView registerNib:[UINib nibWithNibName:@"AddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"AddressTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏tableview多余的线条
//    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithTitle:MyLocal(@"new address")  style:UIBarButtonItemStylePlain target:self action:@selector(addAddress)];
//    self.navigationItem.rightBarButtonItem = item;
//    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    //    self.chooseCityBtn.frame = CGRectMake(0, 0, 35.0f, 25.0f);
    self.chooseCityBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.chooseCityBtn.titleLabel.font = ZP_addBtnTextdetaFont;
    [self.chooseCityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.chooseCityBtn setNeedsLayout];
    [self.chooseCityBtn setTitle:MyLocal(@"new address") forState:UIControlStateNormal];
    self.chooseCityBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.chooseCityBtn addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc]initWithCustomView:self.chooseCityBtn]];
    [NoDataView initWithSuperView:self.view Content:nil FinishBlock:^(id response) {
        self.NoDataView = response;
        [self.tableView reloadData];
    }];
}
//  生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self allData];
    //    [self DeletingClick:];
    [_tableView reloadData]; // 刷新数据
}

- (void)addAddress {
    AddAddressViewController * viewController = [[AddAddressViewController alloc] init];
    viewController.contentDic = @{@"asd":@(YES)};
    [self.navigationController pushViewController:viewController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

// 获取地址数据
- (void)allData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    dic[@"aid"] = _oid;
    [ZP_MyTool requesAddress:dic success:^(id obj) {
        NSArray * arr = obj;
        self.newsData = [ZP_FrontPageReceivingAddressModel arrayWithArray:arr];
        [self.tableView reloadData];
    } failure:^(NSError * error) {
        //        ZPLog(@"%@",error);
        [SVProgressHUD showInfoWithStatus:MyLocal(@"Server link failed")];
    }];
}

#pragma mark ---tableView delegate
//3.设置cell之间headerview的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

//4.设置headerview的颜色
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.newsData.count > 0) {
        self.tableView.hidden = NO;
        self.NoDataView.hidden = YES;
        return self.newsData.count;
    }else {
        if (self.NoDataView) {
            self.tableView.hidden = YES;
            self.NoDataView.hidden = NO;
        }
        return 0;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AddressTableViewCell" forIndexPath:indexPath];
    ZP_FrontPageReceivingAddressModel * model = self.newsData[indexPath.section];
    //    默认地址
    cell.defBtn.tag = indexPath.section;
    [cell.defBtn addTarget:self action:@selector(seleClick:) forControlEvents:UIControlEventTouchUpInside];
    //    删除
    cell.DeletingBut.tag = indexPath.section;
    [cell.DeletingBut addTarget:self action:@selector(DeletingClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell cellWithdic:model];
    cell.finishBlock = ^(id response) {//在这里传点击编辑的数据
        EditViewController * viewController = [[EditViewController alloc] init];
        viewController.model = model;
        [self.navigationController pushViewController:viewController animated:YES];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZP_FrontPageReceivingAddressModel * model = self.newsData[indexPath.section];
    if (self.popBlock) {
        self.popBlock(model);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 138;
}

//默认地址
- (void)seleClick:(UIButton *)btn {
    if (!btn.selected) {
        btn.selected = !btn.selected;
        if (btn.selected) {
            ZP_FrontPageReceivingAddressModel * model = self.newsData[btn.tag];
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            dic[@"token"] = Token;
            dic[@"adsid"] = model.addressid;
            [ZP_MyTool requestDefaultAddress:dic success:^(id obj) {
                ZPLog(@"%@",obj);
                if ([obj[@"result"] isEqualToString:@"ok"]) {
                    for (NSInteger i = 0; i < _newsData.count; i++) {
                        ZP_FrontPageReceivingAddressModel *model = _newsData[i];
                        NSLog(@"%@",model);
                        if (btn.tag == i) {
                            model.isdefault = @(YES);
                        }else {
                            model.isdefault = @(NO);
                        }
                        [self.tableView reloadData];
                    }
                    [SVProgressHUD showSuccessWithStatus:MyLocal(@"Set success")];
                }else {
                    ZPLog(@"失败");
                }
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
                    UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Prompt", nil) message:NSLocalizedString(@"Your account has been logged in other places, you have been forced to go offline, please change the password as soon as possible if you are not logged in.",nil) preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                        ZPLog(@"取消");
                    }];
                    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Determine",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
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
            } failure:^(NSError *errpr) {
            }];
            for (int i = 0; i < self.newsData.count; i ++) {
                AddressTableViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                if (i == btn.tag) {
                    
                }else{
                    cell.defBtn.selected = NO;}
            }
        }
    }
    
}

// 删除按钮

- (void)DeletingClick:(UIButton *)sender {
#pragma make -- 提示框
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:MyLocal(@"reminding") message:MyLocal(@"Are you sure you want delete it?") preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:MyLocal(@"cancel") style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        ZPLog(@"取消");
    }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:MyLocal(@"ok") style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        ZP_FrontPageReceivingAddressModel * model = self.newsData[sender.tag];
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        dic[@"token"] = Token;
        dic[@"adsid"] = model.addressid;
        [ZP_MyTool requesDeleteAddress:dic success:^(id obj) {
            if ([obj[@"result"]isEqualToString:@"ok"]) {
                [SVProgressHUD showSuccessWithStatus:MyLocal(@"Delete success")];
                [self allData]; //刷新表格里面的数据
            }else {
                if ([obj[@"result"]isEqualToString:@"isdefault_err"]) {
                    [SVProgressHUD showInfoWithStatus:MyLocal(@"default address cannot be deleted.")];
                }else {
                    if ([obj[@"result"]isEqualToString:@"failure"]) {
                        [SVProgressHUD showInfoWithStatus:MyLocal(@"operation failure")];
                    }
                }
            }
            ZPLog(@"%@",obj);
        } failure:^(NSError * error) {
            //            ZPLog(@"%@",error);
            [SVProgressHUD showInfoWithStatus:MyLocal(@"Server link failed")];
        }];
    }];
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end

