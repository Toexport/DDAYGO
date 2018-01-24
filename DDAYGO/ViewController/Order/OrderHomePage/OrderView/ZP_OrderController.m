//
//  ZP_OrderController.m
//  DDAYGO
//
//  Created by Summer on 2017/11/24.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_OrderController.h"
#import "PrefixHeader.pch"
#import "UIColor+Extension.h"
#import "UIView+Extension.h"
#import "UIFont+Extension.h"
#import "ZPSearchBarBUtton.h"
#import "UIImage+Extension.h"
#import "SearchGooodsController.h"
#import "OrderViewCell.h"
#import "ZP_OrderTool.h"
#import "ZP_OrderModel.h"
#import "FSScrollContentView.h"
#import "ConfirmViewController.h"
#import "AppraiseController.h"
#import "RequestRefundController.h"
#import "RequestReplaceController.h"
#import "UIButton+Badge.h"
#import "ExchangeDetailsController.h"
@interface ZP_OrderController ()<FSPageContentViewDelegate,FSSegmentTitleViewDelegate> {
    int _i;
    NSArray * dataArray;
//    NSArray * _ModeldataArray;
}
@property (nonatomic, strong)UIButton * btn;
@property (nonatomic, strong)UIView * views;
@property (nonatomic, strong)UIView * topView;
@property (nonatomic, strong)UIScrollView * lastView;
@property (nonatomic, strong)UILabel * line;
@property (nonatomic, strong)UITableView * tableview;
//@property (nonatomic,strong)NSMutableArray *arrData;

@property (nonatomic, strong) FSPageContentView * pageContentView;

@property (nonatomic, strong) NSMutableArray * newsData;
@end

@implementation ZP_OrderController

-(UILabel *)line {
    if (!_line) {
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 34, ZP_Width / 5, 2)];
        line.backgroundColor = [UIColor colorWithHexString:@"#e74940"];
        [self.topView addSubview:line];
        _line = line;
    }
    return _line;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addUI];
    //数据都写在这个页面·刷新什么的都在这个页面写·
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self addRefresh];
    
//    NSLog(@"%@",self.view.superview);
//     self.titleView = [self.view.superview viewWithTag:66];
    if (DD_HASLOGIN ) {
        [self getDataWithState];
    }
}
// 刷新
- (void)addRefresh {
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.newsData removeAllObjects];
        _i = 0;
        [self getDataWithState];
    }];
}

// UI
-(void)addUI {
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width , ZP_height - NavBarHeight - 85)];
    self.tableview.backgroundColor = ZP_Graybackground;
    [self.tableview registerClass:[OrderViewCell class] forCellReuseIdentifier:@"orderViewCell"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = ZP_Graybackground;
    self.tableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.tableview];
}

// 订单协议
- (void)getDataWithState {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    NSInteger i;
    if ([_titleStr isEqualToString:NSLocalizedString(@"all", nil)]) {
        dic[@"sta"] = @"-1";
        i = 0;
    }
    if ([_titleStr isEqualToString:NSLocalizedString(@"Waiting payment", nil)]) {
        dic[@"sta"] = @"1";
        i = 1;
    }
    if ([_titleStr isEqualToString:NSLocalizedString(@"Wait delivery", nil)]) {
        dic[@"sta"] = @"2";
        i = 2;
    }
    if ([_titleStr isEqualToString:NSLocalizedString(@"Waiting goods", nil)]) {
        dic[@"sta"] = @"3";
        i = 3;
    }
    if ([_titleStr isEqualToString:NSLocalizedString(@"evaluation", nil)]) {
        dic[@"sta"] = @"4";
        i = 4;
    }
    UIButton * but = [self.titleView viewWithTag:666 + i];
    NSLog(@"but = %@",but.titleLabel.text);
    dic[@"days"] = @"365";
    dic[@"token"] = Token;
    dic[@"orderno"] = @"";
    [ZPProgressHUD showWithStatus:loading maskType:ZPProgressHUDMaskTypeNone];
    [ZP_OrderTool requestGetorders:dic success:^(id json) {
        ZPLog(@"%@",json);
        if (json) {
            self.newsData = json;
            [self successful];
        }else{
            [self networkProblems];
        }
        if ([json isKindOfClass:[NSDictionary class]]) {
            return ;
        }
        self.newsData = [OrderModel arrayWithArray:json];
//         小红点数据
        if (self.newsData.count > 0) {
            but.badgeValue = [NSString stringWithFormat:@"%ld",self.newsData.count];
            but.badgeBGColor = [UIColor orangeColor];
        }else{
            but.badgeValue = nil;
            but.badgeBGColor = [UIColor whiteColor];
        }
        [self.tableview.mj_header endRefreshing];  // 結束刷新
        
//    [self.tableview reloadData];
    } failure:^(NSError *error) {
//        [self.tableview.mj_header endRefreshing];  // 結束刷新
        NSLog(@"%@",error);
        [self loading];
    }];
}

