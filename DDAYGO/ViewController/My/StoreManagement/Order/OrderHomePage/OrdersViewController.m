//
//  OrdersViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/26.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "OrdersViewController.h"
#import "UINavigationBar+Awesome.h"
#import "OrderManagerViewController.h"
#import "PrefixHeader.pch"
@interface OrdersViewController ()
@property (nonatomic ,strong) NoDataView *noDataView;
@end

@implementation OrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =MyLocal(@"Order");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (IBAction)paymentAction:(id)sender {
    OrderManagerViewController *viewController = [[OrderManagerViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}
- (IBAction)shipmentPendingAction:(id)sender {
    
}
- (IBAction)shippedAction:(id)sender {
    
}
- (IBAction)exchangeAction:(id)sender {
    
}
- (IBAction)returnAction:(id)sender {
    
}
- (IBAction)completeAction:(id)sender {
    
}
- (IBAction)cancelAction:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
