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
@interface ShoppingViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerPreviewingDelegate> {
    NSInteger allNum;
    NSMutableArray * dataArray;
    NSArray * nameArray;
    BOOL _bjBool;
    NSString * _modelstockid;
    NSMutableArray * indexArray;
    NSMutableArray * selectArray;
    int _i;
}
@property(nonatomic,strong) NSMutableArray * selectAllArray;;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)ZP_ShoppingModel * model;
@property(nonatomic,strong)NSString * stockids;
@property(nonatomic,strong)NSString * numstr;  //数量
@property(nonatomic,strong)NSNumber * cardid;  //cardid



@end

@implementation ShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRefresh];
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
}

// 刷新
- (void)addRefresh {
    //    下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.selectAllArray removeAllObjects];
        _i = 0;
        [self allData];
    }];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!DD_HASLOGIN) {
        if (![MyViewController sharedInstanceTool].hasRemind) {
            [MyViewController sharedInstanceTool].hasRemind = YES;
            LogregisterController *viewcontroller = [[LogregisterController alloc] init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:viewcontroller animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
    } else {
        [self allData];
    }
}
// 获取购物车数据
- (void)allData {
    //    [ZPProgressHUD showWithStatus:loading maskType:ZPProgressHUDMaskTypeNone];
    [ZP_shoopingTool requesshoppingData:Token success:^(id obj) {
        ZPLog(@"%@",obj);
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSLog(@"go");
            [self.tableView reloadData];
            return ;
        }
        //        if (obj) {
        //            self.selectAllArray = obj;
        //            [self successful];
        //        }else{
        //            [self networkProblems];
        //        }
        //        ZPLog(@"%@",obj);
        NSArray *arr = obj;
        if (arr.count > 0) {
            NSDictionary * dic = [obj firstObject];
            _model = [ZP_ShoppingModel CreateWithDict:[obj firstObject]];
            dataArray = [ZP_CartsModel arrayWithArray:dic[@"cart"]];
            nameArray = [ZP_CartsShopModel arrayWithArray:obj];
            selectArray = [[NSMutableArray alloc]init];
            for (ZP_CartsModel * model in dataArray) {
                [selectArray addObject:model.amount];
            }
            self.navigationController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",dataArray.count];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        }else{
            NSLog(@"go");
            dataArray = nil;
            nameArray= nil;
            selectArray = nil;
            _AllButton.selected = NO;
            self.navigationController.tabBarItem.badgeValue = @"";
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
    
}

// 完成按钮
- (void)CompleteBut:(UIButton *) sender {
    //79) 修改購物車商品數量
    NSMutableDictionary * dictt = [NSMutableDictionary dictionary];
    //    ZP_CartsModel * model = [[ZP_CartsModel alloc]init];
    dictt[@"token"] = Token;
    dictt[@"cartid"] = _cardid;
    //    dictt[@"cartid"] = model.cartid;
    dictt[@"count"] = _numstr;
    [ZP_shoopingTool requestSetcartproductcount:dictt success:^(id obj) {
        ZPLog(@"%@",obj);
        if ([obj[@"result"] isEqualToString:@"stock_count_err"]) {
            [SVProgressHUD showErrorWithStatus:@"库存不足"];
        }
        [self allData];
        [self.tableView reloadData];
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
}

//  navigationBar按钮
- (void) setUpNavgationBar {
    static CGFloat const kButtonWidth = 90.0f;
    static CGFloat const kButtonHeight = 43.0f;
    UIButton *cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cartButton.frame = CGRectMake(0.0f, 0.0f, kButtonWidth - 25, kButtonHeight);
    cartButton.backgroundColor = [UIColor clearColor];
    [cartButton setTitle:NSLocalizedString(@"Edit", nil) forState:UIControlStateNormal];
    cartButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    cartButton.titleLabel.font = ZP_TooBarFont;
    [cartButton addTarget:self action:@selector(onClickedSweep:) forControlEvents:UIControlEventTouchUpInside];
    cartButton.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    //    [cartButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    //    cartButton.backgroundColor = [UIColor yellowColor];
    [cartButton.titleLabel setTextAlignment:NSTextAlignmentRight];
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cartButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

#pragma makr -   编辑
//  编辑
- (void)onClickedSweep:(UIButton *)sup {
    sup.selected = !sup.selected;
    _bjBool = !_bjBool;
    if (_bjBool == YES) {
        _StatisticsLabel.hidden = YES;
        _CurrencySymbolLabel.hidden = YES;
        _FreightLabel.hidden = YES;
        _PriceLabel.hidden = YES;
        _ClearingButt.selected = YES;
        
        [sup setTitle:NSLocalizedString(@"Complete", nil) forState:UIControlStateNormal];
        [sup addTarget:self action:@selector(CompleteBut:) forControlEvents:UIControlEventTouchUpInside];
        [self.ClearingButt setTitle:NSLocalizedString(@"delete",nil) forState: UIControlStateNormal];
    }else{
        _StatisticsLabel.hidden = NO;
        _PriceLabel.hidden = NO;
        _FreightLabel.hidden = NO;
        _CurrencySymbolLabel.hidden = NO;
        _ClearingButt.selected = NO;
        [sup setTitle:NSLocalizedString(@"Edit", nil) forState:UIControlStateNormal];
        [self.ClearingButt setTitle:NSLocalizedString(@"settlement", nil) forState: UIControlStateNormal];
    }
    [self.tableView reloadData];
}

// UI
- (void)initUI {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, ZP_height-TabbarHeight -50) style:UITableViewStylePlain];
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
    [self.AllButton addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.AllButton setImage:[UIImage imageNamed:@"ic_Shopping_Choice_normal"] forState:UIControlStateNormal];
    [self.AllButton setImage:[UIImage imageNamed:@"ic_Shopping_Choice_pressed"] forState:UIControlStateSelected];
    [bottomView addSubview:self.AllButton];
    self.AllButton = self.AllButton;
    [self.AllButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(5); // 左边
        make.bottom.equalTo(bottomView).offset(-15); // 下边
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
    
    //    货币符号
    ZP_GeneralLabel * CurrencySymbolLabel = [ZP_GeneralLabel initWithtextLabel:_CurrencySymbolLabel.text textColor:ZP_TypefaceColor font:ZP_TooBarFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"symbol"];
    CurrencySymbolLabel.text = [NSString stringWithFormat:@"%@",str];
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
        make.left.equalTo(CurrencySymbolLabel).offset(-28.5); // 左边
        make.bottom.equalTo(CurrencySymbolLabel).offset(0); // 下
    }];
    _StatisticsLabel = StatisticsLabel;
    
    //  结算按钮
    UIButton * ClearingBut = [UIButton new];
    ClearingBut.backgroundColor = ZP_pricebackground;
    [ClearingBut setTitle:NSLocalizedString(@"Clearing", nil) forState:UIControlStateNormal];
    //    [ClearingBut setTitle:NSLocalizedString(@"Delete", nil) forState:UIControlStateSelected];
    ClearingBut.titleLabel.font = ZP_TooBarFont;
    [ClearingBut addTarget:self action:@selector(ClearingBut:) forControlEvents:UIControlEventTouchUpInside];
    //    ClearingBut.enabled = NO;
    //  保证所有touch事件button的highlighted属性为NO,即可去除高亮效果
    //   [ClearingBut addTarget:self action:@selector(preventFlicker:) forControlEvents:UIControlEventAllTouchEvents];
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
    FreightLabel.text = NSLocalizedString(@"不含运费", nil);
    [bottomView addSubview:FreightLabel];
    _FreightLabel = FreightLabel;
    [FreightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ClearingBut).offset(-65); // 左边
        make.top.equalTo(StatisticsLabel).offset(20); // 下
    }];
}

//  全选
- (void)selectClick:(UIButton *)sender {
    if (dataArray.count == 0) {
        sender.selected = sender.selected;
    }else {
        sender.selected =! sender.selected;
        if (self.AllButton == sender ) {
            for (int i = 0; i < dataArray.count; i ++) {
                if (!_bjBool) {
                    ShoppingCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                    cell.buttom.selected = sender.selected;
                    if (cell.buttom.selected == YES && ![_selectAllArray containsObject:@(cell.buttom.tag)]) {
                        [_selectAllArray addObject:@(cell.buttom.tag)];
                    }else{
                        [_selectAllArray removeObject:@(cell.buttom.tag)];
                    }
                }
                else {
                    EditorViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                    cell.button.selected = sender.selected;
                    if (cell.button.selected == YES && ![_selectAllArray containsObject:@(cell.button.tag)]) {
                        [_selectAllArray addObject:@(cell.button.tag)];
                    }else{
                        [_selectAllArray removeObject:@(cell.button.tag)];
                    }
                }
            }
        } else {
            if (!_bjBool) {
                ShoppingCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
                cell.buttom.selected = sender.selected;
                if (cell.buttom.selected == YES && ![_selectAllArray containsObject:@(cell.buttom.tag)]) {
                    [_selectAllArray addObject:@(cell.buttom.tag)];
                }else{
                    [_selectAllArray removeObject:@(cell.buttom.tag)];
                }
            }else {
                EditorViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
                cell.button.selected = sender.selected;
                if (cell.button.selected == YES && ![_selectAllArray containsObject:@(cell.button.tag)]) {
                    [_selectAllArray addObject:@(cell.button.tag)];
                }else{
                    [_selectAllArray removeObject:@(cell.button.tag)];
                }
            }
        }
        [self updateData:sender.tag];
        if (_bjBool) {
            //编辑的按钮文字
            [_ClearingButt setTitle:@"删除" forState:UIControlStateNormal];
        }else{
            //不是编辑的按钮文字
            [_ClearingButt setTitle:@"结算" forState:UIControlStateNormal];
        }
    }
}

//  店铺选择按钮
- (void)ShopClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        self.AllButton.selected = YES;
    }else{
        self.AllButton.selected = NO;
    }
    if (self.Shopchoosebuttom == sender) {
        for (int i = 0; i < dataArray.count; i ++) {
            if (!_bjBool) {
                ShoppingCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                
                cell.buttom.selected = sender.selected;
                if (cell.buttom.selected == YES && ![_selectAllArray containsObject:@(cell.buttom.tag)]) {
                    [_selectAllArray addObject:@(cell.buttom.tag)];
                }else{
                    [_selectAllArray removeObject:@(cell.buttom.tag)];
                }
            }else{
                EditorViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                cell.button.selected = sender.selected;
                if (cell.button.selected == YES && ![_selectAllArray containsObject:@(cell.button.tag)]) {
                    [_selectAllArray addObject:@(cell.button.tag)];
                }else{
                    [_selectAllArray removeObject:@(cell.button.tag)];
                }
            }
        }
    } else {
        if (!_bjBool) {
            ShoppingCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
            cell.buttom.selected = sender.selected;
            if (cell.buttom.selected == YES && ![_selectAllArray containsObject:@(cell.buttom.tag)]) {
                [_selectAllArray addObject:@(cell.buttom.tag)];
            }else{
                [_selectAllArray removeObject:@(cell.buttom.tag)];
            }
        }else{
            EditorViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
            cell.button.selected = sender.selected;
            if (cell.button.selected == YES && ![_selectAllArray containsObject:@(cell.button.tag)]) {
                [_selectAllArray addObject:@(cell.button.tag)];
            }else{
                [_selectAllArray removeObject:@(cell.button.tag)];
            }
        }
    }
    [self updateDataa:sender.tag];
    if (_bjBool) {
        //编辑的按钮文字
        [_ClearingButt setTitle:@"删除" forState:UIControlStateNormal];
    }else{
        //不是编辑的按钮文字
        [_ClearingButt setTitle:@"结算" forState:UIControlStateNormal];
    }
}

