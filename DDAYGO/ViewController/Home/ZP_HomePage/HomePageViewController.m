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
#import "DetailedController.h"
#import "myNavigationController.h"
#import "CPViewController.h"
#import "ZP_FifthModel.h"
#import "ZP_SixthModel.h"
@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource> {
     int _i;
}
@property (nonatomic, strong) UIButton * chooseCityBtn;
@property (nonatomic, strong) NSArray * newsData2;
@property (nonatomic, strong) NSArray * newsData;
@property (nonatomic, strong) NSMutableArray * SixthArrData;
@property (nonatomic, strong) NSArray * postionArray;
@property (nonatomic, strong) NSArray * dataArray;
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self searchBox];
    [self registration];
    [self FifthallData];
    [self SixthAllData];
    [self addRefresh];
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
    [searchBar setTitle:NSLocalizedString(@"Searchfavorite", nil) forState:UIControlStateNormal];
    [searchBar setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [searchBar addTarget:self action:@selector(onClikedSearchBar) forControlEvents:UIControlEventTouchUpInside];
    [searchBar setBackgroundImage:[UIImage resizedImage:@"input_home_search"] forState:UIControlStateNormal];
    searchBar.adjustsImageWhenHighlighted = NO;
    self.navigationItem.titleView = searchBar;
    
    //  位置按钮
    self.chooseCityBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.chooseCityBtn.frame =CGRectMake(0, 0, 60.0f, 25.0f);
    // _chooseCityBtn.imageEdgeInsets = UIEdgeInsetsMake(6, 0, 15, 35);
    self.chooseCityBtn.contentEdgeInsets = UIEdgeInsetsMake(6, -15, 6, 5);
    self.chooseCityBtn.titleLabel.font = ZP_stockFont;
    [self.chooseCityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.chooseCityBtn setTitle:NSLocalizedString(@"臺灣", nil) forState:UIControlStateNormal];
    [self.chooseCityBtn setImage:[UIImage imageNamed:@"ic_home_down"] forState:(UIControlStateNormal)];
    CGFloat imageWidth = self.chooseCityBtn.imageView.bounds.size.width;
    CGFloat labelWidth = self.chooseCityBtn.titleLabel.bounds.size.width;
    self.chooseCityBtn.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth , 0, -labelWidth);
    self.self.chooseCityBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
    [self.chooseCityBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.chooseCityBtn];
}
// 刷新
- (void)addRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.SixthArrData removeAllObjects];
        _i = 0;
        [self allData];
        [self FifthallData];
    }];
    
}

//  搜索框点击事件
- (void)onClikedSearchBar {
    SearchGooodsController * search = [SearchGooodsController new];
    myNavigationController * login = [[myNavigationController alloc]initWithRootViewController:search];
    [self presentViewController:login animated:YES completion:nil];
    NSLog(@"搜索框");
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
            NSLog(@"位置");
            PositionView * position = [[PositionView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, ZP_height)];
            //数据
            [position Position:_postionArray];
            //返回
            position.ThirdBlock = ^(NSString *ContStr,NSNumber *code) {
                NSLog(@"c = %@",ContStr);
                [_chooseCityBtn setTitle:NSLocalizedString(ContStr, nil) forState:UIControlStateNormal];
            };
            //  显示
            [position showInView:self.navigationController.view];
        }
    } else {
        ZPLog(@"已登錄");
        [SVProgressHUD showInfoWithStatus: NSLocalizedString(@"Once logged in, no other countries will be supported", nil)];
    }
}

//  定位数据
- (void)PositionallData {
    [ZP_HomeTool requesPosition:nil success:^(id obj) {
        _postionArray= [ZP_PositionModel arrayWithArray:obj];
        ZPLog(@"%@",_postionArray);
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
        //        [SVProgressHUD showInfoWithStatus: NSLocalizedString(@"Server link failed", nil)];
    }];
}

//  数据
- (void)allData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    });
    [ZP_HomeTool requestSellLikeHotCakes:nil success:^(id obj) {
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_header endRefreshing];  // 結束刷新
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
        //        [SVProgressHUD showInfoWithStatus: NSLocalizedString(@"Server link failed", nil)];
    }];
}

// FifthAlldata
- (void)FifthallData {
    NSDictionary * dict = @{@"count":@"5",@"countrycode":@"886"};
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
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        //        [SVProgressHUD showInfoWithStatus:@"服务器链接失败"];
    }];
}

