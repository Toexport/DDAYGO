//
//  HomeViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/8.
//  Copyright © 2017年 Summer. All rights reserved.
//
#import "HomeViewController.h"
#import "Documents.pch"
#import "Pop-upPrefixHeader.pch"
#import "ZP_HomeTool.h"
#import "ZP_PositionModel.h"
#import "DetailedController.h"
//#import "SelectedViewController.h"
#import "CPViewController.h"
@interface HomeViewController () <SDCycleScrollViewDelegate,UITableViewDelegate, UITableViewDataSource> {
    int _i;
    UIButton * _chooseCityBtn;
    UIScrollView * _scrollView;
    NSArray * dataArray;
}

@property(nonatomic, strong)UITableView * tableView;
//@property (nonatomic, strong)NSArray * advertisingArray;
@property (nonatomic, strong)NSMutableArray * newsData;
@property (nonatomic, strong)NSArray * postionArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self registration];
    [self searchBox];
    [self addRefresh];
    //请求位置
    [self PositionallData];
    self.tableView.separatorStyle = NO;
    [self.view setBackgroundColor:ZP_Graybackground];
//    [self.view setBackgroundColor:[UIColor yellowColor]];
    [self.navigationController.navigationBar setBarTintColor:ZP_NavigationCorlor];
    
//
    if (@available(iOS 11.0, *)){
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
       _tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);//导航栏如果使用系统原生半透明的，top设置为64
        _tableView.scrollIndicatorInsets = _tableView.contentInset;
    }
   
}

- (void)addRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.newsData removeAllObjects];
        _i = 0;
        [self allData];
    }];
    //    进入刷新
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.newsData removeAllObjects];
        _i+=10;
        [self allData];
    }];
}


- (void)initUI {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
//    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, ZP_height) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏tableview多余的线条
    self.tableView.backgroundColor = ZP_Graybackground;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(0);
    }];
}
- (void)registration {
    //  注册
    [self.tableView registerClass:[ZeroViewCell class] forCellReuseIdentifier:@"ceaa"];
    [self.tableView registerClass:[FirstViewCell class] forCellReuseIdentifier:@"First"];
    [self.tableView registerClass:[SecondViewCell class] forCellReuseIdentifier:@"Secondcell"];
    [self.tableView registerClass:[ThirdViewCell class] forCellReuseIdentifier:@"Thirdcell"];
    [self.tableView registerClass:[FourthViewCell class] forCellReuseIdentifier:@"Fourthcell"];
    [self.tableView registerClass:[FifthViewCell class] forCellReuseIdentifier:@"ceaaa"];
    [self.tableView registerClass:[SixthViewCell class] forCellReuseIdentifier:@"Fifthcell"];
}

- (void)searchBox {
    //  搜索框
    ZPSearchBarBUtton * searchBar = [ZPSearchBarBUtton buttonWithType:UIButtonTypeCustom];
    searchBar.titleLabel.font = ZP_TooBarFont;
    searchBar.width = ZP_Width -100;
    searchBar.height = 25;
    [searchBar setImage:[UIImage imageNamed:@"nav_menu_search"] forState:UIControlStateNormal];
    [searchBar setTitle:NSLocalizedString(@"Searchfavorite", nil) forState:UIControlStateNormal];
    [searchBar setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [searchBar addTarget:self action:@selector(onClikedSearchBar) forControlEvents:UIControlEventTouchUpInside];
    [searchBar setBackgroundImage:[UIImage resizedImage:@"input_home_search"] forState:UIControlStateNormal];
    searchBar.adjustsImageWhenHighlighted = NO;
    self.navigationItem.titleView = searchBar;
    
    //  位置按钮
    _chooseCityBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _chooseCityBtn.frame =CGRectMake(0, 0, 60.0f, 25.0f);
    // _chooseCityBtn.imageEdgeInsets = UIEdgeInsetsMake(6, 0, 15, 35);
    _chooseCityBtn.contentEdgeInsets = UIEdgeInsetsMake(6, -15, 6, 5);
    _chooseCityBtn.titleLabel.font = ZP_TooBarFont;
    [_chooseCityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_chooseCityBtn setTitle:NSLocalizedString(@"臺灣", nil) forState:UIControlStateNormal];
    
    
    [_chooseCityBtn setImage:[UIImage imageNamed:@"ic_home_down"] forState:(UIControlStateNormal)];
    CGFloat imageWidth = _chooseCityBtn.imageView.bounds.size.width;
    CGFloat labelWidth = _chooseCityBtn.titleLabel.bounds.size.width;
    _chooseCityBtn.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth   , 0, -labelWidth);
    _chooseCityBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
    [_chooseCityBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_chooseCityBtn];
}

