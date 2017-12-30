//
//  ZP_HistoryVetController.m
//  DDAYGO
//
//  Created by Summer on 2017/11/30.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_HistoryVetController.h"
#import "ZP_HistoryBetCell.h"
#import "ZP_DetailsSistoryAwardController.h"
#import "PrefixHeader.pch"
#import "ZP_HistoryModel.h"
#import "ZP_MyTool.h"
@interface ZP_HistoryVetController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * newsData;
@end

@implementation ZP_HistoryVetController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self allData];
    [self initTableHeadView];
}
- (void)initUI {
    
    self.title = NSLocalizedString(@"历史开奖", nil);
    [self.tableView registerNib:[UINib nibWithNibName:@"ZP_HistoryBetCell" bundle:nil] forCellReuseIdentifier:@"ZP_HistoryBetCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏tableview多余的线条
//    self.tableView.backgroundColor = [UIColor grayColor];
    /**** IOS 11 ****/
    if (@available(iOS 11.0, *)) {
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
    }
    
}


- (void)initTableHeadView {
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, 30)];
//        self.tableview.tableHeaderView = myView; // 表头跟着cell一起滚动
    [myView setBackgroundColor:ZP_Graybackground];
    //     标题1
    ZP_GeneralLabel * TitleLabel1 = [ZP_GeneralLabel initWithtextLabel:_TitleLabel1.text textColor:ZP_textblack font:ZP_TooBarFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
    TitleLabel1.text = @"第";
    [myView addSubview:TitleLabel1];
    _TitleLabel1 = TitleLabel1;
    [TitleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myView).offset(8);
        make.centerY.equalTo(myView);
        //        make.width.mas_equalTo(90);
        make.height.mas_equalTo(15);
    }];
    
    //     标题2
    ZP_GeneralLabel * TitleLabel2 = [ZP_GeneralLabel initWithtextLabel:_TitleLabel2.text textColor:ZP_textblack font:ZP_TooBarFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    TitleLabel2.text = @"2017";
    [myView addSubview:TitleLabel2];
    _TitleLabel2 = TitleLabel2;
    [TitleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TitleLabel1).offset(15);
        make.top.equalTo(TitleLabel1).offset(0);
        //        make.width.mas_equalTo(90);
        make.height.mas_equalTo(15);
    }];
    //     标题3
    ZP_GeneralLabel * TitleLabel3 = [ZP_GeneralLabel initWithtextLabel:_TitleLabel3.text textColor:ZP_textblack font:ZP_TooBarFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    TitleLabel3.text = @"";
    [myView addSubview:TitleLabel3];
    _TitleLabel3 = TitleLabel3;
    [TitleLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(TitleLabel2.mas_trailing).offset(0);
        make.top.equalTo(TitleLabel2).offset(0);
        //        make.width.mas_equalTo(90);
        make.height.mas_equalTo(0);
    }];
    //     标题3
    ZP_GeneralLabel * TitleLabel4 = [ZP_GeneralLabel initWithtextLabel:_TitleLabel4.text textColor:ZP_textblack font:ZP_TooBarFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    TitleLabel4.text = @"";
    [myView addSubview:TitleLabel4];
    _TitleLabel4 = TitleLabel4;
    [TitleLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TitleLabel3).offset(15);
        make.top.equalTo(TitleLabel3).offset(0);
        //        make.width.mas_equalTo(90);
        make.height.mas_equalTo(0);
    }];
    //     标题4
    ZP_GeneralLabel * TitleLabel5 = [ZP_GeneralLabel initWithtextLabel:_TitleLabel5.text textColor:ZP_textblack font:ZP_TrademarkFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    TitleLabel5.text = @"2017-11-19（周日）";
    [myView addSubview:TitleLabel5];
    _TitleLabel5 = TitleLabel5;
    [TitleLabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(TitleLabel2.mas_trailing).offset(0);
        make.top.equalTo(TitleLabel2).offset(0);
        //        make.width.mas_equalTo(90);
        make.height.mas_equalTo(15);
    }];
    
    self.tableView.tableHeaderView = myView;
}

