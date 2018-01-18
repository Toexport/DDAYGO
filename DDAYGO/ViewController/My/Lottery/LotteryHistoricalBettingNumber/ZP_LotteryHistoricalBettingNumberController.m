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
}

- (void)initTableHeadView {
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, 30)];
    //    self.tableview.tableHeaderView = myView; // 表头跟着cell一起滚动
    [myView setBackgroundColor:ZP_Graybackground];
    //     标题1
    ZP_GeneralLabel * TitleLabel1 = [ZP_GeneralLabel initWithtextLabel:_TitleLabel1.text textColor:ZP_textblack font:ZP_stockFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    TitleLabel1.text = @"第201811期";
    [myView addSubview:TitleLabel1];
    _TitleLabel1 = TitleLabel1;
    [TitleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myView).offset(8);
        make.centerY.equalTo(myView);
//                make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    //     标题2
    ZP_GeneralLabel * TitleLabel2 = [ZP_GeneralLabel initWithtextLabel:_TitleLabel2.text textColor:ZP_textblack font:ZP_stockFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    TitleLabel2.text = @"";
    [myView addSubview:TitleLabel2];
    _TitleLabel2 = TitleLabel2;
    [TitleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(TitleLabel1).offset(15);
        make.top.equalTo(TitleLabel1).offset(0);
        //        make.width.mas_equalTo(90);
        make.height.mas_equalTo(15);
    }];
    
//    标题3
    ZP_GeneralLabel * titleLabel3 = [ZP_GeneralLabel initWithtextLabel:_TitleLabel3.text textColor:ZP_textblack font:ZP_TrademarkFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    titleLabel3.text = @"2018-11-01 18:35:53";
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
        if ([obj isKindOfClass:[NSDictionary class]]) {
            [SVProgressHUD showErrorWithStatus:@"無數據"];
            return ;
        }
            ZP_LotteryHistoricalBettingNumberModel *model1 = [ZP_LotteryHistoricalBettingNumberModel mj_objectWithKeyValues:obj[0]];
            [self.secData addObject:model1];
             self.rowData= [ZP_LotteryHistoricalBettingNumberModel2 mj_objectArrayWithKeyValuesArray:model1.winorders];
        [self.tableView reloadData];
        ZPLog(@"%@",obj);
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
    
}


//////表头
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, 5, ZP_Width, 20)];
//    [myView setBackgroundColor:ZP_WhiteColor];
//    //     订单
//    ZP_GeneralLabel * OrderLabel = [ZP_GeneralLabel initWithtextLabel:_OrderLabel.text textColor:ZP_textblack font:ZP_TrademarkFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
//    OrderLabel.text = @"訂單號";
//    [myView addSubview:OrderLabel];
//    _OrderLabel = OrderLabel;
//    [OrderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(myView).offset(8);
//        make.centerY.equalTo(OrderLabel).offset(0);
//        //        make.width.mas_equalTo(90);
//        make.height.mas_equalTo(15);
//    }];
//
//    //     订单号
//    ZP_GeneralLabel * OrderNumberLabel = [ZP_GeneralLabel initWithtextLabel:_OrderNumberLabel.text textColor:ZP_textblack font:ZP_TrademarkFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
//    [myView addSubview:OrderNumberLabel];
//    _OrderNumberLabel = OrderNumberLabel;
// //多少期
//    if (self.secData.count > 0) {
//        //自己在这里写
//        ZP_LotteryHistoricalBettingNumberModel *model = self.secData[0];
//        _OrderNumberLabel.text = model.createtime;
//    }
//
//    [OrderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(OrderLabel.mas_trailing).offset(2);
//        make.centerY.equalTo(OrderLabel).offset(0);
//        //        make.width.mas_equalTo(90);
//        make.height.mas_equalTo(15);
//    }];
//    return myView;
//}


-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return self.rowData.count;
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
