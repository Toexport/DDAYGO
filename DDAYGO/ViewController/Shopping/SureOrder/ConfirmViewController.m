//
//  ConfirmViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/20.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ConfirmViewController.h"
#import "ZP_ConfirmViewCell.h"
#import "ZP_InformationCell.h"
#import "ZP_AnonymityViewCell.h"
#import "ConfirmPayView.h"
#import "ZP_ExpressDeliveryCell.h"
#import "AddressViewController.h"
#import "ZP_MessageViewCell.h"
#import "PayPassController.h"
#import "PayFailController.h"
#import "PrefixHeader.pch"
#import "ZP_ConfirmPayModel.h"
#import "ZP_shoopingTool.h"
#import "ZP_InformationModel.h"
#import "ZP_ComfirmModel.h"
#import "ZP_ConfirmPayModel.h"
#import "ZP_ConfirmWebController.h"
#import "AddAddressViewController.h"

@interface ConfirmViewController () <UITableViewDelegate, UITableViewDataSource> {
    
    NSArray * InformatonArray;
    NSArray * messageArray;;
    NSString * allMoney;
    NSString * allCount;
}

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArrar;
@property (nonatomic, strong)NSMutableArray * NewData;
@property (nonatomic, strong) NSMutableArray * ConfirmArray;
@property (nonatomic, strong) UILabel * merchantsLabel;


@end

@implementation ConfirmViewController

- (void)viewDidLoad {
    ZPLog(@"_stockid = %@",_stockid);
    _dataArrar = [NSMutableArray array];
    _ConfirmArray = [NSMutableArray array];
    [self initUI];
    [self ImmobilizationView];
    self.title = NSLocalizedString(@"確認訂單", nil);

    // 666shi 订单界面
    if (self.type == 666) {
        [self Mainorder];
        [self getAddData];
        ZPLog(@"^^^");
    } else {
//        购物车界面
         [self getAddData];
         [self MakeSureOrder];
    }
        [self ExpressDelivery];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    InformatonArray = _dataArray;
    if (_PriceStr && _NumStr) {
        messageArray = @[@{@"Computations":_PriceStr,@"num":_NumStr}];
    }else {
        messageArray = @[@{@"Computations":@"",@"num":@""}];
    }
}

// UI
- (void)initUI {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, ZP_height-49) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;  // 隐藏tableview线条
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag; // 滚动时键盘隐藏
    self.tableView.backgroundColor = ZP_Graybackground;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    //  注册
    static NSString * ConfirmViewID = @"confirmViewCell";
    static NSString * InformationID = @"informationCell";
    static NSString * AnonymityViewID = @"anonymity";
    static NSString * messageID = @"messageViewCell";
    static NSString * ExpressDeliveryID = @"expressDeliveryCell";
    [self.tableView registerClass:[ZP_ConfirmViewCell class] forCellReuseIdentifier:ConfirmViewID];
    [self.tableView registerClass:[ZP_InformationCell class] forCellReuseIdentifier:InformationID];
    [self.tableView registerClass:[ZP_ExpressDeliveryCell class] forCellReuseIdentifier:ExpressDeliveryID];
    [self.tableView registerClass:[ZP_MessageViewCell class] forCellReuseIdentifier:messageID];
    [self.tableView registerClass:[ZP_AnonymityViewCell class] forCellReuseIdentifier:AnonymityViewID];
    
}

- (void)ImmobilizationView {
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ZP_height - TabbarHeight - NavBarHeight , ZP_Width, 50)];
    bottomView.backgroundColor = ZP_textWite;
    [self.view addSubview:bottomView];
//      总金额
    ZP_GeneralLabel * PriceLabel = [ZP_GeneralLabel initWithtextLabel:_PriceLabel.text textColor:ZP_TypefaceColor font:ZP_TooBarFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    [bottomView addSubview:PriceLabel];
    [PriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(- 110); // 右
        make.top.equalTo(bottomView).offset(10);
    }];
    _PriceLabel = PriceLabel;
    
//       货币符号
    ZP_GeneralLabel * CurrencySymbolLabel = [ZP_GeneralLabel initWithtextLabel:_CurrencySymbolLabel.text textColor:ZP_TypefaceColor font:ZP_TooBarFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"symbol"];
    CurrencySymbolLabel.text = [NSString stringWithFormat:@"%@",str];
    [bottomView addSubview:CurrencySymbolLabel];
    [CurrencySymbolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(PriceLabel).offset(-25);
        make.top.equalTo(PriceLabel).offset(0);
    }];
    _CurrencySymbolLabel = CurrencySymbolLabel;
    