- (void)updateData:(NSInteger)tag {
    //   更新选中数量
    NSInteger count = 0;
    NSInteger data = 0;
    NSInteger dataCount = 0;
    for (int i = 0; i < dataArray.count; i ++) {
        if (!_bjBool) {
            ShoppingCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            //            ZP_CartsModel *model = dataArray[i];
            if (cell.buttom.selected ) {
                ZP_CartsShopModel * models = nameArray[0];
                ZP_CartsModel *model = models.array[i];
                NSLog(@"%@-%@",model.productprice,model.amount);
                
                // data += [model.productprice floatValue]*[model.amount integerValue];
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
            ZP_CartsModel *model = dataArray[i];
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
    if (count == dataArray.count) {
        self.AllButton.selected = YES;
        self.Shopchoosebuttom.selected = YES;
    } else {
        self.AllButton.selected = NO;
        self.Shopchoosebuttom.selected = NO;
    }
    //   更新合计数据
    self.PriceLabel.text = [@(data) stringValue];
    [self.ClearingButt setTitle:[NSString stringWithFormat:@"结算(%ld)",(long)dataCount] forState: UIControlStateNormal];
}

- (void)updateDataa:(NSInteger)tag {
    //   更新选中数量
    NSInteger count = 0;
    NSInteger data = 0;
    NSInteger dataCount = 0;
    for (int i = 0; i < dataArray.count; i ++) {
        
        if (!_bjBool) {
            ShoppingCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            if (cell.buttom.selected ) {
                ZP_CartsShopModel * models = nameArray[0];
                ZP_CartsModel *model = models.array[i];
                
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
            ZP_CartsModel *model = dataArray[i];
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
    
    if (count == dataArray.count) {
        self.Shopchoosebuttom.selected = YES;
    } else {
        self.Shopchoosebuttom.selected = NO;
    }
    /**********************/
    //       更新合计数据
    
    self.PriceLabel.text = [@(data) stringValue];
    //    if (allNum >=0) {
    //        self.ClearingButt.height = NO;
    //    }else {
    [self.ClearingButt setTitle:[NSString stringWithFormat:@"结算(%ld)",(long)dataCount] forState: UIControlStateNormal];
    allNum = dataCount;
    //    }
}

#pragma mark - 结算
//  结算按钮
- (void)ClearingBut:(UIButton *)sender {
    // _stockids = nil;
    _modelstockid = nil;
    [self updateData:sender.tag];
    if ([self YESOrNoPush]) {
        if (sender.selected) {
#pragma make -- 提示框
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"確定要刪除嗎？",nil) preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                ZPLog(@"取消");
            }];
            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"確定",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                [self shangchuBut:sender];
            }];
            [alert addAction:defaultAction];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        }else {
            ConfirmViewController * Confirm = [[ConfirmViewController alloc]init];
            Confirm.model = _model;
            //            Confirm.dataArray = dataArray;
            //            Confirm.nameArray = nameArray;
            //            Confirm.PriceStr = _PriceLabel.text;
            //            Confirm.NumStr = self.ClearingButt.titleLabel.text;
            Confirm.stockidsString = _stockids;
            [self.navigationController pushViewController:Confirm animated:YES];
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        }
    }else {
        [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"You have not selected goods ", nil)];
        NSLog(@"没选选中，不跳");
    }
}
// 设置按钮取消高亮属性
- (void)preventFlicker:(UIButton *)sender {
    sender.highlighted = NO;
}

