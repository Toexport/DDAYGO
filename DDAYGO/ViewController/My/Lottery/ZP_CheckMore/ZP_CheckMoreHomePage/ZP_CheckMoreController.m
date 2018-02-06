//
//  ZP_CheckMoreController.m
//  DDAYGO
//
//  Created by Summer on 2017/12/14.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_CheckMoreController.h"
#import "ZP_CheckMoreCell.h"
#import "PrefixHeader.pch"
#import "ZP_MyTool.h"
@interface ZP_CheckMoreController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView * tableview;
@property (nonatomic, strong) NSMutableArray * newsData;
@property (nonatomic, strong) NoDataView * NoDataView;
@end

@implementation ZP_CheckMoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self AllData];
    self.title = NSLocalizedString(@"本期下注號碼", nil);
    [self.tableview registerNib:[UINib nibWithNibName:@"ZP_CheckMoreCell" bundle:nil] forCellReuseIdentifier:@"ZP_CheckMoreCell"];
    [self initTableHeadView];
/**** IOS 11 ****/
    if (@available(iOS 11.0, *)) {
        self.tableview.estimatedRowHeight = 0;
        self.tableview.estimatedSectionHeaderHeight = 0;
        self.tableview.estimatedSectionFooterHeight = 0;
    }
    [NoDataView initWithSuperView:self.view Content:nil FinishBlock:^(id response) {
        self.NoDataView = response;
        [self.tableview reloadData];
    }];
}

- (void)initTableHeadView {
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, 30)];
    //    self.tableview.tableHeaderView = myView; // 表头跟着cell一起滚动
    [myView setBackgroundColor:ZP_Graybackground];
    //     标题1
    ZP_GeneralLabel * TitleLabel1 = [ZP_GeneralLabel initWithtextLabel:_TitleLabel1.text textColor:ZP_textblack font:ZP_TooBarFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
//    TitleLabel1.text = @"第2017136期";
    [myView addSubview:TitleLabel1];
    _TitleLabel1 = TitleLabel1;
    [TitleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myView).offset(8);
        make.centerY.equalTo(myView);
        //        make.width.mas_equalTo(90);
        make.height.mas_equalTo(15);
    }];
    
    //     标题2
    ZP_GeneralLabel * TitleLabel2 = [ZP_GeneralLabel initWithtextLabel:_TitleLabel2.text textColor:ZP_textblack font:ZP_TrademarkFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
//    TitleLabel2.text = @"2017-11-19（周日）";
    [myView addSubview:TitleLabel2];
    _TitleLabel2 = TitleLabel2;
    [TitleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(TitleLabel1.mas_trailing);
        make.top.equalTo(TitleLabel1).offset(0);
        //        make.width.mas_equalTo(90);
        make.height.mas_equalTo(15);
    }];
    
    self.tableview.tableHeaderView = myView;
}

// 数据
- (void)AllData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    dic[@"poolid"] = @"1";
    
    [ZP_MyTool requseMoreMore:dic uccess:^(id obj) {
        //*************************************Token被挤掉***************************************************//
        if ([obj[@"result"]isEqualToString:@"token_not_exist"]) {
            Token = nil;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"symbol"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"countrycode"];
            [[NSUserDefaults standardUserDefaults] objectForKey:@"headerImage"];
            ZPICUEToken = nil;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"icuetoken"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"state"];
            [[NSUserDefaults standardUserDefaults] objectForKey:@"headerImage"];
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
        ZPLog(@"%@",obj);
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
//        [SVProgressHUD showInfoWithStatus:@"服务器链接失败"];
    }];
}

 //表头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, 5, ZP_Width, 20)];
//    self.tableview.tableHeaderView = myView; // 表头跟着cell一起滚动
    [myView setBackgroundColor:ZP_WhiteColor];
//     订单
    ZP_GeneralLabel * OrderLabel = [ZP_GeneralLabel initWithtextLabel:_OrderLabel.text textColor:ZP_textblack font:ZP_TrademarkFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
    OrderLabel.text = @"訂單號";
    [myView addSubview:OrderLabel];
    _OrderLabel = OrderLabel;
    [OrderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(myView).offset(8);
        make.top.equalTo(myView).offset(5);
        make.centerY.equalTo(OrderLabel).offset(0);
        make.height.mas_equalTo(15);
    }];
    
//     订单号
    ZP_GeneralLabel * OrderNumberLabel = [ZP_GeneralLabel initWithtextLabel:_OrderNumberLabel.text textColor:ZP_textblack font:ZP_TrademarkFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
//    OrderNumberLabel.text = @"5678908765456";
    [myView addSubview:OrderNumberLabel];
    _OrderNumberLabel = OrderNumberLabel;
    [OrderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(OrderLabel.mas_trailing).offset(2);
        make.centerY.equalTo(OrderLabel).offset(0);
        //        make.width.mas_equalTo(90);
        make.height.mas_equalTo(15);
    }];
    
    //     button
    UIButton * button = [[UIButton alloc] init];
    [myView addSubview:button];
//    [button setTitle:@"领奖" forState:UIControlStateNormal];
    button.titleLabel.font = ZP_TooBarFont;
    [button setTitleColor:ZP_TypefaceColor forState:UIControlStateNormal];
     [button addTarget:self action:@selector(AwardBut) forControlEvents:UIControlEventTouchUpInside];
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = 5;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(myView.mas_trailing).offset(-8);
        make.bottom.equalTo(myView).offset(0);
        //        make.width.mas_equalTo(90);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(45);
    }];
    
    return myView;
}
// 领奖按钮
- (void)AwardBut {
    ZPLog(@"按钮");
}
-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    if (self.newsData.count > 0) {
        self.tableview.hidden = NO;
        self.NoDataView.hidden = YES;
        return self.newsData.count;
    }else {
        if (self.NoDataView) {
            self.tableview.hidden = YES;
            self.NoDataView.hidden = NO;
        }
        return 0;
    }
}

/*设置标题头的宽度*/
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 15;
}
/*设置cell 的宽度 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 35;

}

#pragma mark -- tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZP_CheckMoreCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ZP_CheckMoreCell"];
    return cell;
}


@end
