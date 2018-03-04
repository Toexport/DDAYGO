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
#import "LotteryController.h"
#import "LogregisterController.h"
#import "PrefixHeader.pch"
#import "Supplier1ViewController.h"
#import "RefundServiceController.h"
#import "ZP_MyTool.h"
#import "ZP_HomePageModel.h"
#import "ZP_LoginTool.h"
#import "ZP_MyHopageModel.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "SDImageCache.h"
#import "SelectView.h"
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>

@interface MyViewController ()
@property (weak, nonatomic) IBOutlet UIView * userBackView;
@property (weak, nonatomic) IBOutlet UIView * sdglView;
@property (weak, nonatomic) IBOutlet UIView * xfjlView;
//@property (weak, nonatomic) IBOutlet UIView * zxxxView;
@property (weak, nonatomic) IBOutlet UIView *ReceivingView;
@property (weak, nonatomic) IBOutlet UIView * scanView;
@property (weak, nonatomic) IBOutlet UIView * CaipiaoView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * viewLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * SdglLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * XfjlLayoutConstraint;
@property (nonatomic, strong) NSString * reason;
@property (weak, nonatomic) IBOutlet UIScrollView * scorllview;
// 需要适配X的控件
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * hheigth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * ttttop;
@property (nonatomic, strong) CTCallCenter * center;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    //iphone X
    if ([[UIApplication sharedApplication] statusBarFrame].size.height>20) {
        //在这里写你想要的高度 其他地方不用动
        _hheigth.constant = 260 + 40;
        _ttttop.constant = 14 + 40;
    }
    
    self.center = [[CTCallCenter alloc] init];
    self.center.callEventHandler = ^(CTCall * call) {
        if ([call.callState isEqualToString:@"CTCallStateDisconnected"]) {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        }
    };
}

// 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self SupplierAllData];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self mainColor];
    [self initUI];
    [self LoginJudde];
    [self loginAllData];
    [self allData];
    NSData * data  = [[NSUserDefaults standardUserDefaults] objectForKey:@"headerImage"];
    [self.headImageBut setImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
    self.NameLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"NameLabel"];
    self.headImageBut.layer.cornerRadius = 42;
    self.headImageBut.layer.masksToBounds = YES;
    [self.headImageBut setUserInteractionEnabled: NO];
    
    if (@available(iOS 11.0, *)) {
        self.scorllview.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

//- (void) Supplier {
//     判断是否是供货商
//    if (state.length == NO) {
//        _SdglLayoutConstraint.constant = CGFLOAT_MIN;
//        _sdglView.hidden = YES;
//        _viewLayoutConstraint.constant = 50.0;
//    }
//     判断是否申请成功供货商
//    if (state.length == YES) {
//        //        _SdglLayoutConstraint.constant = CGFLOAT_MIN;
//        self.XfjlLayoutConstraint.constant = CGFLOAT_MIN;
//        self.xfjlView.hidden = YES;
//        //        _viewLayoutConstraint.constant = 50.0;
//    } 
//}

// 登录状态
- (void)LoginJudde {
    [self autoLogin:^(id obj) {
        if (!DD_HASLOGIN) {
            if (![MyViewController sharedInstanceTool].hasRemind) {
                [MyViewController sharedInstanceTool].hasRemind = YES;
                LogregisterController * viewcontroller = [[LogregisterController alloc] init];
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:viewcontroller animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }
        } else {
            [self updateUserInfo];
        }
    }];
}

- (void)loginAllData {
    //    判断是否登录
    if (!Token) {
        if (![MyViewController sharedInstanceTool].hasRemind) {
            [MyViewController sharedInstanceTool].hasRemind = YES;
            LogregisterController *viewcontroller = [[LogregisterController alloc] init];
            [self.navigationController pushViewController:viewcontroller animated:YES];
        }
    }else {
        [self SupplierAllData];
        [self AllDatas];
        [self allData];
        
        
    }
}

+ (MyViewController *)sharedInstanceTool {
    static MyViewController *instance = nil;
    static NSString *language = nil;
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"Language"]) {
        NSArray * array = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
        [[NSUserDefaults standardUserDefaults] setObject:array.firstObject forKey:@"Language"];
    }
    NSString * language1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"Language"];
    if (!language) {
        language = [[NSUserDefaults standardUserDefaults] objectForKey:@"Language"];
    }
    if (!instance || ![language isEqualToString:language1]) {
        language = language1;
        instance = [[self alloc] init];
    }
    return instance;
}