//      合计
    ZP_GeneralLabel * StatisticsLabel = [ZP_GeneralLabel initWithtextLabel:_StatisticsLabel.text textColor:ZP_TypefaceColor font:ZP_TooBarFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    StatisticsLabel.text = @"合計";
    [bottomView addSubview:StatisticsLabel];
    [StatisticsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CurrencySymbolLabel).offset(- 30); // 右
        make.top.equalTo(CurrencySymbolLabel).offset(0);
    }];
    _StatisticsLabel = StatisticsLabel;
    
//      提交订单
    UIButton * Clearing = [UIButton new];
    Clearing.backgroundColor = ZP_pricebackground;
    [Clearing setTitle:NSLocalizedString(@"提交訂單", nil) forState:UIControlStateNormal];
    Clearing.titleLabel.font = ZP_TooBarFont;
    [Clearing addTarget:self action:@selector(ClearingBut:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:Clearing];
    [Clearing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(ZP_Width - 100); // 左
        make.right.equalTo(self.view).offset(0);  // 右
        make.top.equalTo(bottomView).offset(0);
        make.height.mas_equalTo(50);
    }];
    _ClearingBut = Clearing;
    [self.view addSubview:bottomView];

//       货币符号
    ZP_GeneralLabel * HintLanguageLabel = [ZP_GeneralLabel initWithtextLabel:_HintLanguageLabel.text textColor:ZP_TypefaceColor font:ZP_TooBarFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    HintLanguageLabel.text = @"（含運費）";
    [bottomView addSubview:HintLanguageLabel];
    [HintLanguageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(Clearing).offset( -50 - 60);
        make.top.equalTo(StatisticsLabel).offset(20);
    }];
    _HintLanguageLabel = HintLanguageLabel;
}

//  组头
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section ==1) {
        return 40;
    }else if (section == 4) {
        return 10;
    }else {
        return 0;
    }
}

