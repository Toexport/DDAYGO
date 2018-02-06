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
@end

@implementation ShopIntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self shopintroduction];
    self.title = NSLocalizedString(@"Shop introduced", nil);
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    [self initUI];
//    _dataArray = @[@{@"Storename":@"金太阳国际",@"Address":@"台湾高雄市",@"Phone":@"+86 15118041624",@"rating":@"100%",@"Servicetime":@"星期一 - 星期六 AM10:00 - FM09:00",@"BusinessregistrationID":@"12706283MFZS1120996"}];
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
    self.tableview.tableFooterView = [[UIView alloc]init];
    if (_introductionDic.count>0 && _reviewgoodDic.count>0) {
        [cell ShoplntroducedCollection:_introductionDic andDic:_reviewgoodDic];
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
