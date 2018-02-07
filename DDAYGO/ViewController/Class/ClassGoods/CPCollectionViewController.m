//
//  CPCollectionViewController.m
//  DDAYGO
//
//  Created by Summer on 2018/1/27.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import "CPCollectionViewController.h"
#import "CPCollectionViewCell.h"
//#import "DetailedController.h"
#import "PrefixHeader.pch"
#import "ZP_ClassViewTool.h"
#import "ClassificationViewController.h"
#import "ZP_ClassGoodsModel.h"
#import "BuyViewController.h"

#define fDeviceWidth ([UIScreen mainScreen].bounds.size.width)
#define fDeviceHeight ([UIScreen mainScreen].bounds.size.height)
@interface CPCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    int _i;
}
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray * newsData;
@property (nonatomic, strong) NoDataView * NoDataView;
@end

@implementation CPCollectionViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    [self initView];
    [self allData];
    [self addRefresh];
    [NoDataView initWithSuperView:self.view Content:nil FinishBlock:^(id response) {
        self.NoDataView = response;
        [self.collectionView reloadData];
    }];
}

- (void)initView {
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, self.view.height) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor colorWithRed:234/255. green:234/255. blue:234/255. alpha:1];
    //     每个Cell大小
    flowLayout.itemSize = CGSizeMake((fDeviceWidth - 20)/2, (fDeviceHeight - 20) / 3 + 20);
    //    横向
    flowLayout.minimumLineSpacing = 5;
    //    纵向
    flowLayout.minimumInteritemSpacing = 5;
    //    边距
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
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

// 获取数据
- (void)allData {
    NSString * str;
    if (_keyword.length > 0) {
        str = _keyword;
    }else{
        str = @"";
    }
    self.newsData = [[NSMutableArray alloc]init];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"seq"] = _priceStrTag;
    dic[@"countrycode"] = @"886";
    dic[@"word"] = str;
    dic[@"fatherid"] = _fatherId;
    dic[@"page"] = @"1";
    dic[@"pagesize"] = @"30";
    [ZP_ClassViewTool requMerchandise:dic WithIndex:self.type success:^(id obj) {
        NSDictionary * dict = obj;
        [SVProgressHUD dismiss];
        NSMutableArray * tempArray = [NSMutableArray arrayWithArray:dict[@"datalist"]];
        
        if (self.type > 0) {
            NSArray * arr ;
            arr = [tempArray sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
                if (self.type == 1) {
                    if ([obj1[@"productsale"] longValue] > [obj2[@"productsale"] longValue]) {
                        return NSOrderedAscending;
                    }
                    return NSOrderedDescending;
                } else if (self.type == 2) {
                    if ([obj1[@"productsale"] longValue] > [obj2[@"productsale"] longValue]) {
                        return NSOrderedDescending;
                    }
                    return NSOrderedAscending;
                } else {
                    if ([_priceStrTag isEqualToString:@"desc"]) {
                        if ([obj1[@"productprice"] longValue] > [obj2[@"productprice"] longValue]) {
                            return NSOrderedDescending;
                        }
                        return NSOrderedAscending;
                    } else {
                        if ([obj2[@"productprice"] longValue] > [obj1[@"productprice"] longValue]) {
                            return NSOrderedDescending;
                        }
                        return NSOrderedAscending;
                    }
                }
            }];
            self.newsData = [ZP_ClassGoodsModel arrayWithArray:arr];
        } else {
            self.newsData = [ZP_ClassGoodsModel arrayWithArray:tempArray];
        }
        
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];  // 結束下拉刷新
        [self.collectionView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        ZPLog(@"%@",error);
    }];
}
#pragma make - 创建collectionView代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.newsData.count > 0) {
        self.collectionView.hidden = NO;
        self.NoDataView.hidden = YES;
        return self.newsData.count;
    }else {
        if (self.NoDataView) {
            self.collectionView.hidden = YES;
            self.NoDataView.hidden = NO;
        }
        return 0;
    }
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
    static NSString * detaled = @"BuyViewController";
    BuyViewController * Detailed = [[BuyViewController alloc]initWithNibName:detaled bundle:nil];
    ZP_ClassGoodsModel * model = self.newsData[indexPath.row];
    Detailed.fatherId = _fatherId;
    Detailed.productId = model.productid;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:Detailed animated:YES];
}

//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(10, 10, 10, 10);
//}
// 刷新
- (void)addRefresh {
    //    下拉刷新
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.newsData removeAllObjects];
        _i = 0;
        [self allData];
    }];
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.newsData removeAllObjects];
        _i = 10;
        [self allData];
    }];
}

@end
