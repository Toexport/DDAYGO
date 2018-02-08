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
@property (nonatomic, strong) NoDataView * NoDataView;
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
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: ZP_textWite}];
    [self.navigationController.navigationBar setBarTintColor:ZP_NavigationCorlor];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏tableview多余的线条
    [self.tableview registerNib:[UINib nibWithNibName:@"RefundServiceCell" bundle:nil] forCellReuseIdentifier:@"RefundServiceCell"];
    /** 判断是否是 ios11 */
    if (@available(iOS 11.0, *)){
        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);//导航栏如果使用系统原生半透明的，top设置为64
        self.tableview.scrollIndicatorInsets = self.tableview.contentInset;
        [NoDataView initWithSuperView:self.view Content:nil FinishBlock:^(id response) {
            self.NoDataView = response;
            [self.tableview reloadData];
        }];
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
//    [ZPProgressHUD showWithStatus:loading maskType:ZPProgressHUDMaskTypeNone];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    dic[@"page"] = @"1";
    dic[@"pagesize"] = @"10";
    [ZP_MyTool requestGetrefundlist:dic success:^(id obj) {
        //*************************************Token被挤掉***************************************************//
        if ([obj[@"result"]isEqualToString:@"token_not_exist"]) {
            Token = nil;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"symbol"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"countrycode"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"headerImage"];
            ZPICUEToken = nil;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"icuetoken"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"state"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"headerImage"];
            [[SDImageCache sharedImageCache] clearDisk];
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
        //****************************************************************************************//
        
        if (obj) {
            self.dataarray = obj;
            [self successful];
        }else{
            [self networkProblems];
        }
        ZPLog(@"%@",obj);
        self.dataarray = [RefundServiceModel mj_objectArrayWithKeyValuesArray:obj[@"datalist"]];
        [self.tableview reloadData];
        [self.tableview.mj_header endRefreshing];  // 結束刷新
    } failure:^(NSError *error) {
        [self loading];
        ZPLog(@"%@",error);
    }];
}

// 数据为空时加载此动画
-(void)loading{
//    [ZPProgressHUD showErrorWithStatus:connectFailed toViewController:self];
    __weak typeof(self)weakSelf = self;
    [ReloadView showToView:self.view touch:^{
        [weakSelf AllData];
        [ReloadView dismissFromView:weakSelf.view];
    }];
}
-(void)successful {
    [self.tableview reloadData];
    [ZPProgressHUD dismiss];
}
-(void)networkProblems{
    __weak typeof(self)weakSelf = self;
//    [ZPProgressHUD showErrorWithStatus:connectFailed toViewController:self];
    [ReloadView showToView:self.view touch:^{
     [weakSelf AllData];
    }];
    return;
}

#pragma 代理方法
// 分行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
// 分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dataarray.count > 0) {
        self.tableview.hidden = NO;
        self.NoDataView.hidden = YES;
        return self.dataarray.count;
    }else {
        if (self.NoDataView) {
            self.tableview.hidden = YES;
            self.NoDataView.hidden = NO;
        }
        return 0;
    }
    
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
    cell.WaitStateLabel.text = model.statestr;
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
