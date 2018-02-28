//
//  ShoppingViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/7.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ShoppingViewController.h"
#import "PrefixHeader.pch"
#import "ZP_shoopingTool.h"
#import "ShoppingCell.h"
#import "ConfirmViewController.h"
#import "ZP_ShoppingModel.h"
#import "EditorViewCell.h"
#import "ShoppingHeadView.h"
#import "BuyViewController.h"
@interface ShoppingViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerPreviewingDelegate> {
    NSInteger allNum;
    BOOL _bjBool;
    NSString * _modelstockid;
    int _i;
}
@property (nonatomic, strong) NSMutableArray * selectAllArray;
@property (nonatomic, strong) NSMutableArray * indexArray;
@property (nonatomic, strong) NSMutableArray * selectArray;
@property (nonatomic, strong) NSMutableArray * dataArray;;
@property(nonatomic,strong) NSMutableArray * nameArray;
@property(nonatomic,strong) UITableView * tableView;
@property(nonatomic,strong) ZP_ShoppingModel * model;
@property(nonatomic,strong) NSString * stockids;
@property(nonatomic,strong) NSString * numstr;  //数量
@property(nonatomic,strong) NSNumber * cardid;  //cardid

@property (nonatomic, strong) NoDataView * noDataView;
@property (nonatomic, strong) UIButton * cartButton;

@end

@implementation ShoppingViewController

- (NSMutableArray *)nameArray {
    if (!_nameArray) {
        _nameArray = [NSMutableArray array];
    }
    return _nameArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _bjBool = NO;
    _selectAllArray = [[NSMutableArray alloc]init];
    [self setUpNavgationBar];
    [self initUI];
    [self.navigationController.navigationBar setBarTintColor:ZP_NavigationCorlor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    self.title = NSLocalizedString(@"Shopping", nil);
    /**** IOS 11 ****/
    if (@available(iOS 11.0, *)) {
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
    }
//    數據為空加載
    [NoDataView initWithSuperView:self.view Content:nil FinishBlock:^(id response) {
        self.noDataView = response;
        [self.tableView reloadData];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _AllButton.selected = NO;
    [self.tableView reloadData];
    if (!DD_HASLOGIN) {
        if (![MyViewController sharedInstanceTool].hasRemind) {
            [MyViewController sharedInstanceTool].hasRemind = YES;
            LogregisterController *viewcontroller = [[LogregisterController alloc] init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:viewcontroller animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
    } else {
        [self addRefresh];
        [self allData];
    }
}

// 获取购物车数据（获取接口）
- (void)allData {
    if (Token.length < 1) {
        _dataArray = nil;
        self.nameArray= nil;
        _selectArray = nil;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        return;
    }
    [ZP_shoopingTool requesshoppingData:Token success:^(id obj) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            if ([obj[@"result"]isEqualToString:@"token_not_exist"]) {
                Token = nil;
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"symbol"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"countrycode"];
                ZPICUEToken = nil;
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"icuetoken"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"state"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"headerImage"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"NameLabel"];
                [[SDImageCache sharedImageCache] clearDisk];
                [[NSUserDefaults standardUserDefaults]synchronize];
#pragma make -- 提示框
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Prompt", nil) message:NSLocalizedString(@"Your account has been logged in other places, you have been forced to go offline, please change the password as soon as possible if you are not logged in.",nil) preferredStyle:UIAlertControllerStyleAlert];
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
            }
            ZPLog(@"%@",obj);
        }else{
            if (obj) {
                self.selectArray = obj;
                [self successful];
            }else{
                [self networkProblems];
            }
            ZPLog(@"%@",obj);
            if ([obj isKindOfClass:[NSDictionary class]]) {
                NSLog(@"go");
                [self.tableView reloadData];
                return ;
            }
            NSArray * arr = obj;
            if (arr.count > 0) {
                NSDictionary * dic = [obj firstObject];
                _model = [ZP_ShoppingModel CreateWithDict:[obj firstObject]];
                _dataArray = [ZP_CartsModel arrayWithArray:dic[@"cart"]];
                //有几组商家
                self.nameArray = [ZP_CartsShopModel arrayWithArray:obj];
                //一共数量
                _selectArray = [[NSMutableArray alloc]init];
                static NSString * mustr ;//一共有多少个产品
                mustr = nil;
                [self.nameArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    ZP_CartsShopModel * model = obj;
                    NSLog(@"每组产品的详细%ld",model.array.count);
                    for (ZP_CartsModel * model1 in model.array) {
                        [_selectArray addObject:model1.amount];
                    }
                    mustr = [NSString stringWithFormat:@"%ld",model.array.count +[mustr integerValue]];
                }];
                self.navigationController.tabBarItem.badgeValue = mustr; // 購物車顯示的球
                [self updateData:0];
                [self.tableView reloadData];
                if (_bjBool) {
                    [self exitEditing];
                }
            }else{
                NSLog(@"go");
                _dataArray = nil;
                self.nameArray= nil;
                _selectArray = nil;
                _AllButton.selected = NO;
                _PriceLabel.text = @"0";
                self.navigationController.tabBarItem.badgeValue = nil;
                [self.tableView reloadData];
                
                if (_bjBool) {
                    [self exitEditing];
                }
            }
        }
        [self.tableView.mj_header endRefreshing];  // 結束刷新
    } failure:^(NSError *error) {
        [self loading];
    }];
}