//删除按钮
- (void) shangchuBut:(UIButton *)but {
    //   响应事件
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    ZP_CartsShopModel * models = nameArray[0];
    //    ZP_CartsModel * model = models.array[but.tag];
    //    dic[@"stockid"] = model.stockid;
    //    dic[@"stockid"] = @"18,18";
    dic[@"stockid"] = _modelstockid;
    dic[@"token"] = Token;
    [ZP_shoopingTool requesscartitemdelte:dic success:^(id obj) {
        if ([obj[@"result"]isEqualToString:@"ok"]) {
            //             [models.array removeObjectAtIndex:but.tag];
            [self allData];
            [SVProgressHUD showSuccessWithStatus:@"刪除成功!"];
        }else
            if ([obj[@"result"]isEqualToString:@"failure"]) {
                [SVProgressHUD showInfoWithStatus:@"删除失敗"];
            }
        [_tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
}

- (BOOL)YESOrNoPush {
    for (int i = 0; i < dataArray.count; i ++) {
        if (!_bjBool) {
            ShoppingCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            if (cell.buttom.selected) {
                return YES;
            }
        }else{
            EditorViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            if (cell.button.selected) {
                return YES;
            }
        }
        
    }
    return NO;
}

#pragma mark tableviewdelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (nameArray.count) {
        return nameArray.count;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZP_CartsShopModel * model = nameArray[section];
    return model.array.count;
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_bjBool == NO) {
        ShoppingCell * cell = [tableView dequeueReusableCellWithIdentifier:@"shoppingCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果
        self.tableView.tableFooterView = [[UIView alloc] init];
        ZP_CartsShopModel * models = nameArray[indexPath.section];
        ZP_CartsModel * model = models.array[indexPath.row];
        cell.buttom.tag = indexPath.row;
        if ([_selectAllArray containsObject:@(indexPath.row)]) {
            cell.buttom.selected = YES;
        }else{
            cell.buttom.selected = NO;
        }
        // [cell.buttom removeTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.buttom addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        NSString * str = selectArray[indexPath.row];
        [cell cellWithModel:model andIndexObject:str];
        
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
        ZP_CartsShopModel * models = nameArray[indexPath.section];
        ZP_CartsModel *model = models.array[indexPath.row];
        cell.button.tag = indexPath.row;
        if ([_selectAllArray containsObject:@(indexPath.row)]) {
            cell.button.selected = YES;
        }else{
            cell.button.selected = NO;
        }
        
        [cell.button removeTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell cellWithModel:model];
        
        cell.btnClickBlock = ^(NSString *str) {
            [selectArray replaceObjectAtIndex:indexPath.row withObject:str];  //不清楚你这句是什么意思
            NSLog(@"shu liang = %@",str); //这个就是数量
            _numstr = str;
            _cardid = model.cartid;
            NSLog(@"- num = %@,cardid = %@",_numstr,_cardid);
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
    
    if (nameArray.count > 0) {
        model = nameArray[section];
    } else {
        return nil;
    }
    UIView * myView = [[UIView alloc]init];
    self.tableView.tableHeaderView = myView; // 表头跟着cell一起滚动
    [myView setBackgroundColor:[UIColor whiteColor]];
    
    
    //  商店选择按钮
    self.Shopchoosebuttom = [UIButton buttonWithType:UIButtonTypeCustom];
    if (self.AllButton.selected == YES) {
        self.Shopchoosebuttom.selected = YES;
    }else{
        self.Shopchoosebuttom.selected = NO;
    }
    [self.Shopchoosebuttom setImage:[UIImage imageNamed:@"ic_Shopping_Choice_normal"] forState:UIControlStateNormal];
    [self.Shopchoosebuttom setImage:[UIImage imageNamed:@"ic_Shopping_Choice_pressed"] forState:UIControlStateSelected];
    self.Shopchoosebuttom.layer.masksToBounds = YES;
    self.Shopchoosebuttom.layer.cornerRadius = self.Shopchoosebuttom.frame.size.height/2;
    self.Shopchoosebuttom.layer.borderColor = [UIColor clearColor].CGColor;
    self.Shopchoosebuttom.layer.borderWidth = 1;
    [self.Shopchoosebuttom addTarget:self action:@selector(ShopClick:) forControlEvents:UIControlEventTouchUpInside];
    [myView addSubview:self.Shopchoosebuttom];
    [self.Shopchoosebuttom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myView).offset(5);
        make.top.equalTo(myView).offset(10);
    }];
    
    //  店铺名称
    ZP_GeneralLabel * merchantsLabel = [ZP_GeneralLabel initWithtextLabel:_merchantsLabel.text textColor:ZP_TypefaceColor font:ZP_TooBarFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    merchantsLabel.text = NSLocalizedString(model.shopname, nil);
    [myView addSubview:merchantsLabel];
    [merchantsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_Shopchoosebuttom).offset(25);
        make.top.equalTo(myView).offset(15);
        make.height.mas_offset(15);
        make.width.mas_offset(80);
    }];
    _merchantsLabel = merchantsLabel;
    
    //  横线
    UIView * view0 = [UIView new];
    view0.backgroundColor = ZP_Graybackground;
    [myView addSubview:view0];
    [view0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myView).offset(5);  // 左
        make.right.equalTo(myView).offset(ZP_Width - 5); // 长
        make.bottom.equalTo(myView).offset(- 0); // 下
        make.height.mas_equalTo(1); // 高
    }];
    return myView;
}