- (void)autoLogin:(void (^)(id obj))success {
    if (DD_HASLOGIN) {
        if (success) {
            success(nil);
        }
    } else {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"loginData"]) {
            NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginData"];
            [ZP_LoginTool requestLogin:dic success:^(id obj) {
                NSLog(@"obj---%@",obj);
                NSDictionary * dic = obj;
                [[NSUserDefaults standardUserDefaults] setObject:Token forKey:@"token"];
                if ([dic[@"result"] isEqualToString:@"ok"]) {
                    [ZP_LoginTool getAccountInfo:Token success:^(id obj) {
                        NSDictionary * tempDic = obj;
                        if (tempDic.allKeys.count > 1) {
                            NSDictionary * asdic = @{@"address":tempDic[@"address"],@"aid":tempDic[@"aid"],@"avatarimg":tempDic[@"avatarimg"],@"countrycode":tempDic[@"countrycode"],@"email":tempDic[@"email"],@"nickname":tempDic[@"nickname"],@"phone":tempDic[@"phone"],@"realname":tempDic[@"realname"],@"sex":tempDic[@"sex"],@"state":tempDic[@"state"]};
                            [[NSUserDefaults standardUserDefaults] setObject:asdic forKey:@"userInfo"];
                            [[NSUserDefaults standardUserDefaults] setObject:obj[@"countryname"] forKey:@"countryname"];
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeStaus" object:nil userInfo:@{@"countryname":obj[@"countryname"]}];
                        }
                        if (success) {
                            success(nil);
                        }
                    } failure:^(NSError *error) {
                        if (success) {
                            success(nil);
                        }
                        NSLog(@"%@",error);
                    }];
                }
            } failure:^(NSError *error) {
                if (success) {
                    success(nil);
                }
                NSLog(@"%@",error);
            }];
        } else {
            if (success) {
                success(nil);
                
            }
        }
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.popKind == DDFromDataVC) {
        self.tabBarController.selectedIndex = 3;
        self.popKind = 0;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self mainColor];
}

//  个人资料
- (void)allData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    if (Token.length < 1) {
        return;
    }
    dic[@"token"] = Token;
    int i = arc4random_uniform(999);  // 随机数
    dic[@"nonce"] = @(i);
    [ZP_MyTool requestSetHomePage:dic success:^(id obj) {
        if ([obj[@"result"]isEqualToString:@"token_not_exist"]) {
            Token = nil;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"symbol"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"countrycode"];
            DD_ChangeStaus;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"headerImage"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"NameLabel"];
            ZPICUEToken = nil;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"icuetoken"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"state"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"headerImage"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"NameLabel"];
            [[SDImageCache sharedImageCache] clearDisk];
            [[NSUserDefaults standardUserDefaults]synchronize];
#pragma make -- 提示框
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Prompt", nil) message:NSLocalizedString(@"Your account has been logged in other places, you have been forced to go offline, please change the password as soon as possible if you are not logged in.",nil) preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                ZPLog(@"取消");
            }];
            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Determine",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
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
            
        }else{
            ZPLog(@"%@",obj);
            ZP_HomePageModel * model = [[ZP_HomePageModel alloc]init];
            model.nickname = obj[@"nickname"];
            
            model.avatarimg = [NSString stringWithFormat:@"%@%@",ImgAPI,obj[@"avatarimg"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.headImageBut sd_setBackgroundImageWithURL:[NSURL URLWithString:model.avatarimg] forState:UIControlStateNormal];
                self.NameLabel.text = model.nickname;
            });
            [self MyViewData:model];
            NSData * data =  [NSData dataWithContentsOfURL:[NSURL URLWithString:model.avatarimg]];
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"headerImage"];
            [[NSUserDefaults standardUserDefaults] setObject:model.nickname forKey:@"NameLabel"];
        }
    } failure:^(NSError * error) {
        _SdglLayoutConstraint.constant = CGFLOAT_MIN;
        _sdglView.hidden = YES;
        _XfjlLayoutConstraint.constant = CGFLOAT_MIN;
        _xfjlView.hidden = YES;
    }];
}

// 獲取暱稱
- (void)MyViewData:(ZP_HomePageModel *) model {
    if ([model.nickname isEqualToString:@"(null)"]) { // 判断数据为nill
        self.NameLabel.hidden = YES;
    }else {
        _NameLabel.text = model.nickname; // 昵称
    }
    _headImageBut.layer.cornerRadius = 42;
    _headImageBut.layer.masksToBounds = YES;
}