// SixthArrData
- (void)SixthAllData {
    NSDictionary * dict = @{@"acount":@"5",@"countrycode":@"886"};
    [ZP_HomeTool requSelectLikeHotCakes:dict success:^(id obj) {
        NSArray * arr = obj;
        ZPLog(@"%@",arr);
        self.SixthArrData = [ZP_SixthModel arrayWithArray:arr];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
        //        [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"Select erchandise ach Month", nil)];
    }];
}
#pragma mark -- tabeView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

// cell个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSInteger number = 3;
    if (self.newsData.count > 0) {
        ZPLog(@"_____");
        number ++;
    }
    if (self.SixthArrData.count > 0) {
        
        number++;
    }
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.dataArray = @[@{@"title":NSLocalizedString( @"Best-selling products", nil)}];
    if (indexPath.section == 0) {
        static NSString * ZeroID = @"ceaa";
       ZeroViewCell * cell =  [tableView dequeueReusableCellWithIdentifier:ZeroID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.finishBlock = ^(id response) {
            
        };
        return cell;
    }else
        if (indexPath.section == 1){
            static NSString * FirstID = @"First";
            FirstViewCell * cell = [tableView dequeueReusableCellWithIdentifier: FirstID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果、
            cell.firstBlock = ^(NSInteger tag, NSString *name) {
                CPViewController * CVPView = [[CPViewController alloc]init];
                CVPView.fatherId =[NSNumber numberWithInteger:tag];
                CVPView.titleString = name;
                [self.navigationController pushViewController:CVPView animated:YES];
            };
            return cell;
    
        }else
    /*************暂时不需要*************/
        //        if (indexPath.section == 2){
        //            static NSString * SecondID = @"Secondcell";
        //            SecondViewCell * cell = [tableView dequeueReusableCellWithIdentifier: SecondID];
        //            cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果、
        //            cell.SecondBlock = ^(NSInteger tag){
        //                DetailedController *viewController = [[DetailedController alloc] init];
        ////                self.hidesBottomBarWhenPushed = YES;
        //                [self.navigationController pushViewController:viewController animated:YES];//                self.hidesBottomBarWhenPushed = NO;
        //            };
        //            [cell Second:B];
        //            return cell;
        //    }else
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
        if (indexPath.section == 2){
            static NSString * FourthID = @"Fourthcell";
            FourthViewCell * cell = [tableView dequeueReusableCellWithIdentifier:FourthID];
            cell.arrDara = self.newsData2;
            cell.FourthBlock = ^(NSInteger tag){
                DetailedController *viewController = [[DetailedController alloc] init];
                viewController.productId = @(tag);
                [self.navigationController pushViewController:viewController animated:YES];
            };
            cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果、
            NSDictionary * dic = self.dataArray[indexPath.row];
            [cell InformationWithDic:dic];
            return cell;
        }else
            if (indexPath.section ==3){
                static NSString * FifthID = @"ceaaa";
                FifthViewCell * cell = [tableView dequeueReusableCellWithIdentifier: FifthID];
                 cell.arrData = self.newsData;
                cell.ThirdBlock = ^(NSInteger tag) {
                    ZPLog(@"%ld",tag);
                    DetailedController * viewController = [[DetailedController alloc] init];
                    viewController.productId = @(tag);
                    [self.navigationController pushViewController:viewController animated:YES];
                };
                cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果、
                return cell;
        }else {
            
            static NSString * SixthID = @"Fifthcell";
            SixthViewCell * cell = [tableView dequeueReusableCellWithIdentifier: SixthID];
            cell.ArrData = self.SixthArrData;
            cell.ThirdBlock = ^(NSInteger tag){
                DetailedController * viewController = [[DetailedController alloc] init];
                viewController.productId = @(tag);
                [self.navigationController pushViewController:viewController animated:YES];
            };
            cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果、
            return cell;
            
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return zeroHeight;
    }else if (indexPath.section == 1) {
        return 200;
    }else if (indexPath.section == 2) {
        return 190;
    }else if (indexPath.section == 3) {
//        if (self.newsData.count == 0) {
//            ZPLog(@"_____");
//            return 0;
//        }else {
            return ZP_Width / 4;
//        }
    }else {
        return ZP_Width / 3 * 2 + 35;
        
    }
///**********暂时不需要***********/
////        if (indexPath.section == 2){
////            return ZP_Width;
////    }else
////        if (indexPath.section == 3){
////            return 210;
////    }else

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    //    return CGFLOAT_MIN;
    NSLog(@"go ");
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
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, 10)];
    return v;
}
@end
