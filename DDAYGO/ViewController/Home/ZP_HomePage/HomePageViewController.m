//
//  HomePageViewController.m
//  DDAYGO
//
//  Created by Summer on 2018/1/16.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import "HomePageViewController.h"
#import "Documents.pch"
#import "Pop-upPrefixHeader.pch"
#import "ZP_HomeTool.h"
#import "ZP_PositionModel.h"
#import "myNavigationController.h"
#import "CPerViewController.h"
#import "ZP_FifthModel.h"
#import "ZP_SixthModel.h"
#import "ZP_ZeroModel.h"
#import "BuyViewController.h"
#import "CPCollectionViewController.h"
#import "DDGTool.h"
@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource> {
    int _i;
}
@property (nonatomic, strong) UIButton * chooseCityBtn;
@property (nonatomic, strong) NSArray * newsData2;
@property (nonatomic, strong) NSArray * newsData;
@property (nonatomic, strong) NSMutableArray * SixthArrData;
@property (nonatomic, strong) NSArray * postionArray;
@property (nonatomic, strong) NSArray * dataArray;
@property (nonatomic, strong) NSMutableArray * bannerArray;
@property (nonatomic, strong) NSArray * ForurthArray;
@property (nonatomic, strong) NSArray * SecondArray;
@property (nonatomic, strong) PositionView * position;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self searchBox];
    [self registration];
    [self FifthallData:CountCode];
    [self SixthAllData:CountCode];
    [self addRefresh];
    [self getadvertlist:CountCode];
    [self bestSelling:CountCode];
    [self getNewsAlldata:CountCode];
}
// UI
- (void)initUI {
    [self.view setBackgroundColor:ZP_Graybackground];
    [self.navigationController.navigationBar setBarTintColor:ZP_NavigationCorlor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)searchBox {
    //  搜索框
    ZPSearchBarBUtton * searchBar = [ZPSearchBarBUtton buttonWithType:UIButtonTypeCustom];
    searchBar.titleLabel.font = ZP_titleFont;
    searchBar.width = ZP_Width - 100;
    searchBar.height = 25;
    [searchBar setImage:[UIImage imageNamed:@"nav_menu_search"] forState:UIControlStateNormal];
    [searchBar setTitle:MyLocal(@"Searchfavorite") forState:UIControlStateNormal];
    [searchBar setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [searchBar addTarget:self action:@selector(onClikedSearchBar) forControlEvents:UIControlEventTouchUpInside];
    [searchBar setBackgroundImage:[UIImage resizedImage:@"input_home_search"] forState:UIControlStateNormal];
    searchBar.adjustsImageWhenHighlighted = NO;
    self.navigationItem.titleView = searchBar;
    
    //  位置按钮
    self.chooseCityBtn = [YLButton buttonWithType:(UIButtonTypeCustom)];
    self.chooseCityBtn.frame = CGRectMake(0, 0, 35.0f, 25.0f);
    self.chooseCityBtn.titleLabel.font = ZP_TooBarFont;
    [self.chooseCityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.chooseCityBtn setTitle:MyLocal(@"Taiwan") forState:UIControlStateNormal];
    [self.chooseCityBtn setImage:[UIImage imageNamed:@"ic_home_down"] forState:(UIControlStateNormal)];
    [self.chooseCityBtn setNeedsLayout];
    self.chooseCityBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.chooseCityBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItems = @[[[UIBarButtonItem alloc]initWithCustomView:self.chooseCityBtn]];
}

// 刷新
- (void)addRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //        [self.SixthArrData removeAllObjects];
        [self FifthallData:CountCode];  //带参数刷新
        _i = 0;
        [self allData];
        [self FifthallData:CountCode];  //带参数刷新
    }];
}

//  搜索框点击事件
- (void)onClikedSearchBar {
    SearchGooodsController * search = [SearchGooodsController new];
    myNavigationController * login = [[myNavigationController alloc]initWithRootViewController:search];
    [self presentViewController:login animated:YES completion:nil];
    ZPLog(@"搜索框");
}