// 刷新
- (void)addRefresh {
    //   下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.selectAllArray removeAllObjects];
        [self.indexArray removeAllObjects];
        [self.selectArray removeAllObjects];
        [self.dataArray removeAllObjects];
        _i = 0;
        [self allData];
    }];
}

- (void)beginEditing {
    _bjBool = YES;
    _AllButton.selected = NO;
    _StatisticsLabel.hidden = YES;
    _CurrencySymbolLabel.hidden = YES;
    _FreightLabel.hidden = YES;
    _PriceLabel.hidden = YES;
    _ClearingButt.selected = YES;
    
    [self.ClearingButt setTitle:NSLocalizedString(@"delete",nil) forState: UIControlStateNormal];
    [self.cartButton setTitle:NSLocalizedString(@"Complete", nil) forState:UIControlStateNormal];
}

- (void)exitEditing {
    _bjBool = NO;
    _AllButton.selected = NO;
    _StatisticsLabel.hidden = NO;
    _PriceLabel.hidden = NO;
    _FreightLabel.hidden = NO;
    _CurrencySymbolLabel.hidden = NO;
    _ClearingButt.selected = NO;
    [self.cartButton setTitle:NSLocalizedString(@"Edit", nil) forState:UIControlStateNormal];
    [self.ClearingButt setTitle:NSLocalizedString(@"Clearing", nil) forState: UIControlStateNormal];
    
    _AllButton.selected = NO;
    _PriceLabel.text = @"0";
    NSMutableDictionary * dictt = [NSMutableDictionary dictionary];
    dictt[@"token"] = Token;
    dictt[@"cartid"] = _cardid;
    dictt[@"count"] = _numstr;
    [ZP_shoopingTool requestSetcartproductcount:dictt success:^(id obj) {
        ZPLog(@"%@",obj);
        if ([obj[@"result"] isEqualToString:@"stock_count_err"]) {
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Insufficient inventory", nil)];
        }
        [self allData];
        [self.tableView.mj_header endRefreshing];  // 結束刷新
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
}

//  navigationBar按钮
- (void) setUpNavgationBar {
    static CGFloat const kButtonWidth = 90.0f;
    static CGFloat const kButtonHeight = 43.0f;
    self.cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cartButton.frame = CGRectMake(0.0f, 0.0f, kButtonWidth - 25, kButtonHeight);
    self.cartButton.backgroundColor = [UIColor clearColor];
    [self.cartButton setTitle:NSLocalizedString(@"Edit", nil) forState:UIControlStateNormal];
    self.cartButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.cartButton.titleLabel.font = ZP_TooBarFont;
    [self.cartButton addTarget:self action:@selector(onClickedSweep:) forControlEvents:UIControlEventTouchUpInside];
    self.cartButton.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    [self.cartButton.titleLabel setTextAlignment:NSTextAlignmentRight];
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.cartButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

#pragma makr -   编辑
//  编辑
- (void)onClickedSweep:(UIButton *)sup {
    sup.selected = !sup.selected;
    _bjBool = !_bjBool;
     [self.tableView reloadData];
    
    if (_bjBool) {
        [self beginEditing];
    }else{
        [self exitEditing];
    }
   
}

// UI
- (void)initUI {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, ZP_height-TabbarHeight -50-NavBarHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = ZP_Graybackground;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    [self.view addSubview:self.tableView];
    
    //   注册
    [self.tableView registerClass:[ShoppingCell class] forCellReuseIdentifier:@"shoppingCell"];
    [self.tableView registerClass:[EditorViewCell class] forCellReuseIdentifier:@"editorViewCell"];
    UIView * bottomView = [UIView new];
    bottomView.backgroundColor = ZP_textWite;
    bottomView.frame = CGRectMake(0, ZP_height - TabbarHeight - 50 - NavBarHeight, ZP_Width, 50);
    [self.view addSubview:bottomView];
    
    //   全选按钮
    self.AllButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.AllButton.layer.masksToBounds = YES;
    self.AllButton.layer.cornerRadius = self.AllButton.frame.size.height/2;
    self.AllButton.layer.borderColor = [UIColor clearColor].CGColor;
    self.AllButton.layer.borderWidth = 1;
    self.AllButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.AllButton setTitle:NSLocalizedString(@"Select", nil) forState:UIControlStateNormal];
    self.AllButton.titleLabel.font = ZP_TooBarFont;
    [self.AllButton setTitleColor:ZP_TypefaceColor forState:UIControlStateNormal];
    [self.AllButton addTarget:self action:@selector(selectaAllClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.AllButton setImage:[UIImage imageNamed:@"ic_Shopping_Choice_normal"] forState:UIControlStateNormal];
    [self.AllButton setImage:[UIImage imageNamed:@"ic_Shopping_Choice_pressed"] forState:UIControlStateSelected];
    [bottomView addSubview:self.AllButton];
    self.AllButton = self.AllButton;
    [self.AllButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(- 10); // 左边
        make.bottom.equalTo(bottomView).offset(- 15); // 下边
        make.width.mas_offset(80);
        make.height.mas_offset(20);
    }];
    
    //  总金额
    UILabel * PriceLabel = [UILabel new];
    PriceLabel.textAlignment = NSTextAlignmentLeft;
    PriceLabel.textColor = ZP_HomePreferentialpriceTypefaceCorlor;
    PriceLabel.text = @"0";
    PriceLabel.font = ZP_TooBarFont;
    [bottomView addSubview:PriceLabel];
    [PriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView).offset(- 105);
        make.bottom.equalTo(bottomView).offset(-25);
    }];
    _PriceLabel = PriceLabel;
    
    //   货币符号
    ZP_GeneralLabel * CurrencySymbolLabel = [ZP_GeneralLabel initWithtextLabel:_CurrencySymbolLabel.text textColor:ZP_TypefaceColor font:ZP_TooBarFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
//    NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"symbol"];
//    CurrencySymbolLabel.text = [NSString stringWithFormat:@"%@",str];
    CurrencySymbolLabel.text = DD_MonetarySymbol;
    [bottomView addSubview:CurrencySymbolLabel];
    [CurrencySymbolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(PriceLabel).offset(-25);
        make.top.equalTo(PriceLabel).offset(0);
    }];
    _CurrencySymbolLabel = CurrencySymbolLabel;
    
    //   合计
    ZP_GeneralLabel * StatisticsLabel = [ZP_GeneralLabel initWithtextLabel:_StatisticsLabel.text textColor:ZP_TypefaceColor font:ZP_TooBarFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    StatisticsLabel.text = NSLocalizedString(@"Total", nil);
    [bottomView addSubview:StatisticsLabel];
    [StatisticsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(CurrencySymbolLabel).offset(-20); // 左边
        make.bottom.equalTo(CurrencySymbolLabel).offset(0); // 下
    }];
    _StatisticsLabel = StatisticsLabel;
    
    //  结算按钮
    UIButton * ClearingBut = [UIButton new];
    ClearingBut.backgroundColor = ZP_pricebackground;
    [ClearingBut setTitle:NSLocalizedString(@"Clearing", nil) forState:UIControlStateNormal];
    ClearingBut.titleLabel.font = ZP_TooBarFont;
    [ClearingBut addTarget:self action:@selector(ClearingBut:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:ClearingBut];
    [ClearingBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(ZP_Width - 100);
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(bottomView).offset(0);
        make.height.mas_equalTo(50);
    }];
    _ClearingButt = ClearingBut;
    
    //    运费Label
    ZP_GeneralLabel * FreightLabel = [ZP_GeneralLabel initWithtextLabel:_FreightLabel.text textColor:ZP_TypefaceColor font:ZP_TooBarFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    FreightLabel.text = NSLocalizedString(@"Excluding freight costs", nil);
    [bottomView addSubview:FreightLabel];
    _FreightLabel = FreightLabel;
    [FreightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ClearingBut).offset(-105); // 左边
        make.top.equalTo(StatisticsLabel).offset(20); // 下
    }];
}

