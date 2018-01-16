//
//  HomePageViewController.m
//  DDAYGO
//
//  Created by Summer on 2018/1/16.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import "HomePageViewController.h"
#import "PrefixHeader.pch"
#import "myNavigationController.h"
#import "ZP_HomeTool.h"
#import "ZP_PositionModel.h"
@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIButton * chooseCityBtn;
@property (nonatomic, strong) NSArray * postionArray;
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self searchBox];
}
// UI
- (void)initUI {
    [self.view setBackgroundColor:ZP_Graybackground];
    [self.navigationController.navigationBar setBarTintColor:ZP_NavigationCorlor];
}

- (void)searchBox {
    //  搜索框
    ZPSearchBarBUtton * searchBar = [ZPSearchBarBUtton buttonWithType:UIButtonTypeCustom];
    searchBar.titleLabel.font = ZP_TooBarFont;
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
    self.chooseCityBtn.titleLabel.font = ZP_TooBarFont;
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

//  搜索框点击事件
- (void)onClikedSearchBar {
    SearchGooodsController * search = [SearchGooodsController new];
    myNavigationController * login = [[myNavigationController alloc]initWithRootViewController:search];
    [self presentViewController:login animated:YES completion:nil];
    NSLog(@"搜索框");
}
// 
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
@end