// 重新加载数据
-(void)loading {
    [ZPProgressHUD showErrorWithStatus:connectFailed toViewController:self];
    __weak typeof(self)weakSelf = self;
    [ReloadView showToView:self.view touch:^{
        [weakSelf getDataWithState];
        [ReloadView dismissFromView:weakSelf.view];
    }];
}

-(void)successful {
    [self.tableview reloadData];
    [ZPProgressHUD dismiss];
}

-(void)networkProblems {
    __weak typeof(self)weakSelf = self;
    [ZPProgressHUD showErrorWithStatus:connectFailed toViewController:self];
    [ReloadView showToView:self.view touch:^{
        [weakSelf getDataWithState];
    }];
    return;
}

// 删除订单协议
- (void)DeleteOrderBut:(UIButton *)sender {
#pragma make -- 提示框
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"確定要刪除嗎？",nil) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        ZPLog(@"取消");
    }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"確定",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
//        响应事件
        if (self.newsData.count == 0) {
            return;
        }
        OrderModel * model = self.newsData[sender.tag];
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        dic[@"token"] = Token;
        dic[@"ordernumber"] = model.ordersnumber;
        [ZP_OrderTool requestDeleteOrder:dic success:^(id obj) {
            if ([obj[@"result"]isEqualToString:@"ok"]) {
                [self.newsData removeObjectAtIndex:sender.tag];
                [SVProgressHUD showSuccessWithStatus:@"刪除成功"];
            }else
                if ([obj[@"result"]isEqualToString:@"time_error"]) {
                    [SVProgressHUD showInfoWithStatus:@"交易完成的訂單需要15天後才能刪除"];
                }
            ZPLog(@"%@",obj);
            [self.tableview reloadData];
        } failure:^(NSError * error) {
            ZPLog(@"%@",error);
        }];
    }];
    
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma Mark - <TableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    NSLog(@"go ");
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, 10)];
      v.backgroundColor = ZP_Graybackground;
    return v;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.newsData.count;;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"orderViewCell";
    OrderModel * model = self.newsData[indexPath.section];
//    OrdersdetailModel * model2 = [OrdersdetailModel CreateWithDict:model.ordersdetail[0]];
    OrderViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.tableview.tableFooterView = [[UIView alloc]init];
    cell.AppraiseBut.tag = indexPath.row;
    
//    [cell.AppraiseBut removeTarget:self action:@selector(buttonType) forControlEvents:UIControlEventTouchUpInside];
//    [cell.OnceagainBut addTarget:self action:@selector(OnceagainBut:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.OnceagainBut.tag = indexPath.row;
    OrdersdetailModel * model2;
    cell.DeleteBut.tag = indexPath.row;
    [cell.DeleteBut addTarget:self action:@selector(DeleteOrderBut:) forControlEvents:UIControlEventTouchUpInside];
    if (![_titleStr isEqualToString:@"評價"]) {
         model2 = [OrdersdetailModel CreateWithDict:model.ordersdetail.firstObject];
        [cell InformationWithDic:model2 WithModel:model];
    }else {
    [cell InformationWithDic:nil WithModel:model];
    }
    cell.finishBlock = ^(id response) {
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:response animated:YES];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        self.hidesBottomBarWhenPushed = NO;
    };
    
//   评论
    cell.appraiseBlock = ^(AppraiseController* response) {
        NSLog(@" --- count --- %ld",model.ordersdetail.count);
        response.model = model;
        response.num = indexPath.row;
        [self.navigationController pushViewController:response animated:YES];
       
    };
    
//    申请退款
    cell.appraiseBlock = ^(RequestRefundController* response) {
        
        [self.navigationController pushViewController:response animated:YES];
    };
    
//    退换货
    cell.appraiseBlock = ^(ExchangeDetailsController* response) {
        [self.navigationController pushViewController:response animated:YES];
    };
    
    //查看详细 -- 再次购买
    cell.onceagainBlock = ^(id response) {
        //go
        [self.navigationController pushViewController:response animated:YES];
    };
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 230;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

////  再次购买
//- (void)OnceagainBut:(UIButton *)OnceagainBut {
//    NSLog(@"再次购买");
//    OrderModel * model = self.newsData[OnceagainBut.tag];
//    OrdersdetailModel * model2 = [OrdersdetailModel CreateWithDict:model.ordersdetail[0]];
//    ConfirmViewController * confirm = [[ConfirmViewController alloc]init];
//    confirm.stockidsString = [NSString stringWithFormat:@"%@_%@",model2.stockid,model2.amount];
//    confirm.noEdit = YES;
//    confirm.ordersnumber = model.ordersnumber;
//    confirm.type = 666;
//    [self.navigationController pushViewController:confirm animated:YES];
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//}


@end

