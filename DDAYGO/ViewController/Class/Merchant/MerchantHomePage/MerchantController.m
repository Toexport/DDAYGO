//
//  MerchantController.m
//  DDAYGO
//
//  Created by Login on 2017/9/18.
//  Copyright © 2017年 Summer. All rights reserved.
//
#import "MerchantController.h"
#import "ZP_ClassViewTool.h"
#import "MerchantCollectionViewCell.h"
#import "PrefixHeader.pch"
#import "Pop-upMenuModle.h"
#import "ClassificationViewController.h"
#import "DetailedController.h"
#import "Pop-upPrefixHeader.pch"
#import "ShopIntroductionViewController.h"
#import "SatisfactionSurveyController.h"
#import "MerchantModel.h"
@interface MerchantController ()<UIScrollViewDelegate> {
    int _i;
//    NSArray * array;
}

#define fDeviceWidth ([UIScreen mainScreen].bounds.size.width)
#define fDeviceHeight ([UIScreen mainScreen].bounds.size.height)
@property (nonatomic, strong)UIButton * btn;
@property (nonatomic, strong)UIView * views;
@property (nonatomic, strong)UIView * topView;
@property (nonatomic, strong)UIScrollView * lastView;
@property (nonatomic, strong)UILabel * line;
@property (nonatomic, strong) NSMutableArray * newsarray;

@end

@implementation MerchantController
-(UILabel *)line {
    if (!_line) {
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 34, ZP_Width / 4, 1.5)];
        line.backgroundColor = [UIColor colorWithHexString:@"#e74940"];
        [self.topView addSubview:line];
        _line = line;
    }
    return _line;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRefresh];
    [self addUI];
    [self setUpNavgationBar]; //navigationBar
    [self getproductfilter:100];
    [self.navigationController.navigationBar setBarTintColor:ZP_NavigationCorlor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.navigationController.viewControllers.lastObject isKindOfClass:[ClassificationViewController class]]) {
        self.hidesBottomBarWhenPushed = NO;
    } else {
        self.hidesBottomBarWhenPushed = YES;
    }
}

// UI
-(void)addUI {
    NSArray * allTitle = @[NSLocalizedString(@"店店鋪首頁", nil),NSLocalizedString(@"最新", nil),NSLocalizedString(@"好評", nil),NSLocalizedString(@"價格", nil)];
    UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, 150)];
    _imageview = imageview;
    imageview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imageview];
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 150, ZP_Width, 35)];
    topView.backgroundColor = [UIColor whiteColor];
    UIView * gayLine = [[UIView alloc]initWithFrame:CGRectMake(0, topView.height - 1, ZP_Width, 1)];
    gayLine.backgroundColor = ZP_HUISE;
    [topView addSubview:gayLine];
    for (int i = 0; i<4; i++) {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:allTitle[i] forState:UIControlStateNormal];
        btn.frame = CGRectMake(i * (ZP_Width /4), 0, (ZP_Width /4) , 35);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont myFontOfSize:12];
    
        [btn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100 + i;
        if (i == 0) {
            _btn = btn;
            _btn.selected = YES;
        }
#warning 默认
        if (i == 3) {
//            默认图片
            [btn setImage:[UIImage imageNamed:@"icon_shop_classification_01"] forState:UIControlStateNormal];
        }
        
        [topView addSubview:btn];
    }
    [self.view addSubview:topView];
    self.topView = topView;
    self.line.x = self.btn.x;
    UIScrollView * lastView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 150+35, ZP_Width, ZP_height - 190)];
    lastView.contentSize = CGSizeMake(ZP_Width * 4, 0);
    lastView.pagingEnabled  = YES;
    lastView.showsHorizontalScrollIndicator = NO;
    lastView.delegate = self;
    [self.view addSubview:lastView];
    self.lastView = lastView;
    [self initCollectionView];
    [self addRefresh];
    [lastView addSubview:self.collectionView1];
    [lastView addSubview:self.collectionView2];
    [lastView addSubview:self.collectionView3];
    [lastView addSubview:self.collectionView4];
    
}

//75) 获取店铺信息
- (void)getshopinfos {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"supplierid"] = self.Supplieerid;
    [ZP_ClassViewTool requestGetshopinfos:dic success:^(id obj) {
        self.title = obj[@"shopname"];
//        图片本来就没有   -> 默认图片
        [self.imageview sd_setImageWithURL:[NSURL URLWithString:obj[@"shopdetail"]] placeholderImage:[UIImage imageNamed:@""]];
        ZPLog(@"%@",obj);
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
    }];
}