#pragma mark -- cell 选中
- (void)selectClick:(UIButton *)sender {
    NSInteger section = sender.tag / 100;
    NSInteger row = sender.tag % 100;
    ZP_CartsShopModel * models = self.nameArray[section];
    ZP_CartsModel * model = models.array[row];
    NSLog(@"model - %@",model.amount);
    if (models.array.count == 0) {
        return;
    }
    sender.selected =! sender.selected;
    if (!_bjBool) {
        ShoppingCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
        cell.buttom.selected = sender.selected;
    }
    else {
        EditorViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
        cell.button.selected = sender.selected;
    }
    [self updataMoneyOrNum];
}


- (void)updateData:(NSInteger)tag {
    //   更新选中数量
    _stockids = nil;
    _modelstockid = nil;
    NSInteger count = 0;
    NSInteger data = 0;
    NSInteger dataCount = 0;
    NSInteger section = tag / 100;
    NSInteger row = tag % 100;
    ZP_CartsShopModel * models = self.nameArray[section];
    ZP_CartsModel * model = models.array[row];
    for (int i = 0; i < models.array.count; i ++) {
        if (!_bjBool) {
            ShoppingCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:section]];
            if (cell.buttom.selected ) {
                dataCount += [cell.QuantityLabel.text integerValue];
                data += [cell.QuantityLabel.text integerValue] * [model.productprice floatValue];
                count ++;
                NSString * str = [NSString stringWithFormat:@"%@_%@",model.stockid,model.amount];
                if (_stockids.length > 0) {
                    _stockids = [_stockids stringByAppendingString:[NSString stringWithFormat:@",%@",str]];
                }else{
                    _stockids = str;
                }
            }
        }else{
            EditorViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            NSLog(@"---- %d",cell.button.selected);
            if (cell.button.selected ) {
                data += [cell.numLabel.text integerValue] * [model.productprice floatValue];
                dataCount += [cell.numLabel.text integerValue];
                count ++;
                NSString *str = [NSString stringWithFormat:@"%@_%@",model.stockid,model.amount];
                NSString *str1 = [NSString stringWithFormat:@"%@",model.stockid];
                if (_modelstockid.length > 0) {
                    _modelstockid = [_modelstockid stringByAppendingString:[NSString stringWithFormat:@",%@",str1]];
                }else{
                    _modelstockid = str1;
                }
                if (_stockids.length > 0) {
                    _stockids = [_stockids stringByAppendingString:[NSString stringWithFormat:@",%@",str]];
                }else{
                    _stockids = str;
                }
            }
        }
    }
    
    //每组的button
    UIButton * but = [self.view viewWithTag:666 +section];
    //每组全选
    if (count == models.array.count) {
        but.selected = YES;
    } else {
        but.selected = NO;
    }
    
    //   更新合计数据
    self.PriceLabel.text = [@(data) stringValue];
    if (_bjBool) {
        [self.ClearingButt setTitle:NSLocalizedString(@"delete", nil) forState: UIControlStateNormal];
    }else{
        if (dataCount == 0) {
            [self.ClearingButt setTitle:NSLocalizedString(@"Clearing", nil) forState: UIControlStateNormal];
        }else{
            [self.ClearingButt setTitle:[NSString stringWithFormat:NSLocalizedString(@"Clearing(%ld)", nil),(long)dataCount] forState: UIControlStateNormal];}
    }
}

