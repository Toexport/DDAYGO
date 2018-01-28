//
//  CPCollectionViewController.m
//  DDAYGO
//
//  Created by Summer on 2018/1/27.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import "CPCollectionViewController.h"
#import "CPCollectionViewCell.h"
#import "DetailedController.h"
#import "PrefixHeader.pch"
#import "ZP_ClassViewTool.h"
#import "ClassificationViewController.h"
#import "ZP_ClassGoodsModel.h"

#define fDeviceWidth ([UIScreen mainScreen].bounds.size.width)
#define fDeviceHeight ([UIScreen mainScreen].bounds.size.height)
@interface CPCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray * newsData;
@end

@implementation CPCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
    [self allData];
    [self addRefresh];
}

- (void)initView{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, self.view.height) collectionViewLayout:flowLayout];
    
    _collectionView.backgroundColor = [UIColor colorWithRed:234/255. green:234/255. blue:234/255. alpha:1];
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
    [_collectionView registerClass:[CPCollectionViewCell class] forCellWithReuseIdentifier:Cell];
    static NSString * reusableView = @"ReusableView";
 [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reusableView];
    
    //     代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;

    
    //    自适应大小
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:_collectionView];
}

- (void)allData {
    NSString *str;
    if (_keyword.length > 0) {
        str = _keyword;
    }else{
        str = @"";
    }
    self.newsData = [[NSMutableArray alloc]init];
    NSDictionary * dic = @{@"seq":@"asc",@"countrycode":@"886",@"word":str,@"fatherid":_fatherId,@"page":@"1",@"pagesize":@"30",};
    
    [ZP_ClassViewTool requMerchandise:dic WithIndex:self.type success:^(id obj) {
        // if (_newsData.count < 1) {
        NSDictionary * dict = obj;
        [SVProgressHUD dismiss];
        ZPLog(@"%@",obj);
//        self.dicts = dict[@"datalist"];
        NSArray * arr = dict[@"datalist"];
        self.newsData = [ZP_ClassGoodsModel arrayWithArray:arr];
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];  // 結束下拉刷新
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"%@",error);
        
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
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.newsData removeAllObjects];
        //   _i = 0;
        [self allData];
    }];
}

@end