- (void)initCollectionView {
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView1 = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, fDeviceHeight - 200) collectionViewLayout:flowLayout];
    _collectionView2 = [[UICollectionView alloc]initWithFrame:CGRectMake(fDeviceWidth, 0, fDeviceWidth, fDeviceHeight - 200) collectionViewLayout:flowLayout];
    _collectionView3 = [[UICollectionView alloc]initWithFrame:CGRectMake(fDeviceWidth * 2, 0, fDeviceWidth, fDeviceHeight - 200) collectionViewLayout:flowLayout];
    _collectionView4 = [[UICollectionView alloc]initWithFrame:CGRectMake(fDeviceWidth * 3, 0, fDeviceWidth, fDeviceHeight - 200) collectionViewLayout:flowLayout];
    
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
    [_collectionView1 registerClass:[MerchantCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_collectionView1 registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    [_collectionView2 registerClass:[MerchantCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_collectionView2 registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    [_collectionView3 registerClass:[MerchantCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_collectionView3 registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    [_collectionView4 registerClass:[MerchantCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_collectionView4 registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    
    //        代理
    _collectionView1.delegate = self;
    _collectionView1.dataSource = self;
    _collectionView2.delegate = self;
    _collectionView2.dataSource = self;
    _collectionView3.delegate = self;
    _collectionView3.dataSource = self;
    _collectionView4.delegate = self;
    _collectionView4.dataSource = self;
    
    if (@available(iOS 11.0, *)){
        _collectionView1.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _collectionView1.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);//导航栏如果使用系统原生半透明的，top设置为64
        _collectionView1.scrollIndicatorInsets = _collectionView1.contentInset;
        
        _collectionView2.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _collectionView2.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);//导航栏如果使用系统原生半透明的，top设置为64
        _collectionView2.scrollIndicatorInsets = _collectionView2.contentInset;
        
        _collectionView3.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _collectionView3.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);//导航栏如果使用系统原生半透明的，top设置为64
        _collectionView3.scrollIndicatorInsets = _collectionView3.contentInset;
        
        _collectionView4.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _collectionView4.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);//导航栏如果使用系统原生半透明的，top设置为64
        _collectionView4.scrollIndicatorInsets = _collectionView4.contentInset;
        //
    }
    //    自适应大小
    _collectionView1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
    _collectionView2.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _collectionView3.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _collectionView4.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
}

//  navigationBar按钮
- (void) setUpNavgationBar {
    static CGFloat const kButtonWidth = 33.0f;
    static CGFloat const kButtonHeight = 43.0f;
    UIImage * cartImage = [UIImage imageNamed:@"ic_shop_dropdown"];
    UIButton *cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cartButton.frame = CGRectMake(0.0f, 0.0f, kButtonWidth, kButtonHeight);
    cartButton.backgroundColor = [UIColor clearColor];
    [cartButton setImage:cartImage forState:UIControlStateNormal];
    [cartButton addTarget:self action:@selector(onClickedSweep:) forControlEvents:UIControlEventTouchUpInside];
    cartButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cartButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;

}

- (NSArray *) titles {
    return @[@"店鋪簡介",
             @"滿意度調查"];
}

- (NSArray *) images {
    return @[@"ic_shop_filesearch",
             @"icon_shop_store_left"];
}

- (void)onClickedSweep:(UIButton *)sender {
    NSMutableArray * obj = [NSMutableArray array];
    for (NSInteger i = 0; i < [self titles].count; i ++) {
        Pop_upMenuModle * info = [Pop_upMenuModle new];
        info.image = [self images][i];
        info.title = [self titles][i];
        [obj addObject:info];
    }
    [[Pop_upMenuSingleton shareManager]showPopMenuSelecteWithFrame:200 item:obj action:^(NSInteger index) {
        NSLog(@"index:%ld",(long)index);
        if (index ==0) {
            ShopIntroductionViewController * ShopIntroduction = [[ShopIntroductionViewController alloc]init];
            ShopIntroduction.SupplierID = self.Supplieerid;
            [self.navigationController pushViewController:ShopIntroduction animated:YES];
        }else {
            SatisfactionSurveyController * SatisfactionSurvey = [[SatisfactionSurveyController alloc]init];
            SatisfactionSurvey.sid = self.Supplieerid;
            [self.navigationController pushViewController:SatisfactionSurvey animated:YES];
        }
    }];
}


- (void)btnClickAction:(UIButton *)sender {
    if (sender.tag -100 == 3) {
        sender.selected = !sender.selected;
        [self getproductfilter:sender.tag];
        self.lastView.contentOffset = CGPointMake((sender.tag -100) * ZP_Width, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.line.x = sender.x;
        }];
        if (sender.selected) {
#warning 选中
//          这里设置button 按钮 图片
            [sender setImage:[UIImage imageNamed:@"icon_shop_classification_02"] forState:UIControlStateNormal];
            NSLog(@"选择状态");
        }else{
#warning 取消选中
//          这里设置button 按钮 图片
            [sender setImage:[UIImage imageNamed:@"icon_shop_classification_03"] forState:UIControlStateNormal];
        }
    }else{
        [self getproductfilter:sender.tag];
        self.btn.selected = NO;
        sender.selected = YES;
        self.btn = sender;
        self.lastView.contentOffset = CGPointMake((sender.tag -100) * ZP_Width, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.line.x = sender.x;
            
        }];
    }
    
}

// 77) 根据大分类和子分类，获取该分类下产品，默认销量排序，支持排序最新，好评，价格
- (void)getproductfilter:(NSInteger)tag {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    dic[@"sid"] = self.Supplieerid;
//    dic[@"fathid"] = self.Supplieerid;
    dic[@"fathid"] = @"0";
//    dic[@"seq"] = @"asc";
    dic[@"word"] = @"";
    dic[@"countrycode"] = @"886";
    dic[@"page"] = @"1";
    dic[@"pagesize"] = @"30";
    switch (tag-100) {
            
        case 0:
            dic[@"sort"] = @"sale"; //销量
            break;
        case 1:
            dic[@"sort"] = @"time"; //最新
            break;
        case 2:
            dic[@"sort"] = @"review"; //好评
            break;
        case 3:
            dic[@"sort"] = @"price"; //价格
            break;
        default:
            break;
    }
    [ZP_ClassViewTool requestGetproductfilter:dic success:^(id obj) {
        ZPLog(@"%@",obj);
        NSDictionary * dict = obj;
        NSDictionary * dicct = dict[@"reviewgood"];
        NSArray * arr = dicct[@"datalist"];
        _newsarray = [MerchantModel Merchant:arr];
        switch (tag-100) {
            case 0:
                [self.collectionView1 reloadData];
                [self.collectionView1.mj_header endRefreshing];  // 結束下拉刷新
                break;
            case 1:
                [self.collectionView2 reloadData];
                [self.collectionView2.mj_header endRefreshing];  // 結束下拉刷新
                break;
            case 2:
                [self.collectionView3 reloadData];
                [self.collectionView3.mj_header endRefreshing];  // 結束下拉刷新
                break;
            case 3:
                [self.collectionView4 reloadData];
                [self.collectionView4.mj_header endRefreshing];  // 結束下拉刷新
                break;
                
            default:
                break;
        }
        
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
    }];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"relodClassDaTa" object:nil];
    NSInteger tag = scrollView.contentOffset.x/ZP_Width;
    UIButton *button = [self.topView viewWithTag:tag+100];
    self.btn.selected = NO;
    button.selected = YES;
    self.btn = button;
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//    dic[@"fathid"] = self.Supplieerid;
    switch (tag) {
        case 0:
            dic[@"sort"] = @"sale"; //销量
            break;
        case 1:
            dic[@"sort"] = @"time"; //最新
            break;
        case 2:
            dic[@"sort"] = @"review"; //好评
            break;
        case 3:
           dic[@"sort"] = @"price"; //价格
            break;
        default:
            break;
    }
    dic[@"token"] = Token;
    dic[@"sid"] = self.Supplieerid;
    //    dic[@"fathid"] = self.Supplieerid;
    dic[@"fathid"] = @"0";
//    dic[@"seq"] = @"asc";
    dic[@"word"] = @"";
    dic[@"countrycode"] = @"886";
    dic[@"page"] = @"1";
    dic[@"pagesize"] = @"30";
    [ZP_ClassViewTool requestGetproductfilter:dic success:^(id obj) {
        ZPLog(@"%@",obj);
        NSDictionary * dict = obj;
        NSDictionary * dicct = dict[@"reviewgood"];
        NSArray * arr = dicct[@"datalist"];
        _newsarray = [MerchantModel Merchant:arr];
        switch (tag) {
                case 0:
                [self.collectionView1 reloadData];
                [self.collectionView1.mj_header endRefreshing];  // 結束下拉刷新
            break;
                case 1:
                [self.collectionView2 reloadData];
                [self.collectionView2.mj_header endRefreshing];  // 結束下拉刷新
            break;
                case 2:
                [self.collectionView3 reloadData];
                [self.collectionView3.mj_header endRefreshing];  // 結束下拉刷新
            break;
                case 3:
                [self.collectionView4 reloadData];
                [self.collectionView4.mj_header endRefreshing];  // 結束下拉刷新
            break;
                
            default:
            break;
        }
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
        
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.line.x = button.x;
    }];
    
}

#pragma make - 创建collectionView代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _newsarray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identify = @"cell";
    MerchantCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    MerchantModel * model = _newsarray[indexPath.row];
    [cell merchant:model];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
    
    return headerView;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailedController * detaile = [[DetailedController alloc]init];
    [self.navigationController pushViewController:detaile animated:YES];
    NSLog(@"选中%ld",(long)indexPath.item);
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    NSLog(@"ggg");
    return CGSizeMake(ZP_Width, CGFLOAT_MIN);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    NSLog(@"ooooo");
    return CGSizeMake(ZP_Width, CGFLOAT_MIN);
}

// 刷新
- (void)addRefresh {
    self.collectionView1.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    [self.newsarray removeAllObjects];
    _i = 0;
    [self getshopinfos];
    [self getproductfilter:100];
    }];
    self.collectionView2.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.newsarray removeAllObjects];
        _i = 0;
        [self getshopinfos];
        [self getproductfilter:100];
    }];
    self.collectionView3.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.newsarray removeAllObjects];
        _i = 0;
        [self getshopinfos];
        [self getproductfilter:100];
    }];
    self.collectionView4.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.newsarray removeAllObjects];
        _i = 0;
        [self getshopinfos];
        [self getproductfilter:100];
    }];
    
}


@end