- (void)updateDataa:(NSInteger)tag {
    //  更新选中数量
    _stockids = nil;
    _modelstockid = nil;
    NSInteger count = 0;
    NSInteger data = 0;
    NSInteger dataCount = 0;
    for (int i = 0; i < _dataArray.count; i ++) {
        if (!_bjBool) {
            ShoppingCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            if (cell.buttom.selected ) {
                ZP_CartsShopModel * models = self.nameArray[0];
                ZP_CartsModel * model = models.array[i];
                dataCount += [cell.QuantityLabel.text integerValue];
                data += [cell.QuantityLabel.text integerValue] * [model.productprice floatValue];
                count ++;
                NSString *str = [NSString stringWithFormat:@"%@_%@",model.stockid,model.amount];
                if (_stockids.length > 0) {
                    _stockids = [_stockids stringByAppendingString:[NSString stringWithFormat:@",%@",str]];
                }else{
                    _stockids = str;
                }
            }
        }else{
            EditorViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            ZP_CartsModel *model = _dataArray[i];
            if (cell.button.selected ) {
                data += [cell.numLabel.text integerValue] * [model.productprice floatValue];
                dataCount += [cell.numLabel.text integerValue];
                count ++;
                NSString *str = [NSString stringWithFormat:@"%@_%@",model.stockid,model.amount];
                NSString *str1 = [NSString stringWithFormat:@"%@",model.stockid];
                if (_modelstockid.length > 0) {
                    _modelstockid = [_modelstockid stringByAppendingString:[NSString stringWithFormat:@",%@",str1]];
                }else{
                    _modelstockid = str;
                }
                if (_stockids.length > 0) {
                    _stockids = [_stockids stringByAppendingString:[NSString stringWithFormat:@",%@",str]];
                }else{
                    _stockids = str;
                }
            }
        }
    }
    if (count == _dataArray.count) {
        self.Shopchoosebuttom.selected = YES;
    } else {
        self.Shopchoosebuttom.selected = NO;
    }
    
    //   更新合计数据
    self.PriceLabel.text = [@(data) stringValue];
    if (_bjBool) {
        [self.ClearingButt setTitle:NSLocalizedString(@"delete", nil) forState: UIControlStateNormal];
    }else{
        if (dataCount == 0) {
            [self.ClearingButt setTitle:NSLocalizedString(@"Clearing", nil) forState: UIControlStateNormal];
        }else{
            [self.ClearingButt setTitle:[NSString stringWithFormat:NSLocalizedString(@"Clearing(%ld)", nil),(long)dataCount] forState: UIControlStateNormal];}
    }
    allNum = dataCount;
}

