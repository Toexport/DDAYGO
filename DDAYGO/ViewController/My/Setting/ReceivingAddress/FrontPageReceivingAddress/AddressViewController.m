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

@property (nonatomic, strong)NSMutableArray * newsData;
@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"收貨地址", nil);
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    [self.tableView registerNib:[UINib nibWithNibName:@"AddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"AddressTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏tableview多余的线条
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"新增地址", nil)  style:UIBarButtonItemStylePlain target:self action:@selector(addAddress)];
    self.navigationItem.rightBarButtonItem = item;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
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
        [SVProgressHUD showInfoWithStatus:@"服務器鏈接失敗"];
    }];
}

#pragma mark ---tableView delegate
////3.设置cell之间headerview的高度
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 10;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

//4.设置headerview的颜色
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AddressTableViewCell" forIndexPath:indexPath];
    ZP_FrontPageReceivingAddressModel * model = self.newsData[indexPath.row];
//    默认地址
        cell.defBtn.tag = indexPath.row;
        [cell.defBtn addTarget:self action:@selector(seleClick:) forControlEvents:UIControlEventTouchUpInside];
//    删除
        cell.DeletingBut.tag = indexPath.row;
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
    ZP_FrontPageReceivingAddressModel * model = self.newsData[indexPath.row];
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
                [SVProgressHUD showSuccessWithStatus:@"設置成功"];
                
                }else {
                    
                ZPLog(@"失败");
                }
                
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
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"確定要刪除嗎？",nil) preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        ZPLog(@"取消");
         }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"確定",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
         ZP_FrontPageReceivingAddressModel * model = self.newsData[sender.tag];
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        dic[@"token"] = Token;
        dic[@"adsid"] = model.addressid;
        [ZP_MyTool requesDeleteAddress:dic success:^(id obj) {
            if ([obj[@"result"]isEqualToString:@"ok"]) {
                [SVProgressHUD showSuccessWithStatus:@"刪除成功"];
                [self allData]; //刷新表格里面的数据
            }else {
                if ([obj[@"result"]isEqualToString:@"isdefault_err"]) {
                    [SVProgressHUD showInfoWithStatus:@"默認地址不能刪除"];
            }else {
                if ([obj[@"result"]isEqualToString:@"failure"]) {
                    [SVProgressHUD showInfoWithStatus:@"操作失敗"];
                }
            }
        }
        ZPLog(@"%@",obj);
    } failure:^(NSError * error) {
//            ZPLog(@"%@",error);
        [SVProgressHUD showInfoWithStatus:@"服務器鏈接失敗"];
        }];
    }];
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end