// 获取浏览记录、收藏的数量
- (void)AllDatas {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    [ZP_MyTool requesBrowseCollection:dic uccess:^(id obj) {
        ZPLog(@"%@",obj);
        ZP_MyHopageModel * model = [[ZP_MyHopageModel alloc]init];
        model.collecedcount = obj[@"collecedcount"];
        model.historycount = obj[@"historycount"];
        [self setAllDatas:model];
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
        _SdglLayoutConstraint.constant = CGFLOAT_MIN;
        _sdglView.hidden = YES;
        //        _SdglLayoutConstraint.constant = CGFLOAT_MIN;
        //        _sdglView.hidden = YES;
        _XfjlLayoutConstraint.constant = CGFLOAT_MIN;
        _xfjlView.hidden = YES;
    }];
}

- (void)setAllDatas:(ZP_MyHopageModel *)model {
    if (model.collecedcount == nil) {
        return;
    }else {
        _CollectionLabel.text = [NSString stringWithFormat:@"%@",model.collecedcount];
    }
    if (model.historycount == nil) {
        return;
    }else {
        _BrowseLabel.text = [NSString stringWithFormat:@"%@",model.historycount];
    }
}

// 供货商状态请求
- (void) SupplierAllData {
    _SdglLayoutConstraint.constant = CGFLOAT_MIN;
    _sdglView.hidden = YES; //  默认隐藏商家
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    [ZP_MyTool requestSupplier:dic success:^(id obj) {
        ZPLog(@"%@",obj);
        ZP_MyHopageModel2 * model = [[ZP_MyHopageModel2 alloc]init];
        model.state = obj[@"state"];
        self.RequestStatusStr = model.state;
        
        if ([obj[@"result"] isEqualToString:@"ok"]) {
            _RequestStatusStr = @(-1);
            _RequestStatusLabel.text = @"";
            _kuohaoLabel1.text = @"";
            _kuohaoLabel2.text = @"";
            _kuohaoLabel1.hidden = YES;
            _kuohaoLabel2.hidden = YES;
        }else{
            _kuohaoLabel1.hidden = NO;
            _kuohaoLabel2.hidden = NO;
            _kuohaoLabel1.text = @"(";
            _kuohaoLabel2.text = @")";
        }
        if (obj[@"state"]) {
            model.state = obj[@"state"];
        }else {
            model.state = @(-1);
            _RequestStatusLabel.text = nil;
            _kuohaoLabel1.text = nil;
            _kuohaoLabel2.text = nil;
            _SdglLayoutConstraint.constant = CGFLOAT_MIN;
            _sdglView.hidden = YES; //  默认隐藏商家
            self.XfjlLayoutConstraint.constant = 49;
            self.xfjlView.hidden = NO; // 已审核隐藏申请列表
            return ;
        }
        switch (model.state.integerValue) {
            case 0:
            {
                self.reason = obj[@"reason"];
                model.stateString = MyLocal(@"Has been cancelled");
                self.ssdkBut.enabled = YES;
                _SdglLayoutConstraint.constant = CGFLOAT_MIN;
                _sdglView.hidden = YES; //  已取消隐藏商家
                self.XfjlLayoutConstraint.constant = 49;
                self.xfjlView.hidden = NO; // 已审核隐藏申请列表
                
            }
                break;
            case 2:
            {
                model.stateString = [NSString stringWithFormat:@"待%@",MyLocal(@"audited")];
                self.ssdkBut.enabled = NO;
                _SdglLayoutConstraint.constant = CGFLOAT_MIN;
                _sdglView.hidden = YES; //  待审核隐藏商家
                self.XfjlLayoutConstraint.constant = 49;
                self.xfjlView.hidden = NO; // 已审核隐藏申请列表
            }
                break;
            case 3:
            {
                model.stateString = [NSString stringWithFormat:@"已%@",MyLocal(@"audited")];
                self.XfjlLayoutConstraint.constant = CGFLOAT_MIN;
                self.xfjlView.hidden = YES; // 已审核隐藏申请列表
                _SdglLayoutConstraint.constant = 49;
                _sdglView.hidden = NO; //  显示商家
                
            }
                break;
            case 7:
            {
                model.stateString = MyLocal(@"product");
                self.reason = obj[@"reason"];
                self.ssdkBut.enabled = YES;
                _SdglLayoutConstraint.constant = CGFLOAT_MIN;
                _sdglView.hidden = YES; //  已退件隐藏商家
                self.XfjlLayoutConstraint.constant = 49;
                self.xfjlView.hidden = NO; // 已审核隐藏申请列表
            }
                break;
            default:
                break;
        }
        [self SupplierData:model];
    } failure:^(NSError * error) {
        _SdglLayoutConstraint.constant = CGFLOAT_MIN;
        _sdglView.hidden = YES;
        //        _SdglLayoutConstraint.constant = CGFLOAT_MIN;
        //        _sdglView.hidden = YES;
        _XfjlLayoutConstraint.constant = CGFLOAT_MIN;
        _xfjlView.hidden = YES;
        ZPLog(@"%@",error);
    }];
}