#pragma mark - 结算
//  结算按钮
- (void)ClearingBut:(UIButton *)sender {
    
    if (_stockids.length > 0 || _modelstockid.length > 0) {
        if (sender.selected) {
#pragma make -- 提示框
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Prompt", nil) message:NSLocalizedString(@"Are you sure you want delete it?",nil) preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                ZPLog(@"取消");
            }];
            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Determine",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                [self shangchuBut:sender];
            }];
            [alert addAction:defaultAction];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        }else {
            if (![self YESOrNoPush]) {
                NSLog(@" duo xuan ");
                [ZPProgressHUD showErrorWithStatus:NSLocalizedString(@"Do not support additional stores for the time being", nil)];
            }else{
                ConfirmViewController * Confirm = [[ConfirmViewController alloc]init];
                Confirm.model = _model;
                Confirm.stockidsString = _stockids;
                [self.navigationController pushViewController:Confirm animated:YES];
                self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
                self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            }
        }
    }else {
        [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"You have not selected goods ", nil)];
        ZPLog(@"没选选中，不跳");
    }
}

// 设置按钮取消高亮属性
- (void)preventFlicker:(UIButton *)sender {
    sender.highlighted = NO;
}

//删除按钮（删除接口）
- (void) shangchuBut:(UIButton *)but {
    //   响应事件
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"stockid"] = _modelstockid;
    dic[@"token"] = Token;
    [ZP_shoopingTool requesscartitemdelte:dic success:^(id obj) {
        if ([obj[@"result"]isEqualToString:@"ok"]) {
            [self allData];
            [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Delete success", nil)];
        }else {
            if ([obj[@"result"]isEqualToString:@"failure"]) {
                [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"Delete failed", nil)];
            }
        }
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
    }];
}

- (BOOL)YESOrNoPush {
    NSMutableArray * selearr = [NSMutableArray array];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [self.nameArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [dic setObject:obj forKey:@(idx)];
    }];
    
    int a = 0;
    int b = 0;
    for (int j = 0; j < dic.allKeys.count; j++) {
        ZP_CartsShopModel *model = [dic objectForKey:@(j)];
        UIButton *sectionbut = [self.view viewWithTag:666 +j];
        if (sectionbut.selected) {
            a++;
        }
        for (int i = 0; i < model.array.count; i ++) {
            if (!_bjBool) {
                ShoppingCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:j]];
                if (cell.buttom.selected) {
                    b = j *200 +i;
                    [selearr addObject:@(b)];
                }
            }else {
                EditorViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:j]];
                if (cell.button.selected ) {
                    
                }else{
                    
                }
            }
        }
    }
    if (a > 1) {
        return NO;
    }
    NSNumber *d = selearr.firstObject;
    for (NSNumber *c in selearr) {
        if ([c intValue] -100 >= [d intValue]) {
            return NO;
        }
    }
    return YES;
}

