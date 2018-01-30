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
#import "OrdeHeadViewCell.h"
#import "OrdeTailViewCell.h"
@interface ZP_OrderController ()<FSPageContentViewDelegate,FSSegmentTitleViewDelegate> {
    int _i;
    NSArray * dataArray;
}
@property (nonatomic, strong)UIButton * btn;
@property (nonatomic, strong)UIView * views;
@property (nonatomic, strong)UIView * topView;
@property (nonatomic, strong)UIScrollView * lastView;
@property (nonatomic, strong)UILabel * line;
@property (nonatomic, strong)UITableView * tableview;

@property (nonatomic, strong) FSPageContentView * pageContentView;

@property (nonatomic, strong) NSMutableArray * newsData;
//@property (nonatomic, strong) NSMutableArray * OrderArray;
//@property (nonatomic, strong) NSMutableArray * OrderArray2;
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
    [self addRefresh];
    //数据都写在这个页面·刷新什么的都在这个页面写·


}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self addRefresh];
    if (DD_HASLOGIN ) {
        [self getDataWithState];
    }
}

// 刷新
- (void)addRefresh {
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.newsData removeAllObjects];
        _i = _newsData;
        [self getDataWithState];
    }];

//    [self.tableview.mj_header beginRefreshing];
//    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//         [self.newsData removeAllObjects];
//        _i+=10;
//        [self getDataWithState];
//    }];
}

// UI
-(void)addUI {
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width , ZP_height - NavBarHeight - 85)];
    self.tableview.backgroundColor = ZP_Graybackground;
    [self.tableview registerClass:[OrderViewCell class] forCellReuseIdentifier:@"orderViewCell"];
    [self.tableview registerClass:[OrdeHeadViewCell class] forCellReuseIdentifier:@"OrdeHeadViewCell"];
    [self.tableview registerClass:[OrdeTailViewCell class] forCellReuseIdentifier:@"OrdeTailViewCell"];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏tableview多余的线条
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
    dic[@"page"] = @"1";
    dic[@"pagesize"] = @"30";
    [ZP_OrderTool requestGetorders:dic success:^(id json) {
        if ([json[@"result"]isEqualToString:@"token_not_exist"]) {
            Token = nil;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"symbol"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"countrycode"];
            ZPICUEToken = nil;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"icuetoken"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"state"];
            [[NSUserDefaults standardUserDefaults]synchronize];
#pragma make -- 提示框
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"您的账号已在其他地方登陆,您已被迫下线,如果非本人登录请尽快修改密码",nil) preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                ZPLog(@"取消");
            }];
            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"確定",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
               
                [self.navigationController popToRootViewControllerAnimated:NO];
                //跳转
                if ([[[UIApplication sharedApplication] keyWindow].rootViewController isKindOfClass:[UITabBarController class]]) {
                    UITabBarController * tbvc = [[UIApplication sharedApplication] keyWindow].rootViewController;
                    [tbvc setSelectedIndex:0];
                }
            }];
            [alert addAction:defaultAction];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
/*****************************/
        if (json) {
//            self.newsData = json;  //这个是刷新
            [self successful];
        }else{
            [self networkProblems];
        }
        self.newsData = [OrderModel arrayWithArray:json[@"datalist"]];
        ZPLog(@"%@",json);
        ZPLog(@"%@",json[@"datalist"]);
//         小红点数据
// 订单协议（此方法只是为了加载导航栏上的数字）
        if (i == 0) {
            [self getDataWithState:1];
            [self getDataWithState:2];
            [self getDataWithState:3];
            [self getDataWithState:4];
        }
        NSNumber * datacount =json[@"datacount"];
        if ([datacount intValue] > 0) {
            but.badgeValue = [NSString stringWithFormat:@"%@",datacount];
            but.badgeBGColor = [UIColor orangeColor];
        }else {
            but.badgeValue = nil;
            but.badgeBGColor = [UIColor whiteColor];
        }
/********************/
    [self.tableview.mj_header endRefreshing];  // 結束刷新
    [self.tableview reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self loading];
    }];
}

