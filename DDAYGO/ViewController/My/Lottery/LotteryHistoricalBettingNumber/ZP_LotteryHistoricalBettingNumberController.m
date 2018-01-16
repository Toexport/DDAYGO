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
#import "ZP_LotterySubCell.h"

@interface ZP_LotteryHistoricalBettingNumberController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * newsData;
//@property (nonatomic, strong) NSMutableArray * array;
//@property (nonatomic, strong) NSMutableArray * arr;

@end

@implementation ZP_LotteryHistoricalBettingNumberController

- (void)viewDidLoad {
    [self initTableHeadView];
    [super viewDidLoad];
    [self initUI];
    [self AllData];
}

//  UI
- (void)initUI {
    self.title = NSLocalizedString(@"歷史提交號碼", nil);
//    static NSString * LotteryID = @"ZP_LotteryHistoricalBettingNumberCell";
    [self.tableView registerNib:[UINib nibWithNibName:@"ZP_LotteryHistoricalBettingNumberCell" bundle:nil] forCellReuseIdentifier:@"ZP_LotteryHistoricalBettingNumberCell"];
    [self.tableView registerClass:[ZP_LotterySubCell class] forCellReuseIdentifier:@"lotterysubcell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏tableview多余的线条
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
    TitleLabel1.text = @"";
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
    titleLabel3.text = @"";
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
//        数据为空时写这个不会蹦
        if (self.newsData == nil) {
            return ;
        }
        if ([obj isKindOfClass:[NSDictionary class]]) {
            [SVProgressHUD showErrorWithStatus:@"無數據"];
            return ;
        }
        self.newsData = [NSMutableArray array];
        for (NSDictionary * dic1 in obj) {
            ZP_LotteryHistoricalBettingNumberModel * model = [[ZP_LotteryHistoricalBettingNumberModel alloc]init];
            NSString * string = [NSString stringWithFormat:@"%@%@%@",dic1[@"yyyy"],dic1[@"mm"],dic1[@"periode"]];
            model.yyyy = @(string.integerValue);
            [self WithLotteryHistroicalTiltlBettingNumber:model];
            
            model.array = [NSMutableArray array];
            for (NSDictionary * dic2 in dic1[@"winorders"]) {
                ZP_LotteryHistoricalBettingNumberModel2 * model2 = [[ZP_LotteryHistoricalBettingNumberModel2 alloc]init];
                model2.lotteryoid = dic2[@"lotteryoid"];
                [self WithLotteryHistroicalBettingNumber:model2];
                
                model2.arr = [NSMutableArray array];
                for (NSDictionary * dic3 in dic2[@"winordersdetail"]) {
                   
                    ZP_LotteryHistoricalBettingNumberModel3 * model3 = [[ZP_LotteryHistoricalBettingNumberModel3 alloc]init];
                    model3.lotteryoid = dic3[@"lotteryoid"];
                    NSLog(@"id--%@",dic3[@"lotteryoid"]);
                    [model2.arr addObject:model3];
                }
                [model.array addObject:model2];
            }
            [self.newsData addObject:model];
        }

        for (NSDictionary * dict in obj[@"winorders"]) {
//            ZP_LotteryHistoricalBettingNumberModel2 * model2 = [[ZP_LotteryHistoricalBettingNumberModel2 alloc]init];
//            model2.lotteryoid = dict[@"lotteryoid"];
//            model2.pollid = obj[@""];
//            model2.aid = obj[@""];
//            [self WithLotteryHistroicalBettingNumber:model2];
        }
//        for (NSDictionary * dic in obj[@"winordersdetail"]) {
//            <#statements#>
//        }
        
        [self.tableView reloadData];
        ZPLog(@"%@",obj);
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
    
}
- (void)WithLotteryHistroicalTiltlBettingNumber:(ZP_LotteryHistoricalBettingNumberModel *)model {

    self.TitleLabel1.text = @"第";
    self.TitleLabel2.text = [[model.yyyy stringValue] stringByAppendingString:@"期"];
    _TitleLabel3.text = model.createtime.stringValue;
    
}

- (void)WithLotteryHistroicalBettingNumber:(ZP_LotteryHistoricalBettingNumberModel2 *)model2 {
    _OrderNumberLabel.text = model2.lotteryoid;
}

- (void)WithLotteryHistroicalBettingNumber3:(ZP_LotteryHistoricalBettingNumberModel3 *)model3 {
        ZP_LotteryHistoricalBettingNumberCell * cell = [[ZP_LotteryHistoricalBettingNumberCell alloc]init];
    [cell.button1 setTitle:[model3.white1 stringValue] forState:UIControlStateNormal];
    [cell.button2 setTitle:[model3.white2 stringValue] forState:UIControlStateNormal];
    [cell.button3 setTitle:[model3.white3 stringValue] forState:UIControlStateNormal];
    [cell.button4 setTitle:[model3.white4 stringValue] forState:UIControlStateNormal];
    [cell.button5 setTitle:[model3.white5 stringValue] forState:UIControlStateNormal];
    [cell.button6 setTitle:[model3.powerball stringValue] forState:UIControlStateNormal];
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
        make.centerY.equalTo(OrderLabel).offset(0);
        //        make.width.mas_equalTo(90);
        make.height.mas_equalTo(15);
    }];
    
    //     订单号
    ZP_GeneralLabel * OrderNumberLabel = [ZP_GeneralLabel initWithtextLabel:_OrderNumberLabel.text textColor:ZP_textblack font:ZP_TrademarkFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    OrderNumberLabel.text = @"5678908765456";
    [myView addSubview:OrderNumberLabel];
    _OrderNumberLabel = OrderNumberLabel;
    [OrderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(OrderLabel.mas_trailing).offset(2);
        make.centerY.equalTo(OrderLabel).offset(0);
        //        make.width.mas_equalTo(90);
        make.height.mas_equalTo(15);
    }];
    return myView;
}

//- (void)WithLotteryHistroicalBettingNumber:(ZP_LotteryHistoricalBettingNumberModel2 *)model2 {
//    _OrderNumberLabel.text = [model2.lotteryoid stringValue];
//}
//// 领奖按钮
//- (void)AwardBut {
//    ZPLog(@"按钮");
//}

-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return self.newsData.count;
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
    ZP_LotteryHistoricalBettingNumberModel * model = self.newsData[section];
    return model.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZP_LotteryHistoricalBettingNumberModel * model = self.newsData[indexPath.section];
    ZP_LotteryHistoricalBettingNumberModel2 * model2 = model.array[indexPath.row];
    ZP_LotterySubCell * cell = [tableView dequeueReusableCellWithIdentifier:@"lotterysubcell"];

    
    [cell viewWithArray:model2.arr];
    
    
    return cell;
}

@end
