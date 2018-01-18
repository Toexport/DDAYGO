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
@interface RefundServiceController ()<UITableViewDelegate, UITableViewDataSource> {
    int _i;
}
@property (nonatomic, strong) NSMutableArray * dataarray;
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
    [self.tableview registerNib:[UINib nibWithNibName:@"RefundServiceCell" bundle:nil] forCellReuseIdentifier:@"RefundServiceCell"];
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
    [self addRefresh];
    if (DD_HASLOGIN ) {
        [self AllData];
    }
}
// 刷新数据
- (void)addRefresh {
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.dataarray removeAllObjects];
        _i = 0;
        [self AllData];
    }];
}
// 70) 获取退换货记录列表
- (void)AllData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    dic[@"page"] = @"1";
    dic[@"pagesize"] = @"10";
    [ZP_MyTool requestGetrefundlist:dic success:^(id obj) {
        ZPLog(@"%@",obj);
        self.dataarray = [RefundServiceModel mj_objectArrayWithKeyValuesArray:obj[@"datalist"]];
        [self.tableview reloadData];
        [self.tableview.mj_header endRefreshing];  // 結束刷新
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
    }];
}

#pragma 代理方法
// 分行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
// 分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataarray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 195;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RefundServiceModel *model = self.dataarray[indexPath.section];
    //数据
    NSLog(@"%@ -- %ld",model.createtime,_dataarray.count);
    RefundServiceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RefundServiceCell"];
    cell.shopnameLabel.text = model.shopname ;
    cell.ItemLabel.text = model.createtime;
    cell.TitleLabel.text = model.productname;
    [cell.MaimImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImgAPI, model.defaultimg]] placeholderImage:[UIImage imageNamed:@""]];
//    cell.StateLabel.text = [model.returntype stringValue];
    int a = [model.returntype intValue];
    switch (a) {
        case 0:
            cell.StateLabel.text = @"退款";
            cell.StateImage.image = [UIImage imageNamed:@"icon_retreat_refund"];
            break;
            
        case 1:
            cell.StateLabel.text = @"退货退款";
            cell.StateImage.image = [UIImage imageNamed:@"icon_retreat_goods"];
            break;
            
        case 2:
            cell.StateLabel.text = @"换货";
            cell.StateImage.image = [UIImage imageNamed:@"icon_retreat_exchange"];
            break;
        default:
            break;
    }
//    ZPLog(@"%@%@",ImgAPI,model.defaultimg);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果、
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RefundServiceModel * model = _dataarray[indexPath.section];
    ExchangeDetailsController * ExchangeDatails = [[ExchangeDetailsController alloc]init];
    ExchangeDatails.Oid = model.refundid;
    ExchangeDatails.leeLabel = model.returntype ;
    [self.navigationController pushViewController:ExchangeDatails animated:YES];
    ZPLog(@"%ld",indexPath.row);
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return CGFLOAT_MIN;
    if (section == 0) {
        return 0;
    }else {
    return 10.0f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
    return 0.001;

}


@end