/**********************/
// 订单协议（此方法只是为了加载导航栏上的个数）
- (void)getDataWithState:(NSInteger )i {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    switch (i) {
        case 1:
            dic[@"sta"] = @"1";
            break;
        case 2:
            dic[@"sta"] = @"2";
            break;
        case 3:
            dic[@"sta"] = @"3";
            break;
        case 4:
            dic[@"sta"] = @"4";
            break;
        default:
            break;
    }
    UIButton * but = [self.titleView viewWithTag:666 + i];
    NSLog(@"but = %@",but.titleLabel.text);
/**********************/
    dic[@"days"] = @"365";
    dic[@"token"] = Token;
    dic[@"orderno"] = @"";
    dic[@"page"] = @"1";
    dic[@"pagesize"] = @"30";
    [ZP_OrderTool requestGetorders:dic success:^(id json) {
        NSNumber * datacount = json[@"datacount"];
        if ([datacount intValue] > 0) {
            but.badgeValue = [NSString stringWithFormat:@"%@",datacount];
            but.badgeBGColor = [UIColor orangeColor];
        }else {
            but.badgeValue = nil;
            but.badgeBGColor = [UIColor whiteColor];
        }
        [self.tableview reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self loading];
    }];
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
                [self getDataWithState];
                [self.newsData removeObjectAtIndex:sender.tag];
                [SVProgressHUD showSuccessWithStatus:@"刪除成功"];
            }else
                if ([obj[@"result"]isEqualToString:@"time_error"]) {
                    [SVProgressHUD showInfoWithStatus:@"交易完成的訂單需要15天後才能刪除"];
            }else
                if ([obj[@"result"]isEqualToString:@"orders_state_error"]) {
                    [SVProgressHUD showInfoWithStatus:@"此状态下暂不能删除"];
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
    return self.newsData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        OrdeHeadViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OrdeHeadViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        OrderModel * model = self.newsData[indexPath.section];
        OrdersdetailModel * model2;
        model2 = [OrdersdetailModel CreateWithDict:model.ordersdetail.firstObject];
        cell.DeleteBut.tag = indexPath.section;
        [cell.DeleteBut addTarget:self action:@selector(DeleteOrderBut:) forControlEvents:UIControlEventTouchUpInside];
        [cell InformationWithDic:model2 WithModel:model];
        return cell;
    }else
        if(indexPath.row == 1) {
           static NSString * ID = @"orderViewCell";
           OrderModel * model = self.newsData[indexPath.section];
           OrderViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
           self.tableview.tableFooterView = [[UIView alloc]init];
           OrdersdetailModel * model2;
           model2 = [OrdersdetailModel CreateWithDict:model.ordersdetail.firstObject];
           [cell InformationWithDic:model2 WithModel:model];
//         [cell InformationWithDic:nil WithModel:model];
           return cell;
    }else {
        OrdeTailViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OrdeTailViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        OrderModel * model = self.newsData[indexPath.section];
        cell.AppraiseBut.tag = indexPath.row;
        cell.OnceagainBut.tag = indexPath.row;
        OrdersdetailModel * model2;
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
//   申请退款
        cell.appraiseBlock = ^(RequestRefundController* response) {
            [self.navigationController pushViewController:response animated:YES];
        };
        
//   退换货
        cell.appraiseBlock = ^(ExchangeDetailsController* response) {
            [self.navigationController pushViewController:response animated:YES];
        };
        
//   查看详细 -- 再次购买
        cell.onceagainBlock = ^(id response) {
            [self.navigationController pushViewController:response animated:YES];
        };
//     確認收貨
        cell.appraiseBlock = ^(AppraiseController* responses) {
            [self.navigationController pushViewController:responses animated:YES];
        };
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 40;
    }else
        if (indexPath.row == 1){
           return 110;
    }else {
           return 70;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

// 重新加载数据
-(void)loading {
    //    [ZPProgressHUD showErrorWithStatus:connectFailed toViewController:self];
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
    //    [ZPProgressHUD showErrorWithStatus:connectFailed toViewController:self];
    [ReloadView showToView:self.view touch:^{
        [weakSelf getDataWithState];
    }];
    return;
}

@end

