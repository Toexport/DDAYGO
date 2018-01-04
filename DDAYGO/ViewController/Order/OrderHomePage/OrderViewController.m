//
//  OrderViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/7.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "OrderViewController.h"
#import "FSScrollContentView.h"
#import "OrderViewController.h"
#import "PrefixHeader.pch"
#import "ZP_OrderController.h"
@interface OrderViewController ()<FSPageContentViewDelegate,FSSegmentTitleViewDelegate>

@property (nonatomic, strong) FSPageContentView *pageContentView;
@property (nonatomic, strong) FSSegmentTitleView *titleView;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Order", nil);
    [self.navigationController.navigationBar setBarTintColor:ZP_NavigationCorlor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    [self setUpNavgationBar];
    [self initUI];
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
//                [self allData];
    }
}

- (void)setUpNavgationBar {
    
    ZPSearchBarBUtton * searchBar = [ZPSearchBarBUtton buttonWithType:UIButtonTypeCustom];
    searchBar.width = 30;
    searchBar.height = 25;
    [searchBar setImage:[UIImage imageNamed:@"nav_menu_search"] forState:UIControlStateNormal];
    [searchBar setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [searchBar addTarget:self action:@selector(onClikedSearchBar) forControlEvents:UIControlEventTouchUpInside];
    searchBar.adjustsImageWhenHighlighted = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:searchBar];
}

- (void)initUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = ZP_WhiteColor;
    
    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 40) titles:@[NSLocalizedString(@"全部", nil),NSLocalizedString(@"待付款", nil),NSLocalizedString(@"待發貨", nil),NSLocalizedString(@"待收貨", nil),NSLocalizedString(@"評價", nil)] delegate:self indicatorType:FSIndicatorTypeEqualTitle];
    self.titleView.titleSelectFont = [UIFont systemFontOfSize:14];
    self.titleView.titleFont = [UIFont systemFontOfSize:13];
    self.titleView.titleSelectColor = [UIColor orangeColor];
    self.titleView.indicatorColor = [UIColor orangeColor];
    [self.view addSubview:_titleView];
    
    
    NSMutableArray *childVCs = [[NSMutableArray alloc]init];
    [@[NSLocalizedString(@"全部", nil),NSLocalizedString(@"待付款", nil),NSLocalizedString(@"待發貨", nil),NSLocalizedString(@"待收貨", nil),NSLocalizedString(@"評價", nil)] enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZP_OrderController *vc = [[ZP_OrderController alloc]init];

        vc.titleStr = obj;
        vc.num = idx;
        [childVCs addObject:vc];
    }];

    self.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0,  40, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.frame)  - 40) childVCs:childVCs parentVC:self delegate:self];
    
    [self.view addSubview:_pageContentView];
}

#pragma mark --
- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    NSLog(@"222 %ld- %ld",(long)endIndex,(long)startIndex);
    self.pageContentView.contentViewCurrentIndex = endIndex;
    //    self.title = self.titleView.titlesArr[endIndex];
}

- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    NSLog(@"111 %ld- %ld",(long)endIndex,(long)startIndex);
    self.titleView.selectIndex = endIndex;
    //    self.title = self.titleView.titlesArr[endIndex];
}

//  搜索框点击事件
- (void)onClikedSearchBar {
    SearchGooodsController * search = [SearchGooodsController new];
    UINavigationController * login = [[UINavigationController alloc]initWithRootViewController:search];
    [self presentViewController:login animated:YES completion:nil];
    NSLog(@"搜索框");
}

@end

