//
//  ZP_ExtractController.m
//  DDAYGO
//
//  Created by Summer on 2017/12/5.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_ExtractController.h"
#import "ZP_ExtractCell.h"
#import "PrefixHeader.pch"
#import "ZP_MyTool.h"
#import "ZP_ExtractModel.h"
@interface ZP_ExtractController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray * ExtractArr;
@end

@implementation ZP_ExtractController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self AllData];
          [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(adjustStatusBar:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    
}

- (void)initUI {
    self.title = NSLocalizedString(@"Withdrawals records", nil);
    [self.tableView registerNib:[UINib nibWithNibName:@"ZP_ExtractCell" bundle:nil] forCellReuseIdentifier:@"ZP_ExtractCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    /**** IOS 11 ****/
    if (@available(iOS 11.0, *)) {
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
    }
}


// 获取用户提现记录列表
- (void)AllData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;;
    dic[@"sid"] = _supplierId;
    dic[@"page"] = @"1";
    [ZP_MyTool requesWithdrawalRecord:dic uccess:^(id obj) {
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
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:MyLocal(@"Cancel",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                ZPLog(@"取消");
            }];
            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:MyLocal(@"ok",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
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
        //        self.ExtractArr = [ZP_ExtractModel arrayWithArray:obj[@"list"]];
        self.ExtractArr = [ZP_ExtractModel mj_objectArrayWithKeyValuesArray:obj[@"list"]];
        ZPLog(@"%@",obj);
        [self.tableView reloadData];
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
}

// 取消按鈕點擊事件
- (void)CancelButt:(UIButton *)sender {
#pragma make -- 提示框
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"reminding", nil) message:MyLocal(@"Are you sure you want to cancel the withdrawal?") preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:MyLocal(@"Cancel",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        ZPLog(@"取消");
    }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"ok",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [self Canceltakeout:sender.tag];
    }];
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

// 取消余额提现
- (void)Canceltakeout:(NSUInteger)abc {
    ZP_ExtractModel * model = self.ExtractArr[abc];
    NSMutableDictionary * dicc = [NSMutableDictionary dictionary];
    dicc[@"token"] = Token;
    dicc[@"sid"] = model.supplierid;
    dicc[@"takeid"] = model.takeid;
    [ZP_MyTool requestCanceltakeout:dicc uccess:^(id obj) {
        if ([obj[@"result"]isEqualToString:@"ok"]) {
            [self AllData];
            [self.tableView reloadData];
            [SVProgressHUD showSuccessWithStatus:MyLocal(@"Cancel success")];
        }else
            if ([obj[@"result"]isEqualToString:@"failed"]) {
                [SVProgressHUD showInfoWithStatus:MyLocal(@"Cancel failure")];
            }
        [self AllData];
        [self.tableView reloadData];
        ZPLog(@"%@",obj);
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
}

#pragma mark - tableview delegate


//2.对于每个section返回一个cell
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.ExtractArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

#pragma mark --- 颜色
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, 10)];
    //颜色在这里
    v.backgroundColor = ZP_Graybackground;
    return v;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZP_ExtractModel * model = self.ExtractArr[indexPath.section];
    ZP_ExtractCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ZP_ExtractCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果、
    cell.CancelBut.tag = indexPath.row;
    [cell.CancelBut addTarget:self action:@selector(CancelButt:) forControlEvents:UIControlEventTouchUpInside];
    cell.model = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 290;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.ExtractArr.count -1 == section) {
        return CGFLOAT_MIN;
    }
    return 10;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    ZPLog(@"%ld",(long)indexPath.item);
//}
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
