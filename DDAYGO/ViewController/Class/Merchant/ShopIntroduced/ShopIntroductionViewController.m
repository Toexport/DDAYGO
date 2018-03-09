//
//  ShopIntroductionViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/19.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ShopIntroductionViewController.h"
#import "ShoplntroductionCell.h"
#import "ShoplntroducedModel.h"
#import "ZP_ClassViewTool.h"
#import "PrefixHeader.pch"
@interface ShopIntroductionViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) NSMutableArray * NewsData;
@property (nonatomic, strong) UITableView * tableview;
@property (nonatomic, strong) ShoplntroducedModel * model;
@property (nonatomic, strong) NSDictionary * introductionDic;
@property (nonatomic, strong) NSDictionary * reviewgoodDic;
@property (nonatomic, strong) UILabel * PhoneLabel; //电话
@property (nonatomic, strong) UIImageView * phoneImage; // 電話圖標
@end

@implementation ShopIntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self shopintroduction];
    self.title = NSLocalizedString(@"Shop introduced", nil);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    [self initUI];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(adjustStatusBar:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

// UI
- (void)initUI {
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, ZP_height)style:UITableViewStylePlain];
    self.tableview.backgroundColor = ZP_Graybackground;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏tableview多余的线条
    [self.tableview registerClass:[ShoplntroductionCell class] forCellReuseIdentifier:@"Shoplntroduction"];
}

// 78) 店铺介绍
- (void)shopintroduction {
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"supplierid"] = self.SupplierID;
    [ZP_ClassViewTool requestShopintroduction:dict success:^(id obj) {
        NSDictionary * dic = obj;
        _introductionDic = dic[@"introduction"];
        _reviewgoodDic = dic[@"reviewgood"];
        //        ZPLog(@"%@",_introductionDic[@"updatetime"]);
        ZPLog(@"%@",obj);
        [self.tableview reloadData];
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
    }];
}


#pragma Makr - TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    ShoplntroducedModel * model = _NewsData[indexPath.row];
    ShoplntroductionCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Shoplntroduction"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone; // 取消Cell变灰效果
    cell.StorenameLabel.text = [NSString stringWithFormat:@"%@",self.Shoppname];
    //     1. 创建一个点击事件，点击时触发labelClick方法
    UITapGestureRecognizer * TapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOnLabel:)];
    UITapGestureRecognizer * TapGestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOnLabel:)];
    // 2. 将点击事件添加到label上
    [cell.PhoneLabel addGestureRecognizer:TapGestureRecognizer1];
    [cell.phoneimageView addGestureRecognizer:TapGestureRecognizer2];
    cell.PhoneLabel.userInteractionEnabled = YES; // 可以理解为设置label可被点击
    cell.phoneimageView.userInteractionEnabled = YES;
    self.PhoneLabel = cell.PhoneLabel;
    self.phoneImage = cell.phoneimageView;
    self.tableview.tableFooterView = [[UIView alloc]init];
    if (_introductionDic.count>0 && _reviewgoodDic.count>0) {
        [cell ShoplntroducedCollection:_introductionDic andDic:_reviewgoodDic];
    }
    return cell;
}

// 3. 在此方法中设置点击label后要触发的操作
- (void)handleTapOnLabel:(id)sender {
    NSString * ph1 = @"tel:";
    ph1 = [ph1 stringByAppendingString:self.PhoneLabel.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ph1]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

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
