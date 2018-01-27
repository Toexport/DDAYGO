//
//  CPViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/14.
//  Copyright © 2017年 Summer. All rights reserved.
//


#import "CPViewController.h"
#import "CPCollectionViewCell.h"
#import "DetailedController.h"
#import "PrefixHeader.pch"
#import "ZP_ClassViewTool.h"
#import "ClassificationViewController.h"
#import "ZP_ClassGoodsModel.h"
@interface CPViewController ()<UIScrollViewDelegate> {
    int _i;
    NSArray * array;
}
#define fDeviceWidth ([UIScreen mainScreen].bounds.size.width)
#define fDeviceHeight ([UIScreen mainScreen].bounds.size.height)
@property (nonatomic, strong)UIButton * btn;
@property (nonatomic, strong)UIView * views;
@property (nonatomic, strong)UIView * topView;
@property (nonatomic, strong)UIScrollView * lastView;
@property (nonatomic, strong)UILabel * line;
@property (nonatomic, strong) NSMutableArray * newsData;
@property (nonatomic, strong) NSDictionary * dicts;
@end

@implementation CPViewController

-(UILabel *)line {
    if (!_line) {
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 34, ZP_Width / 4, 1.4)];
        line.backgroundColor = [UIColor colorWithHexString:@"#e74940"];
        [self.topView addSubview:line];
        _line = line;
    }
    return _line;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self allData];
    [self addRefresh];
    [self.navigationController.navigationBar setBarTintColor:ZP_NavigationCorlor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
}

// 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = _titleString;
}

// UI
-(void)initUI {
    
    NSArray * allTitle = @[NSLocalizedString(@"Acquiescence", nil),NSLocalizedString(@"Sales Volume", nil),NSLocalizedString(@"Latest", nil),NSLocalizedString(@"Price", nil)];
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, 37)];
    topView.backgroundColor = [UIColor whiteColor];
    UIView *gayLine = [[UIView alloc]initWithFrame:CGRectMake(0, topView.height - 1, ZP_Width, 1)];
    gayLine.backgroundColor = ZP_HUISE;
    [topView addSubview:gayLine];
    
    for (int i = 0; i<4; i++) {
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:allTitle[i] forState:UIControlStateNormal];
        btn.frame = CGRectMake(i * (ZP_Width /4), 0, (ZP_Width /4) , 35);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = ZP_titleFont;
        [btn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100 + i;
        if (i == 0) {
            _btn = btn;
            _btn.selected = YES;
        }
        [topView addSubview:btn];
    }
    [self.view addSubview:topView];
    self.topView = topView;
    self.line.x = self.btn.x;
    
    UIScrollView *lastView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 37, ZP_Width, ZP_height - 37)];
    lastView.contentSize = CGSizeMake(ZP_Width * 4, 0);
    lastView.pagingEnabled  = YES;
    lastView.showsHorizontalScrollIndicator = NO;
    lastView.delegate = self;
    [self.view addSubview:lastView];
    self.lastView = lastView;
    [self initCollectionView];
    [lastView addSubview:self.collectionView1];
    [lastView addSubview:self.collectionView2];
    [lastView addSubview:self.collectionView3];
    [lastView addSubview:self.collectionView4];
    
}

// CollectionView
- (void)initCollectionView {
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView1 = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, fDeviceHeight - 101) collectionViewLayout:flowLayout];
    _collectionView2 = [[UICollectionView alloc]initWithFrame:CGRectMake(fDeviceWidth, 0, fDeviceWidth, fDeviceHeight - 101) collectionViewLayout:flowLayout];
    _collectionView3 = [[UICollectionView alloc]initWithFrame:CGRectMake(fDeviceWidth * 2, 0, fDeviceWidth, fDeviceHeight - 101) collectionViewLayout:flowLayout];
    _collectionView4 = [[UICollectionView alloc]initWithFrame:CGRectMake(fDeviceWidth * 3, 0, fDeviceWidth, fDeviceHeight - 101) collectionViewLayout:flowLayout];
    
    _collectionView1.alwaysBounceVertical = true;
    _collectionView2.alwaysBounceVertical = true;
    _collectionView3.alwaysBounceVertical = true;
    _collectionView4.alwaysBounceVertical = true;
    
    _collectionView1.backgroundColor = [UIColor colorWithRed:234/255. green:234/255. blue:234/255. alpha:1];
    _collectionView2.backgroundColor = [UIColor colorWithRed:234/255. green:234/255. blue:234/255. alpha:1];
    _collectionView3.backgroundColor = [UIColor colorWithRed:234/255. green:234/255. blue:234/255. alpha:1];
    _collectionView4.backgroundColor = [UIColor colorWithRed:234/255. green:234/255. blue:234/255. alpha:1];