#pragma mark tableviewdelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.nameArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.nameArray.count > 0) {
        ZP_CartsShopModel * model = self.nameArray[section];
        self.tableView.hidden = NO;
        self.noDataView.hidden = YES;
        NSLog(@"%ld",model.array.count);
        return model.array.count;
    }
    else{
        if (self.noDataView ) {
            self.tableView.hidden = YES;
            self.noDataView.hidden = NO;
        }
        return 0;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_bjBool == NO) {
        ShoppingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"shoppingCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果
        self.tableView.tableFooterView = [[UIView alloc] init];
        ZP_CartsShopModel * models = nil;
        if (indexPath.section < [self.nameArray count]) {
            models = [self.nameArray objectAtIndex:indexPath.section];
        }
        ZP_CartsModel * model = nil;
        if (indexPath.row < [models.array count]) {
            model = [models.array objectAtIndex:indexPath.row];
        }
        cell.buttom.tag = indexPath.section *100 + indexPath.row;
        if ([_selectAllArray containsObject:@(indexPath.row)]) {
            cell.buttom.selected = YES;
        }else{
            cell.buttom.selected = NO;
        }
        [cell.buttom addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell cellWithModel:model andIndexObject:[model.amount stringValue]];
        return cell;
    }
    else{
        static NSString * EditorID = @"editorViewCell";
        EditorViewCell * cell = [tableView dequeueReusableCellWithIdentifier:EditorID];
        if(cell == nil){
            cell = [[EditorViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:EditorID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果
        self.tableView.tableFooterView = [[UIView alloc] init];
        ZP_CartsShopModel * models = self.nameArray[indexPath.section];
        ZP_CartsModel * model = models.array[indexPath.row];
        cell.button.tag = indexPath.section *100 + indexPath.row;
        if ([_selectAllArray containsObject:@(indexPath.row)]) {
            cell.button.selected = YES;
        }else{
            cell.button.selected = NO;
        }
        [cell.button addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell cellWithModel:model];
        cell.btnClickBlock = ^(NSString *str) {
            [_selectArray replaceObjectAtIndex:indexPath.row withObject:str];
            ZPLog(@"shu liang = %@",str); //这个就是数量
            _numstr = str;
            _cardid = model.cartid;
            ZPLog(@"- num = %@,cardid = %@",_numstr,_cardid);
        };
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

// 表头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ZP_CartsShopModel * model;
    if (self.nameArray.count > 0) {
        model = self.nameArray[section];
    } else {
        return nil;
    }
    ShoppingHeadView *view = [[[NSBundle mainBundle] loadNibNamed:@"ShoppingHeadView" owner:nil options:nil] firstObject];
    view.TitleLabel.text = model.shopname;
    view.sectionAllButtion.tag = 666 + section;
    [view.sectionAllButtion addTarget:self action:@selector(sectionShop:) forControlEvents:UIControlEventTouchUpInside];
    ZPLog(@"shopname = %@",model.shopname);
    return view;
}

#pragma mark -- 表头选中
- (void)sectionShop:(UIButton *)but{
    
    // 更新选中数量
    NSInteger count = 0;
    NSInteger data = 0;
    NSInteger dataCount = 0;
    but.selected = !but.selected;
    //全选选中
    if (but.selected) {
        ZP_CartsShopModel * models = self.nameArray[but.tag - 666];
        if (!_bjBool) {
            for (int i = 0; i < models.array.count; i ++) {
                ShoppingCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:but.tag - 666]];
                cell.buttom.selected = YES;
                ZP_CartsModel * model = models.array[i];
                dataCount += [cell.QuantityLabel.text integerValue];
                data += [cell.QuantityLabel.text integerValue] * [model.productprice floatValue];
                count ++;
                NSString *str = [NSString stringWithFormat:@"%@_%@",model.stockid,model.amount];
                if (_stockids.length > 0) {
                    _stockids = [_stockids stringByAppendingString:[NSString stringWithFormat:@",%@",str]];
                }else{
                    _stockids = str;
                }
            }
            [self.ClearingButt setTitle:[NSString stringWithFormat:NSLocalizedString(@"Clearing(%ld)", nil),(long)dataCount] forState: UIControlStateNormal];
            self.PriceLabel.text = [@(data) stringValue];
            allNum = dataCount;
        }else{
            for (int i = 0; i < models.array.count; i ++) {
                EditorViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:but.tag - 666]];
                cell.button.selected = YES;
                ZP_CartsModel * model = models.array[i];
                data += [cell.numLabel.text integerValue] * [model.productprice floatValue];
                dataCount += [cell.numLabel.text integerValue];
                count ++;
                NSString *str = [NSString stringWithFormat:@"%@_%@",model.stockid,model.amount];
                NSString *str1 = [NSString stringWithFormat:@"%@",model.stockid];
                if (_modelstockid.length > 0) {
                    _modelstockid = [_modelstockid stringByAppendingString:[NSString stringWithFormat:@",%@",str1]];
                }else{
                    _modelstockid = str1;
                }
                if (_stockids.length > 0) {
                    _stockids = [_stockids stringByAppendingString:[NSString stringWithFormat:@",%@",str]];
                }else{
                    _stockids = str;
                }            }
        }
        
    }else{
        ZP_CartsShopModel * models = self.nameArray[but.tag - 666];
        if (!_bjBool) {
            
            for (int i = 0; i < models.array.count; i ++) {
                ShoppingCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:but.tag - 666]];
                cell.buttom.selected = NO;
                _stockids = nil;
            }
            [self.ClearingButt setTitle:[NSString stringWithFormat:NSLocalizedString(@"Complete", nil)] forState: UIControlStateNormal];
            self.PriceLabel.text = @"0";
            allNum = 0;
        }else{
            for (int i = 0; i < models.array.count; i ++) {
                EditorViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:but.tag - 666]];
                cell.button.selected = NO;
                _modelstockid = nil;
            }
        }
        
    }
    [self updataMoneyOrNum];
}