//  注册
- (void)registration {
    [self.tableView registerClass:[ZeroViewCell class] forCellReuseIdentifier:@"ceaa"];
    [self.tableView registerClass:[FirstViewCell class] forCellReuseIdentifier:@"First"];
    [self.tableView registerClass:[SecondViewCell class] forCellReuseIdentifier:@"Secondcell"];
    [self.tableView registerClass:[ThirdViewCell class] forCellReuseIdentifier:@"Thirdcell"];
    [self.tableView registerClass:[FourthViewCell class] forCellReuseIdentifier:@"Fourthcell"];
    [self.tableView registerClass:[FifthViewCell class] forCellReuseIdentifier:@"ceaaa"];
    [self.tableView registerClass:[SixthViewCell class] forCellReuseIdentifier:@"Fifthcell"];
}

//  位置按钮点击事件
- (void)buttonAction:(UIButton *)sender {
    if (!DD_HASLOGIN) {
        if (![MyViewController sharedInstanceTool].hasRemind) {
            //            [MyViewController sharedInstanceTool].hasRemind = YES;
            [self PositionallData];
            
            ZPLog(@"位置");
            self.position = [[PositionView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, ZP_height)];
            //数据
            [self.position Position:_postionArray];
            //返回
            
            __weak HomePageViewController *viewController = self;
            self.position.ThirdBlock = ^(NSString *ContStr,NSNumber *code) {
                ZPLog(@"c = %@",ContStr);
                [viewController.chooseCityBtn setTitle:MyLocal(ContStr) forState:UIControlStateNormal];
                CountCode = code;
                [viewController.chooseCityBtn sizeToFit];
                
                [viewController SixthAllData:code];
                [viewController FifthallData:code];
                [[NSUserDefaults standardUserDefaults] setObject:code forKey:@"countrycode"];
            };
            //  显示
            [self.position showInView:self.navigationController.view];
        }
    } else {
        //        ZPLog(@"已登錄");
        //        [SVProgressHUD showInfoWithStatus: NSLocalizedString(@"Once logged in, no other countries will be supported", nil)];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:MyLocal(@"Do you need to go out and look at other countries' goods?") message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:MyLocal(@"ok") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [DDGTool logout];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:MyLocal(@"Cancel") style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:sureAction];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

//  定位数据
- (void)PositionallData {
    [ZP_HomeTool requesPosition:nil success:^(id obj) {
        self.postionArray= [ZP_PositionModel arrayWithArray:obj];
        [self.position Position:self.postionArray];
        ZPLog(@"%@",obj);
        
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
    }];
}

// 74) 查询广告列表(轮播图)
- (void)getadvertlist:(NSNumber *)code {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    NSNumber * sendCode;
    if ([code intValue] > 0) {
        sendCode = code;
    }else {
        sendCode = @886;
    }
    dic[@"countrycode"] = sendCode;
    dic[@"adcode"] = @"AD001";
    [ZP_HomeTool requestGetadvertlist:dic success:^(id obj) {
        ZPLog(@"%@",obj);
        self.bannerArray = [ZP_ZeroModel mj_objectArrayWithKeyValuesArray:obj];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
    }];
}

// 74) 热销商品广告列表(轮播图)
- (void)bestSelling:(NSNumber *)code {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    NSNumber * sendCode;
    if ([code intValue] > 0) {
        sendCode = code;
    }else {
        sendCode = @886;
    }
    dic[@"countrycode"] = sendCode;
    dic[@"adcode"] = @"AD004";
    [ZP_HomeTool requestGetadvertlist:dic success:^(id obj) {
        ZPLog(@"%@",obj);
        self.ForurthArray = [ZP_ZeroModel mj_objectArrayWithKeyValuesArray:obj];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
    }];
}

// 获取首页4张大图片
- (void)getNewsAlldata:(NSNumber *)code {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    NSNumber * sendCode;
    if ([code intValue] > 0) {
        sendCode = code;
    }else {
        sendCode = @886;
    }
    dic[@"countrycode"] = sendCode;
    dic[@"adcode"] = @"AD003";
    [ZP_HomeTool requestGetadvertlist:dic success:^(id obj) {
        self.SecondArray = [ZP_ZeroModel mj_objectArrayWithKeyValuesArray:obj];
        ZPLog(@"%@",obj);
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
    }];
}

//  热销商品数据
- (void)allData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
        //        [self.tableView.mj_footer endRefreshing];
    });
    [ZP_HomeTool requestSellLikeHotCakes:nil success:^(id obj) {
        ZPLog(@"%@",obj);
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];  // 結束刷新
    } failure:^(NSError *error) {
        
        ZPLog(@"%@",error);
        //        [SVProgressHUD showInfoWithStatus: NSLocalizedString(@"Server link failed", nil)];
    }];
}

