//
//  RefundServiceController.m
//  DDAYGO
//
//  Created by Summer on 2018/1/10.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import "RefundServiceController.h"
#import "RefundServiceCell.h"
#import "PrefixHeader.pch"
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
    [self.tableview registerNib:[UINib nibWithNibName:@"RefundServiceCell" bundle:nil] forCellReuseIdentifier:@"RefundServiceCell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 155;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RefundServiceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RefundServiceCell"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZPLog(@"%ld",indexPath.row);
}

@end