//  设置表头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.nameArray.count > 0) {
        ZP_CartsShopModel * model = self.nameArray[section];
        if (model.array.count > 0) {
            return 40;
        }
    }
    return 0.1;
}

// 侧滑（删除接口）
- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (@available(iOS 11.0, *)) {
        UIContextualAction *deleteAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title: NSLocalizedString(@"delete", nil) handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
            ZP_CartsShopModel * models = self.nameArray[indexPath.section];
            ZP_CartsModel * model = models.array[indexPath.row];
            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
            dic[@"stockid"] = model.stockid;
            dic[@"token"]  = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
            [ZP_shoopingTool requesscartitemdelte:dic success:^(id obj) {
                NSLog(@"%@",obj);
                [models.array removeObjectAtIndex:indexPath.row]; //接口成功啦 才成功的情况下写这一句代码-这个要在成功的时候写
                if (models.array.count == 0) {
                    [self.nameArray removeObjectAtIndex:indexPath.section];
                    self.navigationController.tabBarItem.badgeValue = nil;
                }else{
                    self.navigationController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",models.array.count];
                }
                [tableView reloadData];
                completionHandler(YES);
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];
        }];
        //也可以设置图片
        deleteAction.backgroundColor = [UIColor redColor];
        UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteAction]];
        return config;
    } else {
        return nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- 全选
- (void)selectaAllClick:(UIButton *)but{
    _stockids = nil;
    _modelstockid = nil;
    if (self.nameArray.count < 1) {
        return;
    }
    but.selected = !but.selected;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [self.nameArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [dic setObject:obj forKey:@(idx)];
    }];
    NSInteger count = 0;
    NSInteger data = 0;
    NSInteger dataCount = 0;
    for (int j = 0; j < dic.allKeys.count; j++) {
        ZP_CartsShopModel *model = [dic objectForKey:@(j)];
        UIButton *sectionbut = [self.view viewWithTag:666 +j];
        sectionbut.selected = but.selected;
        for (int i = 0; i < model.array.count; i ++) {
            if (!_bjBool) {
                ShoppingCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:j]];
                ZP_CartsModel * model2 = model.array[i];
                cell.buttom.selected = but.selected;
                if (but.selected) {
                    dataCount += [cell.QuantityLabel.text integerValue];
                    data += [cell.QuantityLabel.text integerValue] * [model2.productprice floatValue];
                    count ++;
                }else {
                    dataCount = 0;
                    data = 0;
                    count = 0;
                }
                NSString *str = [NSString stringWithFormat:@"%@_%@",model2.stockid,model2.amount];
                if (_stockids.length > 0) {
                    _stockids = [_stockids stringByAppendingString:[NSString stringWithFormat:@",%@",str]];
                }else{
                    _stockids = str;
                }
                
            }else {
                EditorViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:j]];
                ZP_CartsModel * model2 = model.array[i];
                cell.button.selected = but.selected;
                if (but.selected) {
                    data += [cell.numLabel.text integerValue] * [model2.productprice floatValue];
                    dataCount += [cell.numLabel.text integerValue];
                    count ++;
                    
                    NSString *str = [NSString stringWithFormat:@"%@_%@",model2.stockid,model2.amount];
                    NSString *str1 = [NSString stringWithFormat:@"%@",model2.stockid];
                    if (_modelstockid.length > 0) {
                        _modelstockid = [_modelstockid stringByAppendingString:[NSString stringWithFormat:@",%@",str1]];
                    }else{
                        _modelstockid = str1;
                    }
                    if (_stockids.length > 0) {
                        _stockids = [_stockids stringByAppendingString:[NSString stringWithFormat:@",%@",str]];
                    }else{
                        _stockids = str;
                    }
                }else{
                    data = 0;
                    dataCount= 0;
                    count =0;
                    
                }
//                NSString *str = [NSString stringWithFormat:@"%@_%@",model2.stockid,model2.amount];
//                NSString *str1 = [NSString stringWithFormat:@"%@",model2.stockid];
//                if (_modelstockid.length > 0) {
//                    _modelstockid = [_modelstockid stringByAppendingString:[NSString stringWithFormat:@",%@",str1]];
//                }else{
//                    _modelstockid = str1;
//                }
//                if (_stockids.length > 0) {
//                    _stockids = [_stockids stringByAppendingString:[NSString stringWithFormat:@",%@",str]];
//                }else{
//                    _stockids = str;
//                }
            }
        }
    }
    
    self.PriceLabel.text = [@(data) stringValue];
    if (_bjBool) {
        [self.ClearingButt setTitle: NSLocalizedString(@"delete", nil) forState: UIControlStateNormal];
    }else{
        if (dataCount == 0) {
            [self.ClearingButt setTitle:NSLocalizedString(@"Clearing", nil) forState: UIControlStateNormal];
        }else{
            [self.ClearingButt setTitle:[NSString stringWithFormat:NSLocalizedString(@"Clearing(%ld)", nil),(long)dataCount] forState: UIControlStateNormal];}
    }
}