// 提交订单
- (void)ClearingBut:(UIButton *)sender {
    if (_dataArrar.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"請添加地址"];
        AddAddressViewController *viewController = [[AddAddressViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
        viewController.contentDic = @{@"asd":@(YES)};
        
    } else {
        [self ConfirmData];
        
    }
}

// 选择支付方式数据
- (void)ConfirmData {
//    NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"countrycode"];
    NSDictionary * dic = @{@"countrycode":@"886"};
    [ZP_shoopingTool requetMethodpay:dic success:^(id obj) {
        
        ConfirmPayView * PayView = [[ConfirmPayView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        PayView.AmountLabel.text = _PriceLabel.text;
        PayView.dataArray = [ZP_ConfirmPayModel arrayWithArray:obj];
        PayView.confirmPayBlock = ^(id response) {
        };
        PayView.ConfirmPayMoneyBlock = ^(id response) {
            ZP_ConfirmPayModel * model = response;
            NSLog(@"payname = %@",model.payname);
            ZP_ComfirmModel *modell = _dataArrar[0];
            NSMutableDictionary *dic =[NSMutableDictionary dictionary];
            dic[@"token"] = Token;
            dic[@"adsid"] = modell.addressid;
            dic[@"stockids"] =_stockidsString;
            dic[@"logistic"] = @1;
            dic[@"payway"] = model.payid;
            dic[@"leavemsg"] = @"";
            dic[@"icuetoken"] = ZPICUEToken;
            if (self.ordersnumber) {
                dic[@"ordersnumber"] = self.ordersnumber;
            }
//            没数据，等下次在加
//            if (_type == 666) {
//                ZPLog(@"666");
//            }else {
            __weak typeof(PayView) weakView = PayView;
            [ZP_shoopingTool requessaddorderpay:dic noEdit:self.noEdit success:^(id obj) {
                ZP_ConfirmWebController * web = [[ZP_ConfirmWebController alloc]init];
                web.jump_URL = obj[@"para"];
                web.jump_HeadURL = obj[@"uri"];
                [weakView removeView];
                [self.navigationController pushViewController:web animated:YES];
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
//                [SVProgressHUD showInfoWithStatus:@"服務器鏈接失敗"];
            }];
//            }
            };
            
        
        [PayView showInView:self.view];
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
//        [SVProgressHUD showInfoWithStatus:@"服務器鏈接失敗"];
    }];
}

// 确认地址
- (void)getAddData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    dic[@"stockids"] = self.stockidsString;
    [ZP_shoopingTool requesMakeSureOrder:dic success:^(id obj) {
        ZPLog(@"%@",obj);
        NSDictionary * dic = obj;
        NSArray * modelArr = [ZP_ComfirmModel arrayWithArray:dic[@"receipts"]];
        if (modelArr.count == 0) {
            [SVProgressHUD showErrorWithStatus:@"請添加地址"];
            AddAddressViewController * viewController = [[AddAddressViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
            viewController.contentDic = @{@"asd":@(YES)};
        } else {
            [modelArr enumerateObjectsUsingBlock:^(ZP_ComfirmModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([model.isdefault isEqualToNumber:@1]) {
                    NSLog(@"%@",model.isdefault);
                    self.merchantsLabel.text = model.receiptname;
                    [_dataArrar addObject:model];
                }
            }];
        }
//        [modelArr enumerateObjectsUsingBlock:^(ZP_ComfirmModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
//            if ([model.isdefault isEqualToNumber:@1]) {
//                ZPLog(@"%@",model.isdefault);
//                self.merchantsLabel.text = model.receiptname;
//                [_dataArrar addObject:model];
//            }
//        }];
        [self.tableView reloadData];
    } failure:^(NSError * error) {
//        ZPLog(@"%@",error);
        [SVProgressHUD showInfoWithStatus:@"服務器鏈接失敗"];
    }];
}

// 获取确认订单
- (void)MakeSureOrder {
    NSMutableDictionary * dicc = [NSMutableDictionary dictionary];
    dicc[@"token"] = Token;
    dicc[@"stockids"] = self.stockidsString;
    //    stockids：库存字符串，库存ID与数量拼接，多个用逗号连接，如：42_2,43_1
    [ZP_shoopingTool requesMakeSureOrder:dicc success:^(id obj) {
        NSDictionary * dic = obj;
        allMoney = [NSString stringWithFormat:@"%@",obj[@"allamount"]];
        self.NewData = [ZP_InformationModel arrayWithArray:dic[@"carts"]];
        ZP_ExpressDeliveryModel * model = [[ZP_ExpressDeliveryModel alloc] init];
        model.freightamount = dic[@"freightamount"];
        model.chooselogistic = dic[@"chooselogistic"];
        [_ConfirmArray addObject:model];
        [self upfataStatisticsLabel];
        [self.tableView reloadData];
    } failure:^(NSError * error) {
        [SVProgressHUD showInfoWithStatus:@"服務器鏈接失敗"];
    }];
}

// 总计金额
- (void)upfataStatisticsLabel {
    float asd = 0.0;
    int qwe = 0;
    for (ZP_InformationModel *model in self.NewData) {
        asd += model.amount.intValue * model.productprice.floatValue;
        qwe += model.amount.intValue;
    }
//    allMoney = [NSString stringWithFormat:@"%.2f",asd];
    allCount = [NSString stringWithFormat:@"%d",qwe];
    self.PriceLabel.text = allMoney;
//    self.PriceLabel.text = [self.model.allamount stringValue];
}

// 快递费
- (void)ExpressDelivery {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    dic[@"stockids"] = self.stockidsString;
    [ZP_shoopingTool requesMakeSureOrder:dic success:^(id obj) {
        //        NSDictionary * dic = obj;
        NSLog(@"freightamount : %@",obj[@"freightamount"]);
//      self.ConfirmArray = [ZP_ExpressDeliveryModel arrayWithArray:obj[@"freightamount"]];
        
        [self.tableView reloadData];
    } failure:^(NSError * error) {
        [SVProgressHUD showInfoWithStatus:@"服務器鏈接失敗"];
    }];
}

/***************订单*******************/
// 获取订单界面确认订单数据
- (void)Mainorder {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    dic[@"orderno"] = _ordersnumber;
    [ZP_shoopingTool requesOrders:dic success:^(id obj) {
        NSDictionary * dic = obj;
        ZPLog(@"%@",dic);
        self.NewData = [ZP_InformationModel arrayWithArray:dic[@"carts"]];
        ZP_ExpressDeliveryModel * model = [[ZP_ExpressDeliveryModel alloc] init];
        model.freightamount = dic[@"freightamount"];
        model.chooselogistic = dic[@"chooselogistic"];
        [_ConfirmArray addObject:model];
//        [self upfataStatisticsLabel];
    } failure:^(NSError * error) {
//        ZPLog(@"%@",error);
        [SVProgressHUD showInfoWithStatus:@"服務器鏈接失敗"];
    }];
}
// 获取确认订单界面支付数据
- (void)MainorderPay {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    dic[@"orderno"] = _ordersnumber;
        dic[@"adsid"] = @"1";
        dic[@"logistic"] = @1;
        dic[@"payway"] = @"allpay_creditcard";
        dic[@"leavemsg"] = @"";
        dic[@"icuetoken"] = @"";
    [ZP_shoopingTool requesOrdersPay:dic success:^(id obj) {
        ZPLog(@"%@",obj);
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
        [SVProgressHUD showInfoWithStatus:@"服務器鏈接失敗"];
    }];
}

#pragma Mark - TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 == section) {
        return _dataArrar.count;
        
    }else
        if (1 == section) {
            //        return InformatonArray.count;
            return self.NewData.count;
        }else
            if (2 == section) {
                return self.ConfirmArray.count;
            }else {
                
                return _dataArrar.count;
            }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString * ID = @"confirmViewCell";
        ZP_ConfirmViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果
        self.tableView.tableFooterView = [[UIView alloc] init];
        ZP_ComfirmModel * model = _dataArrar[indexPath.row];
        [cell cellWithDic:model];
        return cell;
        
    }else
        if (indexPath.section == 1){
            static NSString * ID = @"informationCell";
            ZP_InformationCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果
            self.tableView.tableFooterView = [[UIView alloc]init];
            ZP_InformationModel * model = self.NewData[indexPath.row];
            [cell InformationWithDic:model];
            return cell;
            
        }else
            if (indexPath.section ==2){
                static NSString * ExpressDeliveryID = @"expressDeliveryCell";
                ZP_ExpressDeliveryCell * cell = [tableView dequeueReusableCellWithIdentifier:ExpressDeliveryID];
                self.tableView.tableFooterView = [[UIView alloc]init];
                ZP_ExpressDeliveryModel * model = self.ConfirmArray[indexPath.row];
                [cell ExpressDevliveryDic:model];
                return cell;
                
            }else
                if (indexPath.section == 3){
                    static NSString * messageID = @"messageViewCell";
                    ZP_MessageViewCell * cell = [tableView dequeueReusableCellWithIdentifier:messageID];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;  // 取消cell点击变灰
                    self.tableView.tableFooterView = [[UIView alloc]init];
                    if (self.NewData.count > indexPath.row) {
                        cell.allMoney = allMoney;
                        cell.allCount = allCount;
                        ZP_InformationModel * model = self.NewData[indexPath.row];
                        [cell MessageDic:model];
                    }
                    
                    return cell;
                    
                }else {
                    static NSString * AnonymityID = @"anonymity";
                    ZP_AnonymityViewCell * cell = [tableView dequeueReusableCellWithIdentifier:AnonymityID];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果
                    [cell.AnonymousButton removeTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.AnonymousButton addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
                    return cell;
                    
                }
}
- (void)selectClick:(UIButton *)sup {
    
    if (sup.selected == 0) {
        NSLog(@"取消");
    }else
        if (sup.selected == 1) {
            NSLog(@"选中");
        }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return 90;
        
    }else
        if (indexPath.section == 1){
            
            return 95;
            
    }else
        if (indexPath.section == 2){
                
            return 45;
                
    }else
        if (indexPath.section == 3){
                    
            return 90;
                    
    }else {
                    
        return 45;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && !self.noEdit) {
        self.hidesBottomBarWhenPushed = YES;
        AddressViewController * addres = [[AddressViewController alloc]init];
        addres.popBlock = ^(ZP_FrontPageReceivingAddressModel *model) {
            self.dataArrar = [[NSMutableArray alloc]init];
            ZP_ComfirmModel * models = [[ZP_ComfirmModel alloc]init];
            models.receiptname = model.eeceiptname;
            models.receiptphone = model.eeceiptphone;
            models.addressdetail = model.addressdetail;
            models.addressid = model.addressid;
            
            [self.dataArrar addObject:models];
            NSIndexSet * indexset = [NSIndexSet indexSetWithIndex:0];
            [self.tableView reloadSections:indexset withRowAnimation:UITableViewRowAnimationTop];
        };
        [self.navigationController pushViewController:addres animated:YES];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        self.hidesBottomBarWhenPushed = YES;
        
    }
}

//  表头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section ==1) {
        ZP_CartsShopModel *model = _nameArray[section-1];
        UIView * myView = [[UIView alloc]init];
        //        if (1 == section) {
        //        self.tableView.tableHeaderView = myView; // 表头跟着cell一起滚动
        //        }
        [myView setBackgroundColor:[UIColor whiteColor]];
        /********************************************/
        UIView * view = [[UIView alloc]init];
        [view setBackgroundColor:ZP_Graybackground];
        [myView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(myView).offset(0);
            make.right.equalTo(myView).offset(0);
            make.top.equalTo(myView).offset(1);
            make.bottom.equalTo(myView).offset(-30);
        }];
        
        //   商家图片
        UIImageView * merchantsImage = [UIImageView new];
        merchantsImage.image = [UIImage imageNamed:@"ic_order_store"];
        [myView addSubview:merchantsImage];
        [merchantsImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(myView).offset(5);
            make.top.equalTo(myView).offset(20);
        }];
        
        //    商家名字
        UILabel * merchantsLabel = [UILabel new];
        merchantsLabel.textAlignment = NSTextAlignmentLeft;
        merchantsLabel.textColor = ZP_textblack;
        merchantsLabel.text = NSLocalizedString(model.shopname, nil);
        merchantsLabel.font = ZP_titleFont;
        [myView addSubview:merchantsLabel];
        [merchantsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(myView).offset(30);
            make.top.equalTo(myView).offset(20);
        }];
        self.merchantsLabel = merchantsLabel;
        return myView;
        
    }else {
        return 0;
    }
    
}

@end