//表头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, 5, ZP_Width, 20)];
    //    self.tableview.tableHeaderView = myView; // 表头跟着cell一起滚动
    [myView setBackgroundColor:ZP_WhiteColor];
    //     订单
    ZP_GeneralLabel * OrderLabel = [ZP_GeneralLabel initWithtextLabel:_OrderLabel.text textColor:ZP_textblack font:ZP_TrademarkFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
    OrderLabel.text = @"";
    [myView addSubview:OrderLabel];
    _OrderLabel = OrderLabel;
    [OrderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(myView).offset(15);
        make.centerY.equalTo(OrderLabel).offset(0);
//                make.width.mas_equalTo(90);
        make.height.mas_equalTo(15);
    }];
    
    //     订单号
    ZP_GeneralLabel * OrderNumberLabel = [ZP_GeneralLabel initWithtextLabel:_OrderNumberLabel.text textColor:ZP_textblack font:ZP_TrademarkFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    OrderNumberLabel.text = @"";
    [myView addSubview:OrderNumberLabel];
    _OrderNumberLabel = OrderNumberLabel;
    [OrderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(OrderLabel.mas_trailing).offset(2);
        make.centerY.equalTo(OrderLabel).offset(0);
        //        make.width.mas_equalTo(90);
        make.height.mas_equalTo(15);
    }];
    
    //    领奖
    UIButton * button = [[UIButton alloc] init];
    button.backgroundColor = [UIColor redColor];
//    [myView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(myView.mas_trailing).offset(-8);
        make.top.equalTo(myView.mas_top).offset(8);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(46);
    }];
    
    return myView;
}

// 数据
- (void)allData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    dic[@"page"] = @"1";
    dic[@"pagesize"] = @"10";
    [ZP_MyTool requestHistoryPrize:dic uccess:^(id obj) {
        ZPLog(@"%@",obj);
        ZP_HistoryModel * model = [[ZP_HistoryModel alloc]init];
        for (NSDictionary *dic in obj[@"datalist"]) {
            self.newsData = [NSMutableArray array];
            ZP_HistoryModel * model = [[ZP_HistoryModel alloc]init];
            model.white1 = dic[@"white1"];
            model.white2 = dic[@"white2"];
            model.white3 = dic[@"white3"];
            model.white4 = dic[@"white4"];
            model.white5 = dic[@"white5"];
            model.powerball = dic[@"powerball"];
            model.createtime = dic[@"createtime"];
            [self.newsData addObject:model];
        }
//        self.newsData = obj[@"datalist"];
        model = self.newsData.firstObject;
//        NSString *string = [NSString stringWithFormat:@"%@%@%@",dic[@"yyyy"],dic[@"mm"],dic[@"periods"]];
//        model.yyyy = @(string.integerValue);
        [self WithHistoryAllData:model];
        [self.tableView reloadData];
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
}
- (void)WithHistoryAllData:(ZP_HistoryModel *) model {
    //    _OrderLabel.text = model.
    _TitleLabel2.text = [[model.yyyy stringValue] stringByAppendingString:@"期"];
    _TitleLabel5.text = model.createtime;
//    _TitleLabel5.text = [NSString stringWithFormat:@"%@",model.createtime ];
    
}


// 领奖按钮
- (void)AwardBut {
    ZPLog(@"按钮");
}
-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return 1;
}

/*设置标题头的宽度*/
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

/*设置cell 的宽度 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 35;
    
}

#pragma mark -- tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZP_HistoryBetCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ZP_HistoryBetCell"];
    [cell HistoryBet:self.newsData[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZP_DetailsSistoryAwardController * DetailsSistoryAward = [[ZP_DetailsSistoryAwardController alloc]init];
    [self.navigationController pushViewController:DetailsSistoryAward animated:YES];
    ZPLog(@"%ld",indexPath.row);
}
@end