- (void)SupplierData:(ZP_MyHopageModel2 *)model {
    self.RequestStatusLabel.text = [NSString stringWithFormat:@"%@",model.stateString];
}

// UI
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
    //    self.zxxxView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    //    self.zxxxView.layer.shadowOffset = CGSizeMake(0, 0);
    //    self.zxxxView.layer.shadowOpacity = 0.3;
    self.scanView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.scanView.layer.shadowOffset = CGSizeMake(0, 0);
    self.scanView.layer.shadowOpacity = 0.3;
}

- (NSString *)getMonetarySymbol {
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"countrycode"] isEqualToString:@"86"]) {
        return @"¥";
    } else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"countrycode"] isEqualToString:@"852"]) {
        return @"HK$";
    } else {
        return @"NT";
    }
}

- (void)updateUserInfo {
    if (Token) {
        NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
        self.NameLabel.text = dic[@"nickname"];
    }
}

- (IBAction)LonigAction:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    UIViewController * viewController;
    if (DD_HASLOGIN) {
        viewController = [[SettingViewController alloc] init];
    } else {
        viewController = [[LogregisterController alloc] init];
    }
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = ZP_WhiteColor;
}

// 设置
- (IBAction)settingAction:(id)sender {
    SettingViewController * settingViewController = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingViewController animated:YES];
    self.navigationController.navigationBar.tintColor = ZP_WhiteColor;
}

// 收藏
- (IBAction)scAction:(id)sender {
    CollectionViewController * collectionViewController = [[CollectionViewController alloc] init];
    [self.navigationController pushViewController:collectionViewController animated:YES];
    self.navigationController.navigationBar.tintColor = ZP_WhiteColor;
}
// 关注店铺（暂时不开启）- (IBAction)gzdpAction:(id)sender {
//    ConcernShopViewController *concernShopViewController = [[ConcernShopViewController alloc] init];
//    [self.navigationController pushViewController:concernShopViewController animated:YES];
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
//    self.navigationController.navigationBar.tintColor = ZP_WhiteColor;}

// 足迹
- (IBAction)zjAction:(id)sender {
    FootprintViewController * footprintViewController = [[FootprintViewController alloc] init];
    [self.navigationController pushViewController:footprintViewController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = ZP_WhiteColor;
}

//  商店管理
- (IBAction)sdglAction:(id)sender {
    StoreViewController *storeViewController = [[StoreViewController alloc] init];
    [self.navigationController pushViewController:storeViewController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = ZP_WhiteColor;
}

// 申请开店
- (IBAction)sskdAction:(id)sender {
    Supplier1ViewController * Supplier = [[Supplier1ViewController alloc]init];
    Supplier.stausType = self.RequestStatusStr.integerValue;
    Supplier.reason = self.reason;
    ZPLog(@"%ld -- %ld",Supplier.stausType,self.RequestStatusStr.integerValue);
    [self.navigationController pushViewController:Supplier animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = ZP_WhiteColor;
}

//// 最新消息
//- (IBAction)zxxxAction:(id)sender {
//    NewsViewController *newsViewController = [[NewsViewController alloc] init];
//    [self.navigationController pushViewController:newsViewController animated:YES];
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
//    self.navigationController.navigationBar.tintColor = ZP_WhiteColor;
//}

// 彩票
- (IBAction)CaipiaoAction:(id)sender {
    LotteryController * Lottery = [[LotteryController alloc]init];
    [self.navigationController pushViewController:Lottery animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil]; // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = ZP_WhiteColor;
}

//  扫一扫
- (IBAction)scanAction:(id)sender {
    QCodeController * CodeController = [[QCodeController alloc]init];
    [self.navigationController pushViewController:CodeController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = ZP_WhiteColor;
}

// 退款/ 售后
- (IBAction)RefundService:(id)sender {
    RefundServiceController * RefundService = [[RefundServiceController alloc]init];
    [self.navigationController pushViewController:RefundService animated:YES];
    //    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = ZP_WhiteColor;
    
}



// 适配iphoneX
-(void)mainColor {
    UINavigationBar * navBar = self.navigationController.navigationBar;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [navBar setTitleTextAttributes:dict];
    navBar.translucent = NO;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationItem setHidesBackButton:YES];
    
    UIButton * backBtn = self.navigationItem.leftBarButtonItem.customView;
    [backBtn setImage:[UIImage imageNamed:@"whiteBack"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"whiteBack"] forState:UIControlStateHighlighted];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

@end

