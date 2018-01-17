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
}

- (void)initUI {
    self.title = NSLocalizedString(@"提現記錄", nil);
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
        
//        self.ExtractArr = [ZP_ExtractModel arrayWithArray:obj[@"list"]];
        self.ExtractArr = [ZP_ExtractModel mj_objectArrayWithKeyValuesArray:obj[@"list"]];
    ZPLog(@"%@",obj);
        [self.tableView reloadData];
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
//        [SVProgressHUD showInfoWithStatus:@"服務器鏈接失敗"];
    }];
}


// 取消按鈕點擊事件
- (void)CancelButt:(UIButton *)sender {
    [self Canceltakeout:sender.tag];
}

// 取消余额提现
- (void)Canceltakeout:(NSUInteger)abc {
    ZP_ExtractModel * model = self.ExtractArr[abc];
    NSMutableDictionary * dicc = [NSMutableDictionary dictionary];
    dicc[@"token"] = Token;
    dicc[@"sid"] = model.supplierid;
    [ZP_MyTool requestCanceltakeout:dicc uccess:^(id obj) {
        if ([dicc[@"result"]isEqualToString:@"ok"]) {
            [SVProgressHUD showSuccessWithStatus:@"取消成功"];
        }else
            if ([dicc[@"result"]isEqualToString:@"failed"]) {
                [SVProgressHUD showInfoWithStatus:@"取消失敗"];
            }
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
    cell.CancelBut.tag = indexPath.row;
    [cell.CancelBut addTarget:self action:@selector(CancelButt:) forControlEvents:UIControlEventTouchUpInside];
    cell.model = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 290;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.ExtractArr.count -1 == section) {
        return CGFLOAT_MIN;
    }
    return 10;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZPLog(@"%ld",(long)indexPath.item);
}
@end
