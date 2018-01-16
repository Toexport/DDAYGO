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

@property (nonatomic, strong) FSPageContentView * pageContentView;
@property (nonatomic, strong) FSSegmentTitleView * titleView;
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
    
//    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
////        [_ModeldataArray reverseObjectEnumerator];
//        _i+=10;
//        [self getDataWithState];
//    }];
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
    if ([_titleStr isEqualToString:NSLocalizedString(@"all", nil)]) {
        dic[@"sta"] = @"-1";
    }
    if ([_titleStr isEqualToString:NSLocalizedString(@"Waiting payment", nil)]) {
        dic[@"sta"] = @"1";
    }
    if ([_titleStr isEqualToString:NSLocalizedString(@"Wait delivery", nil)]) {
        dic[@"sta"] = @"2";
    }
    if ([_titleStr isEqualToString:NSLocalizedString(@"Waiting goods", nil)]) {
        dic[@"sta"] = @"3";
    }
    if ([_titleStr isEqualToString:NSLocalizedString(@"evaluation", nil)]) {
        dic[@"sta"] = @"4";
    }
//    if ([_titleStr isEqualToString:NSLocalizedString(@"evaluation", nil)]) {
//        dic[@"sta"] = @"5";
//    }
//    if ([_titleStr isEqualToString:NSLocalizedString(@"evaluation", nil)]) {
//        dic[@"sta"] = @"6";
//    }
//    if ([_titleStr isEqualToString:NSLocalizedString(@"evaluation", nil)]) {
//        dic[@"sta"] = @"7";
//    }
    dic[@"days"] = @"7";
    dic[@"token"] = Token;
    dic[@"orderno"] = @"";
    [ZP_OrderTool requestGetorders:dic success:^(id json) {
        ZPLog(@"%@",json);
//        if (self.newsData.count < 1) {
//            UIImageView * image = [UIImageView new];
//            image.image = [UIImage imageNamed:@"icon_fail"];
//            [self.view addSubview:image];
//            [image mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(self.view).offset(ZP_Width / 2 -25);
//                make.top.equalTo(self.view).offset(55);
//                make.width.mas_offset(50);
//                make.height.mas_equalTo(50);
//            }];
//            ZP_GeneralLabel * RemindLabel = [ZP_GeneralLabel initWithtextLabel:_RemindLabel.text textColor:ZP_textblack font:ZP_TrademarkFont textAlignment:NSTextAlignmentCenter bakcgroundColor:nil];
//            RemindLabel.text = @"数据空空如也";
//            [self.view addSubview:RemindLabel];
//            [RemindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(self.view).offset(ZP_Width / 2 -30);
//                make.top.equalTo(image).offset(55);
//                make.height.mas_offset(15);
//            }];
//        }
        if ([json isKindOfClass:[NSDictionary class]]) {
            return ;
        }
        self.newsData = [OrderModel arrayWithArray:json];
        [self.tableview.mj_header endRefreshing];  // 結束刷新
    [self.tableview reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
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
            [self.newsData removeObjectAtIndex:sender.tag];
            if ([obj[@"result"]isEqualToString:@"ok"]) {
                [SVProgressHUD showSuccessWithStatus:@"刪除成功"];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * ID = @"orderViewCell";
    OrderModel * model = self.newsData[indexPath.row];
//    OrdersdetailModel * model2 = [OrdersdetailModel CreateWithDict:model.ordersdetail[0]];
    OrderViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.tableview.tableFooterView = [[UIView alloc]init];
    cell.AppraiseBut.tag = indexPath.row;
    [cell.AppraiseBut removeTarget:self action:@selector(buttonType) forControlEvents:UIControlEventTouchUpInside];
    [cell.OnceagainBut addTarget:self action:@selector(OnceagainBut:) forControlEvents:UIControlEventTouchUpInside];
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
    cell.appraiseBlock = ^(RequestReplaceController* response) {
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

//  再次购买
- (void)OnceagainBut:(UIButton *)OnceagainBut {
    NSLog(@"再次购买");
    OrderModel * model = self.newsData[OnceagainBut.tag];
    OrdersdetailModel * model2 = [OrdersdetailModel CreateWithDict:model.ordersdetail[0]];
    ConfirmViewController * confirm = [[ConfirmViewController alloc]init];
    confirm.stockidsString = [NSString stringWithFormat:@"%@_%@",model2.stockid,model2.amount];
//    self.hidesBottomBarWhenPushed = YES;
    confirm.noEdit = YES;
    confirm.ordersnumber = model.ordersnumber;
    confirm.type = 666;
    
    [self.navigationController pushViewController:confirm animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    self.hidesBottomBarWhenPushed = YES;
}

@end

