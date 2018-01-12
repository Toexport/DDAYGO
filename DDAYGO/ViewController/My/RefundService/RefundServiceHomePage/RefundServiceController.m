//
//  RefundServiceController.m
//  DDAYGO
//
//  Created by Summer on 2018/1/10.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import "RefundServiceController.h"
#import "RefundServiceHeader.h"
#import "RequestRefundController.h"
#import "PrefixHeader.pch"
#import "ZP_MyTool.h"
@interface RefundServiceController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation RefundServiceController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

// UI
- (void)initUI {
    self.title = NSLocalizedString(@"退款/售后", nil);
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_WhiteColor}];   // 更改导航栏字体颜色
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];  //  更改导航栏颜色
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏tableview多余的线条
    [self.tableview registerNib:[UINib nibWithNibName:@"RefundServiceHeader" bundle:nil] forCellReuseIdentifier:@"RefundServiceHeader"];
}

// 生命周期

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self AllData];
}

// 获取退换货记录列表
- (void)AllData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    dic[@"page"] = @"1";
    dic[@"pagesize"] = @"pagesize";
    [ZP_MyTool requestGetrefundlist:dic success:^(id obj) {
        ZPLog(@"%@",obj);
        
        
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
    }];
}

#pragma 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45+155;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RefundServiceHeader * header = [tableView dequeueReusableCellWithIdentifier:@"RefundServiceHeader"];
    header.RefundServiceHeaderBlock = ^(NSInteger tag) {
        RequestRefundController * requestRefund = [[RequestRefundController alloc]init];
        [self.navigationController pushViewController:requestRefund animated:YES];
    };
      header.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果、
        return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZPLog(@"%ld",indexPath.row);
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return CGFLOAT_MIN;
        return 5.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    //    return CGFLOAT_MIN;
    NSLog(@"go ");
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, 10)];
    return v;
}
@end