- (void)updataMoneyOrNum {
    _stockids = nil;
    _modelstockid = nil;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [self.nameArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [dic setObject:obj forKey:@(idx)];
    }];
    
    NSInteger count = 0;
    NSInteger data = 0;
    NSInteger dataCount = 0;
    _AllButton.selected = YES;
    for (int j = 0; j < dic.allKeys.count; j++) {
        ZP_CartsShopModel *model = [dic objectForKey:@(j)];
        UIButton *sectionbut = [self.view viewWithTag:666 +j];
        sectionbut.selected = YES;
        for (int i = 0; i < model.array.count; i ++) {
            if (!_bjBool) {
                ShoppingCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:j]];
                ZP_CartsModel * model2 = model.array[i];
                if (cell.buttom.selected) {
                    dataCount += [cell.QuantityLabel.text integerValue];
                    data += [cell.QuantityLabel.text integerValue] * [model2.productprice floatValue];
                    count ++;
                    NSString *str = [NSString stringWithFormat:@"%@_%@",model2.stockid,model2.amount];
                    if (_stockids.length > 0) {
                        _stockids = [_stockids stringByAppendingString:[NSString stringWithFormat:@",%@",str]];
                    }else{
                        _stockids = str;
                    }
                }else {
                    sectionbut.selected = NO;
                    _AllButton.selected = NO;
                }
            }else {
                EditorViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:j]];
                ZP_CartsModel * model2 = model.array[i];
                if (cell.button.selected ) {
                    data += [cell.numLabel.text integerValue] * [model2.productprice floatValue];
                    dataCount += [cell.numLabel.text integerValue];
                    count ++;
                    NSString *str = [NSString stringWithFormat:@"%@_%@",model2.stockid,model2.amount];
                    NSString *str1 = [NSString stringWithFormat:@"%@",model2.stockid];
                    if (_modelstockid.length > 0) {
                        _modelstockid = [_modelstockid stringByAppendingString:[NSString stringWithFormat:@",%@",str1]];
                    }else{
                        _modelstockid = str1;
                    }
                    if (_stockids.length > 0) {
                        _stockids = [_stockids stringByAppendingString:[NSString stringWithFormat:@",%@",str]];
                    }else{
                        _stockids = str;
                    }
                }else{
                    sectionbut.selected = NO;
                    _AllButton.selected = NO;
                }
            }
        }
    }
    self.PriceLabel.text = [@(data) stringValue];
    if (_bjBool) {
        [self.ClearingButt setTitle: NSLocalizedString(@"delete", nil) forState: UIControlStateNormal];
    }else{
        if (dataCount == 0) {
            [self.ClearingButt setTitle:NSLocalizedString(@"Clearing", nil) forState: UIControlStateNormal];
        }else{
            [self.ClearingButt setTitle:[NSString stringWithFormat:NSLocalizedString(@"Clearing(%ld)", nil),(long)dataCount] forState: UIControlStateNormal];}
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    NSLog(@"go ");
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, 10)];
    v.backgroundColor = ZP_Graybackground;
    return v;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < [self.nameArray count]) {
        ZP_CartsShopModel * models = nil;
        ZP_CartsModel * model = nil;
        models = [self.nameArray objectAtIndex:indexPath.section];
        model = [models.array objectAtIndex:indexPath.row];
        BuyViewController * ByView = [[BuyViewController alloc]init];
        ByView.productId = model.productid;
        [self.navigationController pushViewController:ByView animated:YES];
    }
}

//  加载数据
-(void)loading{
    [ZPProgressHUD showErrorWithStatus:connectFailed toViewController:self];
    __weak typeof(self)weakSelf = self;
    [ReloadView showToView:self.view touch:^{
        [weakSelf allData];
        [ReloadView dismissFromView:weakSelf.view];
    }];
}

-(void)successful {
    [ZPProgressHUD dismiss];
}

-(void)networkProblems{
    __weak typeof(self)weakSelf = self;
    [ZPProgressHUD showErrorWithStatus:connectFailed toViewController:self];
    [ReloadView showToView:self.view touch:^{
        [weakSelf allData];
    }];
    return;
}
@end

