//
//  LogistcsController.m
//  DDAYGO
//
//  Created by Login on 2017/9/22.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "LogistcsController.h"
#import "PrefixHeader.pch"
#import "LogistcsCell.h"
@interface LogistcsController () {
    
    NSArray * dataArray;
}
@property (nonatomic, strong) UITableView * tableview;

@end

@implementation LogistcsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Logistics details", nil);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    [self initUI];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(adjustStatusBar:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

- (void)initUI {
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, ZP_Width , ZP_height)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏tableview多余的线条
    dataArray = @[@{@"State":@"配送中",@"Quantity":@"99件商品",@"Company":@"顺丰快递",@"IDnumber":@"02186318681783"}];
    [self.tableview registerClass:[LogistcsCell class] forCellReuseIdentifier:@"logistcsCell"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = ZP_Graybackground;
    [self.view addSubview:self.tableview];
}

#pragma mark - <TableviewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { //tableview个数
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * LogistcsID = @"logistcsCell";
    LogistcsCell * cell = [tableView dequeueReusableCellWithIdentifier:LogistcsID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果
    NSDictionary * dic = dataArray[indexPath.row];
    [cell Logistce:dic];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

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