//  搜索框点击事件
- (void)onClikedSearchBar {
    SearchGooodsController * search = [SearchGooodsController new];
    UINavigationController * login = [[UINavigationController alloc]initWithRootViewController:search];
//    [self.navigationController pushViewController:search animated:YES];
    [self presentViewController:login animated:YES completion:nil];
    NSLog(@"搜索框");
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
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
//        [SVProgressHUD showInfoWithStatus: NSLocalizedString(@"Server link failed", nil)];
    }];
}
#pragma mark -- tabeView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

// cell个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    dataArray = @[@{@"title":NSLocalizedString( @"Best-selling products", nil)}];
    if (indexPath.section == 0) {
        static NSString * ZeroID = @"ceaa";
        ZeroViewCell * cell = [tableView dequeueReusableCellWithIdentifier: ZeroID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果、
        cell.finishBlock = ^(id response) {
            DetailedController *viewController = [[DetailedController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
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
            cell.FourthBlock = ^(NSInteger tag){
                DetailedController *viewController = [[DetailedController alloc] init];
                viewController.productId = @(tag);
                [self.navigationController pushViewController:viewController animated:YES];
            };
            cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果、
            NSDictionary * dic = dataArray[indexPath.row];
            [cell InformationWithDic:dic];
            return cell;
    }else
        if (indexPath.section ==3){
            static NSString * FifthID = @"ceaaa";
            FifthViewCell * cell = [tableView dequeueReusableCellWithIdentifier: FifthID];
            cell.ThirdBlock = ^(NSInteger tag){
                ZPLog(@"%ld",tag);
                DetailedController *viewController = [[DetailedController alloc] init];
                viewController.productId = @(tag);
                [self.navigationController pushViewController:viewController animated:YES];
            };
            cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果、
            return cell;
    }else {
            static NSString * SixthID = @"Fifthcell";
            SixthViewCell * cell = [tableView dequeueReusableCellWithIdentifier: SixthID];
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
        return    zeroHeight;
    }else
        if (indexPath.section ==1){
//            if (_newsData.count == 0) {
//                return 0;
//            }
            return ZP_Width / 2 ;
    }else
/**********暂时不需要***********/
//        if (indexPath.section == 2){
//            return ZP_Width;
//    }else
//        if (indexPath.section == 3){
//            return 210;
//    }else
        if (indexPath.section == 2){
//            if (_newsData.count == 0) {
//                return 0;
//            }
            return 190  ;
    }else
        if (indexPath.section == 3){
/*********有问题***********/
            if (_newsData.count == 0) {
                return 0;
            }
            return ZP_Width / 4;
            
    }else {
        if (_newsData.count == 0) {
            return 0;
        }
        //下面空白应该是 35
//        return ZP_Width / 3 + 35;
        return ZP_Width / 3 * 2 + 35;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
        }
            break;
//        case 2:
//        {
//            
//        }
//            break;
//        case 3:
//        {
//            
//        }
//            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
            
        default:
            break;
    }
    NSLog(@"选中%ld",(long)indexPath.item);
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
//    return 5.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return CGFLOAT_MIN;
    NSLog(@"go ");
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, 10)];
    return v;
}




@end
