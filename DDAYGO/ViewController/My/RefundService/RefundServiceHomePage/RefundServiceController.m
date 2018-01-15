//
//  RefundServiceController.m
//  DDAYGO
//
//  Created by Summer on 2018/1/10.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import "RefundServiceController.h"
#import "RequestRefundController.h"
#import "PrefixHeader.pch"
#import "ExchangeDetailsController.h"
#import "ZP_MyTool.h"
#import "RefundServiceModel.h"
#import "RefundServiceCell.h"
@interface RefundServiceController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray * _dataarray;
}
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
    self.tableview.separatorStyle = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_WhiteColor}];   // 更改导航栏字体颜色
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];  //  更改导航栏颜色
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏tableview多余的线条
//    [self.tableview registerNib:[UINib nibWithNibName:@"RefundServiceHeader" bundle:nil] forCellReuseIdentifier:@"RefundServiceHeader"];
    [self.tableview registerNib:[UINib nibWithNibName:@"RefundServiceCell" bundle:nil] forCellReuseIdentifier:@"RefundServiceCell"];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    /** 判断是否是 ios11 */
    if (@available(iOS 11.0, *)){
        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);//导航栏如果使用系统原生半透明的，top设置为64
        self.tableview.scrollIndicatorInsets = self.tableview.contentInset;
    }
}


// 生命周期

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self AllData];
}

// 70) 获取退换货记录列表
- (void)AllData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    dic[@"page"] = @"1";
    dic[@"pagesize"] = @"10";
    [ZP_MyTool requestGetrefundlist:dic success:^(id obj) {
        ZPLog(@"%@",obj);
        _dataarray = [RefundServiceModel mj_objectArrayWithKeyValuesArray:obj[@"datalist"]];
        [self.tableview reloadData];
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
    }];
}

#pragma 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataarray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 195;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RefundServiceModel *model = _dataarray[indexPath.row];
    //数据
    NSLog(@"%@ -- %ld",model.createtime,_dataarray.count);
    RefundServiceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RefundServiceCell"];
    cell.shopnameLabel.text = model.shopname ;
    cell.StateLabel.text = model.statestr;
    cell.ItemLabel.text = model.createtime;
    cell.TitleLabel.text = model.productname;
    [cell.MaimImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.0.117:7000%@", model.defaultimg]] placeholderImage:[UIImage imageNamed:@""]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果、
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RefundServiceModel * model = _dataarray[indexPath.row];
    ExchangeDetailsController * ExchangeDatails = [[ExchangeDetailsController alloc]init];
    ExchangeDatails.Oid = model.refundid;
    [self.navigationController pushViewController:ExchangeDatails animated:YES];
    ZPLog(@"%ld",indexPath.row);
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
        return CGFLOAT_MIN;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//        return CGFLOAT_MIN;
    return 10.0f;

}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, 10)];
    return v;
}

@end
