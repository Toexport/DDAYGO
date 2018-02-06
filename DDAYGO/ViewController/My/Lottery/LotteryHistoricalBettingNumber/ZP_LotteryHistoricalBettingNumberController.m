//
//  ZP_LotteryHistoricalBettingNumberController.m
//  DDAYGO
//
//  Created by Summer on 2017/12/18.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_LotteryHistoricalBettingNumberController.h"
#import "ZP_LotteryHistoricalBettingNumberCell.h"
#import "ZP_LotteryHistoricalBettingNumberModel.h"
#import "ZP_MyTool.h"
#import "PrefixHeader.pch"

@interface ZP_LotteryHistoricalBettingNumberController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)  UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * secData;
@property (nonatomic, strong) NSMutableArray * rowData;
@property (nonatomic, strong) NSMutableDictionary * allData;
@property (nonatomic, strong) NoDataView * NoDataView;

@end


@implementation ZP_LotteryHistoricalBettingNumberController

- (NSMutableArray *)secData {
    if (!_secData) {
        _secData = [NSMutableArray array];
    }
    return _secData;
}

- (NSMutableArray *)rowData {
    if (!_rowData) {
        _rowData = [NSMutableArray array];
    }
    return _rowData;
}

- (NSMutableDictionary *)allData {
    if (!_allData) {
        _allData = [NSMutableDictionary dictionary];
    }
    return _allData;
}

- (void)viewDidLoad {
    [self initTableHeadView];
    [super viewDidLoad];
    [self initUI];
    [self AllData];
    self.NoDataView.backgroundColor = [UIColor whiteColor];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate= self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

//  UI
- (void)initUI {
    self.title = NSLocalizedString(@"歷史提交號碼", nil);
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZP_LotteryHistoricalBettingNumberCell" bundle:nil] forCellReuseIdentifier:@"ZP_LotteryHistoricalBettingNumberCell"];
//    [self.tableView registerClass:[ZP_LotterySubCell class] forCellReuseIdentifier:@"lotterysubcell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏tableview多余的线条
    self.tableView.backgroundColor = ZP_Graybackground;
    /**** IOS 11 ****/
    if (@available(iOS 11.0, *)) {
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
    }
    
    [NoDataView initWithSuperView:self.view Content:nil FinishBlock:^(id response) {
        self.NoDataView = response;
        [self.tableView reloadData];
    }];
}

- (void)initTableHeadView {
    UIView * myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, 30)];
    [myView setBackgroundColor:ZP_Graybackground];
    ZP_GeneralLabel * TitleLabel1 = [ZP_GeneralLabel initWithtextLabel:_TitleLabel1.text textColor:ZP_textblack font:ZP_stockFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    [myView addSubview:TitleLabel1];
    _TitleLabel1 = TitleLabel1;
    [TitleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myView).offset(8);
        make.centerY.equalTo(myView);
        make.height.mas_equalTo(15);
    }];
    
    //     标题2
    ZP_GeneralLabel * TitleLabel2 = [ZP_GeneralLabel initWithtextLabel:_TitleLabel2.text textColor:ZP_textblack font:ZP_stockFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    [myView addSubview:TitleLabel2];
    _TitleLabel2 = TitleLabel2;
    [TitleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(TitleLabel1).offset(15);
        make.top.equalTo(TitleLabel1).offset(0);
        make.height.mas_equalTo(15);
    }];
    
//    标题3
    ZP_GeneralLabel * titleLabel3 = [ZP_GeneralLabel initWithtextLabel:_TitleLabel3.text textColor:ZP_textblack font:ZP_TrademarkFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    [myView addSubview:titleLabel3];
    _TitleLabel3 = titleLabel3;
    [titleLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TitleLabel2).offset(65);
        make.top.equalTo(TitleLabel2).offset(0);
        make.height.mas_offset(15);
    }];
    self.tableView.tableHeaderView = myView;
    
}

// 数据
- (void)AllData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"countrycode"] = CountCode;
    dic[@"token"] = Token;
    dic[@"page"] = @"1";
    dic[@"pagesize"] = @"6";
    [ZP_MyTool requestHistoricalBet:dic uccess:^(id obj) {
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
        if ([obj isKindOfClass:[NSDictionary class]]) {
//            [SVProgressHUD showErrorWithStatus:@"無數據"];
            return ;
        }
        ZP_LotteryHistoricalBettingNumberModel *model1 = [ZP_LotteryHistoricalBettingNumberModel mj_objectWithKeyValues:obj[0]];
        [self.secData addObject:model1];
        [self settitltHade:model1];
        self.rowData= [ZP_LotteryHistoricalBettingNumberModel2 mj_objectArrayWithKeyValuesArray:model1.winorders];
        [self.tableView reloadData];
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
    
}

// 获取最外层年月日时间
- (void)settitltHade:(ZP_LotteryHistoricalBettingNumberModel *)model {
    self.TitleLabel1.text = [NSString stringWithFormat:@"第%@%@%@期",model.yyyy,model.mm,model.periods]; // 数据多个拼接
    self.TitleLabel3.text = [NSString stringWithFormat:@"%@",model.createtime];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    if (self.rowData.count > 0) {
        self.tableView.hidden = NO;
        self.NoDataView.hidden = YES;
        return self.rowData.count;
    }else {
        if (self.NoDataView) {
            self.tableView.hidden = YES;
            self.NoDataView.hidden = NO;
        }
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    //    return CGFLOAT_MIN;
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

///*设置标题头的宽度*/
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//
//    return 25;
//}

/*设置cell 的宽度 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
    
}

#pragma mark -- tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZP_LotteryHistoricalBettingNumberModel2 *model2  = self.rowData[indexPath.section];
    ZP_LotteryHistoricalBettingNumberCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ZP_LotteryHistoricalBettingNumberCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果
    ZP_LotteryHistoricalBettingNumberModel3 *model3= [ZP_LotteryHistoricalBettingNumberModel3 mj_objectWithKeyValues:model2.winordersdetail[0]];
    [cell fillIntoData:model3];

    return cell;
}

@end