//  设置表头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    ZP_CartsShopModel * model = nameArray[section];
    if (model.array.count > 0) {
        return 40;
    }
    return 0.1;
}

// 侧滑
- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (@available(iOS 11.0, *)) {
        UIContextualAction *deleteAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"刪除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
            //
            
            ZP_CartsShopModel * models = nameArray[indexPath.section];
            ZP_CartsModel * model = models.array[indexPath.row];
            
            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
            dic[@"stockid"] = model.stockid;
            dic[@"token"]  = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
            [ZP_shoopingTool requesscartitemdelte:dic success:^(id obj) {
                NSLog(@"%@",obj);
                [models.array removeObjectAtIndex:indexPath.row]; //接口成功啦 才成功的情况下写这一句代码-这个要在成功的时候写
                if (models.array.count == 0) {
                    nameArray = nil;
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
        // Fallback on earlier versions
        return nil;
    }
}

//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    return @"删除";
//}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        NSLog(@"go");
//        ZP_CartsModel * model = dataArray[indexPath.row];
//        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//        dic[@"stockid"] = model.stockid;
//        dic[@"token"] = Token;
//        [ZP_shoopingTool requesscartitemdelte:dic success:^(id obj) {
//
//            if ([obj[@"result"]isEqualToString:@"ok"]) {
//                [SVProgressHUD showSuccessWithStatus:@"刪除成功!"];
//            }else
//                if ([obj[@"result"]isEqualToString:@"failure"]) {
//
//                    [SVProgressHUD showInfoWithStatus:@"删除失敗"];
//                }
//        } failure:^(NSError *error) {
//            NSLog(@"%@",error);
//            //             [SVProgressHUD showInfoWithStatus:@"服務器連接失敗"];
//        }];
//
//        [dataArray removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//
//    }
//}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end

