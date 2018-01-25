//
//  StoreViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/26.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "StoreViewController.h"
#import "OrdersViewController.h"
#import "BillViewController.h"
#import "UINavigationBar+Awesome.h"
#import "ReceivingController.h"
#import "PrefixHeader.pch"
#import "YueTixianController.h"
#import "ZP_ShopManagementModel/ZP_ShopManagementModel.h"
#import "ZP_MyTool.h"
@interface StoreViewController ()

@property (nonatomic, strong) NSNumber * sid;

@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self Supplier];
    self.merchantscrollView.bounces = YES;
    // 因为需要上个接口的 sid 所以只有等 商家sid 获取成功后才能调用
//    [self MerchantsBalance];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
}

- (void)initUI {
    self.title = NSLocalizedString(@"store management", nil);
    [self.navigationController.navigationBar setBarTintColor:ZP_NavigationCorlor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
}
// 获取供货商
- (void)Supplier {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    int i = arc4random_uniform(999);  // 随机数
    dic[@"nonce"] = @(i);
    [ZP_MyTool requesSupplier:dic success:^(id obj) {
        ZPLog(@"%@",obj);
        
//        1、直接 方法1
//        [self MerchantsBalance:obj[@"result"]];
        
//        2、全局 方法2
        //38接口显示·返回只有2个结果·以防止崩溃·加判断
        if ([obj[@"result"] isEqualToString:@"no"]) {
            [SVProgressHUD showInfoWithStatus:@"供貨商不存在"];
//            [self.navigationController popViewControllerAnimated:YES];
        }else {
            _sid = obj[@"result"];
            [self MerchantsBalance];
        }

    } failure:^(NSError * error) {
//        ZPLog(@"%@",error);
        [SVProgressHUD showInfoWithStatus:@"服務器鏈接失敗"];
    }];
}
// 获取商家余额(方法1)
//- (void)MerchantsBalance:(id)sid {
//    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//    dic[@"token"] = @"ec77b922d25bb303f27f63d23de84f73";
//    dic[@"sid"] = sid;
//    [ZP_MyTool requesMerchantsBalance:dic success:^(id obj) {
//        ZPLog(@"%@",obj);
//    } failure:^(NSError * error) {
//        ZPLog(@"%@",error);
//    }];
//}

// 获取商家余额(方法2)
- (void)MerchantsBalance {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    dic[@"sid"] = _sid;
    [ZP_MyTool requesMerchantsBalance:dic success:^(id obj) {
        ZPLog(@"%@",obj);
        ZP_ShopManagementModel * model = [ZP_ShopManagementModel CreateWithDict:obj];
        [self AllData:model];
        
    } failure:^(NSError * error) {
//        ZPLog(@"%@",error);
        [SVProgressHUD showInfoWithStatus:@"服務器鏈接失敗"];
    }];
}

// 数据
- (void)AllData:(ZP_ShopManagementModel *)model {
    self.TotalAmountLabel.text = [model.allamount stringValue];
    self.FrozenAssets.text = [model.iceamount stringValue];
    self.ActivitiesAssetsLabel.text = [model.balance stringValue];
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    self.hidesBottomBarWhenPushed = NO;
//    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_PayColor];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//}

//  提现
- (IBAction)tixianBut:(id)sender {
    YueTixianController * YueTixian = [[YueTixianController alloc]init];
    YueTixian.SupplierId = _sid;
    [self.navigationController pushViewController:YueTixian animated:YES];
}

/**暂不需要
//  订单
- (IBAction)orderAction:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    OrdersViewController *viewController = [[OrdersViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

//  账单
- (IBAction)billAction:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    BillViewController *viewController = [[BillViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
*/

//  收款
- (IBAction)receivingAction:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    ReceivingController * Receiving = [[ReceivingController alloc] init];
    [self.navigationController pushViewController:Receiving animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    NSLog(@"按钮");
}

@end