//     每个Cell大小
    flowLayout.itemSize = CGSizeMake((fDeviceWidth - 20)/2, (fDeviceHeight - 20) / 3 + 20);
//    横向
    flowLayout.minimumLineSpacing = 5;
//    纵向
    flowLayout.minimumInteritemSpacing = 0;
//    边距
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 5, 5);
    
//注册cell和ReusableView（相当于头部）
    static NSString * Cell = @"cell";
    static NSString * reusableView = @"ReusableView";
    [_collectionView1 registerClass:[CPCollectionViewCell class] forCellWithReuseIdentifier:Cell];
    [_collectionView1 registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableView];
    [_collectionView2 registerClass:[CPCollectionViewCell class] forCellWithReuseIdentifier:Cell];
    [_collectionView2 registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableView];
    [_collectionView3 registerClass:[CPCollectionViewCell class] forCellWithReuseIdentifier:Cell];
    [_collectionView3 registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableView];
    [_collectionView4 registerClass:[CPCollectionViewCell class] forCellWithReuseIdentifier:Cell];
    [_collectionView4 registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableView];
    
//     代理
    _collectionView1.delegate = self;
    _collectionView1.dataSource = self;
    _collectionView2.delegate = self;
    _collectionView2.dataSource = self;
    _collectionView3.delegate = self;
    _collectionView3.dataSource = self;
    _collectionView4.delegate = self;
    _collectionView4.dataSource = self;
    
//    自适应大小
    _collectionView1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
    _collectionView2.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _collectionView3.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _collectionView4.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
}

- (void)btnClickAction:(UIButton *)sender {
    [self allData];
    self.btn.selected = NO;
    sender.selected = YES;
    self.btn = sender;
    self.lastView.contentOffset = CGPointMake((sender.tag - 100) * ZP_Width, 0);
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.line.x = sender.x;
        
    }];
}
//  数据
- (void)allData {
    NSString *str;
    if (_keyword.length > 0) {
        str = _keyword;
    }else{
        str = @"";
    }
    NSDictionary * dic = @{@"seq":@"desc",@"countrycode":@"886",@"word":str,@"fatherid":_fatherId,@"page":@"1",@"pagesize":@"30",};

    [ZP_ClassViewTool requMerchandise:dic WithIndex:0 success:^(id obj) {
        if (_newsData.count < 1) {
            NSDictionary * dict = obj;
            [SVProgressHUD dismiss];
            ZPLog(@"%@",obj);
            self.dicts = dict[@"datalist"];
            NSArray * arr = dict[@"datalist"];
            self.newsData = [ZP_ClassGoodsModel arrayWithArray:arr];
        }else{
            return ;
//        NSLog(@"%ld",(unsigned long)arr.count);
        }
        [self.collectionView1 reloadData];
        [self.collectionView2 reloadData];
        [self.collectionView3 reloadData];
        [self.collectionView4 reloadData];
        [self.collectionView1.mj_header endRefreshing];  // 結束下拉刷新
        [self.collectionView2.mj_header endRefreshing];  // 結束下拉刷新
        [self.collectionView3.mj_header endRefreshing];  // 結束下拉刷新
        [self.collectionView4.mj_header endRefreshing];  // 結束下拉刷新
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"%@",error);

    }];

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    NSLog(@"go");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"relodClassDaTa" object:nil];
    NSInteger tag = scrollView.contentOffset.x/ZP_Width;
    UIButton * button = [self.topView viewWithTag:tag + 100];
    self.btn.selected = NO;
    button.selected = YES;
    self.btn = button;
    