// FifthAlldata
- (void)FifthallData:(NSNumber *)code {
    NSNumber * sendCode;
    if ([code intValue] > 0) {
        sendCode = code;
    }else {
        sendCode = @886;
    }
    NSDictionary * dict = @{@"count":@"6",@"countrycode":sendCode};
    [ZP_HomeTool requestSellLikeHotCakes:dict success:^(id obj) {
        ZPLog(@"%@",obj);
        NSArray * arr = obj;
        NSArray * arra = [ZP_FifthModel arrayWithArray:arr];
        if (arra.count >= 2) {
            self.newsData2 = [arra subarrayWithRange:NSMakeRange(0, 2)];
            if (arra.count >2) {
                self.newsData = [arra subarrayWithRange:NSMakeRange(2, arra.count - 2)];
            }
        }else {
            self.newsData2 = arra;
            self.newsData = arra;
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
    }];
}

// SixthArrData
- (void)SixthAllData:(NSNumber *)code {
    NSNumber * sendCode;
    if ([code intValue] > 0) {
        sendCode = code;
    }else{
        sendCode = @886;
    }
    NSDictionary * dict = @{@"acount":@"6",@"countrycode":sendCode};
    [ZP_HomeTool requSelectLikeHotCakes:dict success:^(id obj) {
        NSArray * arr = obj;
        ZPLog(@"%@",arr);
        self.SixthArrData = [ZP_SixthModel arrayWithArray:arr];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
    }];
}

#pragma mark -- tabeView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

// cell个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger number = 4;
    if (self.newsData.count > 0) {
        //        ZPLog(@"_____");
        number ++;
    }
    if (self.SixthArrData.count > 0) {
        
        number++;
    }
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.dataArray = @[@{@"title":MyLocal( @"Best-selling products")}];
    if (indexPath.section == 0) {
        static NSString * ZeroID = @"ceaa";
        ZeroViewCell * cell =  [tableView dequeueReusableCellWithIdentifier:ZeroID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.arr = self.bannerArray;
        cell.finishBlock = ^(id response) {
        };
        return cell;
    }else
        if (indexPath.section == 1){
            static NSString * FirstID = @"First";
            FirstViewCell * cell = [tableView dequeueReusableCellWithIdentifier: FirstID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果、
            cell.firstBlock = ^(NSInteger tag, NSString *name) {
                CPerViewController * CVPView = [[CPerViewController alloc]init];
                CVPView.fatherId =[NSNumber numberWithInteger:tag];
                CVPView.titleString = name;
                [self.navigationController pushViewController:CVPView animated:YES];
            };
            return cell;
            
        }else if (indexPath.section == 2){
            static NSString * SecondID = @"Secondcell";
            SecondViewCell * cell = [tableView dequeueReusableCellWithIdentifier: SecondID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果、
            [cell Second:self.SecondArray];
            cell.SecondBlock = ^(NSInteger tag){
            };
            return cell;
        }else
        /*************暂时不需要*************/
            //        if (indexPath.section == 3){
            //            static NSString * ThirdID = @"Thirdcell";
            //            ThirdViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ThirdID];
            //            cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果、
            //            cell.ThirdBlock = ^(NSInteger tag){
            //                DetailedController *viewController = [[DetailedController alloc] init];
            //                [self.navigationController pushViewController:viewController animated:YES];
            //            };
            //            [cell Third:C];
            //            return cell;
            //    }else
            if (indexPath.section == 3){
                static NSString * FourthID = @"Fourthcell";
                FourthViewCell * cell = [tableView dequeueReusableCellWithIdentifier:FourthID];
                cell.arrDara = self.newsData2;
                //            cell.arr = self.ForurthArray;
                [cell inisWithArray:self.ForurthArray];
                cell.fourthBlock1 = ^(id response) {
                    
                };
                cell.FourthBlock = ^(NSInteger tag){
                    static NSString * detaled = @"BuyViewController";
                    BuyViewController * viewController = [[BuyViewController alloc]initWithNibName:detaled bundle:nil];
                    //                DetailedController *viewController = [[DetailedController alloc] init];
                    viewController.productId = @(tag);
                    [self.navigationController pushViewController:viewController animated:YES];
                };
                cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果、
                NSDictionary * dic = self.dataArray[indexPath.row];
                [cell InformationWithDic:dic];
                return cell;
            }else
                if (indexPath.section ==4){
                    static NSString * FifthID = @"ceaaa";
                    FifthViewCell * cell = [tableView dequeueReusableCellWithIdentifier: FifthID];
                    ZPLog(@"arr == %ld",self.newsData.count);
                    cell.arrData = self.newsData;
                    ZPLog(@"cell = %ld",cell.arrData.count);
                    cell.ThirdBlock = ^(NSInteger tag) {
                        ZPLog(@"%ld",tag);
                        static NSString * detaled = @"BuyViewController";
                        BuyViewController * viewController = [[BuyViewController alloc]initWithNibName:detaled bundle:nil];
                        //                    DetailedController * viewController = [[DetailedController alloc] init];
                        viewController.productId = @(tag);
                        [self.navigationController pushViewController:viewController animated:YES];
                    };
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果、
                    return cell;
                }else {
                    static NSString * SixthID = @"Fifthcell";
                    SixthViewCell * cell = [tableView dequeueReusableCellWithIdentifier: SixthID];
                    cell.ArrData = self.SixthArrData;
                    [cell.moreBut addTarget:self action:@selector(DeleteOrderBut:) forControlEvents:UIControlEventTouchUpInside];
                    cell.ThirdBlock = ^(NSInteger tag){
                        static NSString * detaled = @"BuyViewController";
                        BuyViewController * viewController = [[BuyViewController alloc]initWithNibName:detaled bundle:nil];
                        //                DetailedController * viewController = [[DetailedController alloc] init];
                        viewController.productId = @(tag);
                        [self.navigationController pushViewController:viewController animated:YES];
                    };
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果、
                    
                    return cell;
                }
}

- (void)DeleteOrderBut:(UIButton *)sender {
    //type：0 所有精选 1 所有热销 2 闪购
    CPerViewController * CVPView = [[CPerViewController alloc]init];
    CVPView.type = 10;  //由于type默认为0，所以从首页跳进去的，type一律加10作为区分
    CVPView.titleString = MyLocal(@"More choice");
    [self.navigationController pushViewController:CVPView animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return zeroHeight;
    }else if (indexPath.section == 1) {
        return zeroHeight + 35;
    }else
        if (indexPath.section == 2){
            return ZP_Width/245*202;
        }else
            if (indexPath.section == 3) {
                return 190;
            }else if (indexPath.section == 4) {
                return ZP_Width / 4 + 35;
            }else {
                //        return (ZP_Width / 3 +35)* 2+57;
                if (self.SixthArrData.count < 5) {
                    return (ZP_Width / 3 + 45) + 30;
                } else {
                    return (ZP_Width / 3 + 45) * 2 + 30;
                }
            }
    
    ///**********暂时不需要***********/
    ////        if (indexPath.section == 3){
    ////            return 210;
    ////    }else
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    ZPLog(@"go ");
    if (section == 0) {
        return 0.0001;
    }else
        if (section == 2) {
            return 0.0001;
        }else{
            return 10.0f;
        }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, 10)];
    return v;
}
@end
