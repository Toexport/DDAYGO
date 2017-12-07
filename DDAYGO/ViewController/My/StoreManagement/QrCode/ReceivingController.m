//
//  ReceivingController.m
//  DDAYGO
//
//  Created by Login on 2017/10/10.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ReceivingController.h"
#import "PrefixHeader.pch"
#import "ReceivingViewCell.h"
#import "UINavigationBar+Awesome.h"
#import "ZP_MyTool.h"
#import "ZP_ConfirmWebController.h"
@interface ReceivingController ()<UITableViewDelegate, UITableViewDataSource>
// 当前试图控制器的亮度
@property (nonatomic, readwrite, assign) CGFloat currentLight;
@property (nonatomic,strong) NSString * strUrl;
@end

@implementation ReceivingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self allData];
    self.title = NSLocalizedString(@"收款码", nil);
    self.view.backgroundColor = ZP_green;
    [self.navigationController.navigationBar setBarTintColor:ZP_NavigationCorlor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
}

- (void)initUI {
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ReceivingViewCell" bundle:nil] forCellReuseIdentifier:@"ReceivingViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = ZP_green;
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_greenen];
}

// 数据
-(void)allData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    //    dic[@"token"] = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    dic[@"token"] = @"ec77b922d25bb303f27f63d23de84f73";
    int i = arc4random_uniform(999);  // 随机数
    dic[@"nonce"] = @(i);
    
    [ZP_MyTool requesQrCode:dic success:^(id obj) {
        ZPLog(@"%@",obj);
         _strUrl = [NSString stringWithFormat:@"ddaygo,%@,%@",obj[@"supplierid"],obj[@"shopname"]];
//        http://www.ddaygo.com/api/Test/getqrcodepaylink?token=ec77b922d25bb303f27f63d23de84f73&amount=100&shopcode=H7XVKDMECZQ=&countrycode=886&payway=allpay_balance&icuetoken=nil
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
}
#pragma mark - tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ReceivingViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ReceivingViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果
    cell.layer.cornerRadius = 5.0;// View圆角弧度
    if (_strUrl.length>0) {
         [cell getInitWithUrl:_strUrl];
    }
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 300;
}

// 把将要进入二维码页面时的系统亮度保存
- (void)viewWillAppear:(BOOL)animated {
    self.currentLight = [[USER_DEFAULTS valueForKey:SCREEN_BRIGHT] floatValue];
    [USER_DEFAULTS setBool:YES forKey:ISQRCONTROLLER];
}
// 进入控制器完成后，让控制器变量
- (void)viewDidAppear:(BOOL)animated {
    [[UIScreen mainScreen] setBrightness: 1.0];//0.1~1.0之间，值越大越亮
}
// 退出控制器时恢复之前的亮度
- (void)viewWillDisappear:(BOOL)animated {
    [[UIScreen mainScreen] setBrightness: self.currentLight];//0.5是自己设定认为比较合适的亮度值
    [USER_DEFAULTS setBool:NO forKey:ISQRCONTROLLER];
}
@end

