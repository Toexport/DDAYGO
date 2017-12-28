//
//  SupplierViewController.m
//  DDAYGO
//
//  Created by Summer on 2017/12/28.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "SupplierViewController.h"
#import "SupplierTableViewCell.h"
#import "PrefixHeader.pch"
@interface SupplierViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation SupplierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    self.title = NSLocalizedString(@"供货商", nil);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_WhiteColor}];   // 更改导航栏字体颜色
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];  //  更改导航栏颜色
    [self.tableview registerNib:[UINib nibWithNibName:@"SupplierTableViewCell" bundle:nil] forCellReuseIdentifier:@"SupplierTableViewCell"];
    
}
#pragma mark --delegate
//// 表头
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView * vview = [UIView new];
//    vview.backgroundColor = ZP_Graybackground;
//    [self.view addSubview:vview];
//    [vview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(0);
//        make.right.equalTo(self).offset(0);
//        make.top.equalTo(self).offset(0);
//        make.width.mas_offset(40);
//    }];
//    return vview;
//}
//// 设置表头高度
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 40;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SupplierTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SupplierTableViewCell"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 890;
}
@end
