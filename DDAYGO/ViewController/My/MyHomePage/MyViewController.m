//
//  MyViewController.m
//  DDAYGO
//
//   Created by Login on 2017/9/7.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "MyViewController.h"
#import "UINavigationBar+Awesome.h"
#import "NewsViewController.h"
#import "ConcernShopViewController.h"
#import "CollectionViewController.h"
#import "FootprintViewController.h"
#import "SettingViewController.h"
#import "StoreViewController.h"
#import "QCodeController.h"
#import "LogregisterController.h"
#import "PrefixHeader.pch"
#import "ZP_MyTool.h"
#import "ZP_HomePageModel.h"

@interface MyViewController ()
@property (weak, nonatomic) IBOutlet UIView *userBackView;
@property (weak, nonatomic) IBOutlet UIView *sdglView;
@property (weak, nonatomic) IBOutlet UIView *xfjlView;
@property (weak, nonatomic) IBOutlet UIView *zxxxView;
@property (weak, nonatomic) IBOutlet UIView *scanView;
@property (weak, nonatomic) IBOutlet UIButton *headImageBut;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self allData];
}
//- (void)viewWillAppear:(BOOL)animated {
//    self.hidesBottomBarWhenPushed = YES;
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES];
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO];
//    self.hidesBottomBarWhenPushed = NO;
//    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor orangeColor]];
//}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
//    本地数据调用
    UIImage * image = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"headerImage"]];
    if (image) {
        _headImageBut.layer.cornerRadius = 42;
        _headImageBut.layer.masksToBounds = YES;
        [_headImageBut setImage:image forState:UIControlStateNormal];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
   
}
- (void)allData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = @"6a82c076d36524b8e7b8c2b8e3db37b1";
    dic[@"nonce"] = @"adf";
    [ZP_MyTool requestSetHomePage:dic success:^(id obj) {
        ZPLog(@"%@",obj);
        ZP_HomePageModel * model = [[ZP_HomePageModel alloc]init];
        model.icueaccount = obj[@"icueaccount"];
        model.avatarimg = [NSString stringWithFormat:@"http://www.ddaygo.com%@",obj[@"avatarimg"]];
        [self MyViewData:model];
    } failure:^(NSError * error) {
        
    }];
}
- (void)MyViewData:(ZP_HomePageModel *) model {
    _NameLabel.text = model.icueaccount;
}
- (void)initUI {
    self.userBackView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.userBackView.layer.shadowOffset = CGSizeMake(1.0, 1.0);
    self.userBackView.layer.shadowOpacity = YES;
    self.sdglView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.sdglView.layer.shadowOffset = CGSizeMake(0, 0);
    self.sdglView.layer.shadowOpacity = 0.3;
    self.xfjlView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.xfjlView.layer.shadowOffset = CGSizeMake(0, 0);
    self.xfjlView.layer.shadowOpacity = 0.3;
    self.zxxxView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.zxxxView.layer.shadowOffset = CGSizeMake(0, 0);
    self.zxxxView.layer.shadowOpacity = 0.3;
    self.scanView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.scanView.layer.shadowOffset = CGSizeMake(0, 0);
    self.scanView.layer.shadowOpacity = 0.3;
}

- (IBAction)LonigAction:(id)sender {
    NSLog(@"Push");
    self.hidesBottomBarWhenPushed = YES;
    LogregisterController * Logregister = [[LogregisterController alloc] init];
    [self.navigationController pushViewController:Logregister animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.hidesBottomBarWhenPushed = NO;
}

- (IBAction)settingAction:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    SettingViewController *settingViewController = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingViewController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.hidesBottomBarWhenPushed = NO;
}

- (IBAction)scAction:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    CollectionViewController *collectionViewController = [[CollectionViewController alloc] init];
    [self.navigationController pushViewController:collectionViewController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.hidesBottomBarWhenPushed = NO;
}

- (IBAction)gzdpAction:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    ConcernShopViewController *concernShopViewController = [[ConcernShopViewController alloc] init];
    [self.navigationController pushViewController:concernShopViewController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.hidesBottomBarWhenPushed = NO;
}

- (IBAction)zjAction:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    FootprintViewController *footprintViewController = [[FootprintViewController alloc] init];
    [self.navigationController pushViewController:footprintViewController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.hidesBottomBarWhenPushed = NO;
}
//  商店管理
- (IBAction)sdglAction:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    StoreViewController *storeViewController = [[StoreViewController alloc] init];
    [self.navigationController pushViewController:storeViewController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.hidesBottomBarWhenPushed = NO;
}

- (IBAction)sskdAction:(id)sender {
    
}

// 最新消息
- (IBAction)zxxxAction:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    NewsViewController *newsViewController = [[NewsViewController alloc] init];
    [self.navigationController pushViewController:newsViewController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.hidesBottomBarWhenPushed = NO;
}
//  扫一扫
- (IBAction)scanAction:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    QCodeController * CodeController = [[QCodeController alloc]init];
    [self.navigationController pushViewController:CodeController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.hidesBottomBarWhenPushed = NO;

    NSLog(@"跳转");
}

@end