//    NSDictionary * dic =@{@"fatherid":_fatherId,@"seq":@"desc",@"word":@"",@"countrycode":@"886",@"page":@"1",@"pagesize":@"10"};
    NSMutableDictionary * dic  = [NSMutableDictionary dictionary];
//    NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"countrycode"];
    dic[@"fatherid"] = _fatherId;
    dic[@"seq"] = @"desc";
    NSString *str;
    if (_keyword.length > 0) {
        str = _keyword;
    }else{
        str = @"";
    }
    dic[@"word"] = str;
    dic[@"countrycode"] = @"886";
//    dic[@"sort"] = @"price";
    dic[@"page"] = @"1";
    dic[@"pagesize"] = @"30";
    [ZP_ClassViewTool requMerchandise:dic WithIndex:tag success:^(id obj) {
        [SVProgressHUD dismiss];
//        NSLog(@"obj = %@",obj);
        NSDictionary * dict = obj;
        self.dicts = dict[@"datalist"];
        NSArray * arr = dict[@"datalist"];
        self.newsData = [ZP_ClassGoodsModel arrayWithArray:arr];
        switch (tag) {
            case 0:
            [self.collectionView1 reloadData];
                break;
            case 1:
            [self.collectionView2 reloadData];
                break;
            case 2:
            [self.collectionView3 reloadData];
                break;
            case 3:
            [self.collectionView4 reloadData];
                break;
                
            default:
                break;
        }
//
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
//        [SVProgressHUD showInfoWithStatus:@"服務器連接失敗"];
        NSLog(@"%@",error);
        
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        ZPLog(@"%f-%f",self.line.x,button.x);
        self.line.x = button.x;
    }];
    
}

#pragma make - 创建collectionView代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.newsData.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZP_ClassGoodsModel * model = nil;
    if (indexPath.row < [self.newsData count]) {
        model = [self.newsData objectAtIndex:indexPath.row];
    }
    static NSString * identify = @"cell";
    CPCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
//    ZP_ClassGoodsModel * model = self.newsData[indexPath.row];
    [cell cellWithdic:model];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ZP_ClassGoodsModel * model = nil;
    if (indexPath.row > [self.newsData count]) {
        model = [self.newsData objectAtIndex:indexPath.row];
    }
    static NSString * header = @"ReusableView";
    UICollectionReusableView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:header forIndexPath:indexPath];
    return headerView;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * detaled = @"DetailedController";
    DetailedController * Detailed = [[DetailedController alloc]initWithNibName:detaled bundle:nil];
    ZP_ClassGoodsModel * model = self.newsData[indexPath.row];
    Detailed.fatherId = _fatherId;
    Detailed.productId = model.productid;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:Detailed animated:YES];
}

// 刷新
- (void)addRefresh {
    //    下拉刷新
    self.collectionView1.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.newsData removeAllObjects];
        _i = 0;
        [self allData];
    }];
    self.collectionView2.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.newsData removeAllObjects];
        _i = 0;
        [self allData];
    }];
    self.collectionView3.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.newsData removeAllObjects];
        _i = 0;
        [self allData];
    }];
    self.collectionView4.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.newsData removeAllObjects];
        _i = 0;
        [self allData];
    }];
}

-(void)loading{
    [ZPProgressHUD showErrorWithStatus:connectFailed toViewController:self];
    __weak typeof(self)weakSelf = self;
    [ReloadView showToView:self.view touch:^{
        [weakSelf allData];
        [ReloadView dismissFromView:weakSelf.view];
    }];
}

-(void)successful {
    [self.collectionView1 reloadData];
    [self.collectionView2 reloadData];
    [self.collectionView3 reloadData];
    [self.collectionView4 reloadData];
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
