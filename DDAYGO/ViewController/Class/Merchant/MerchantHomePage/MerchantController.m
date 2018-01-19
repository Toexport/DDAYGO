//
//  MerchantController.m
//  DDAYGO
//
//  Created by Login on 2017/9/18.
//  Copyright © 2017年 Summer. All rights reserved.
//
#import "MerchantController.h"
#import "ZPHomeHeadrView.h"
#import "ZPHomeLayout.h"
#import "ZPHomeCell.h"
#import "ShopIntroductionViewController.h"
#import "SatisfactionSurveyController.h"
#import "Pop-upPrefixHeader.pch"
#import "PrefixHeader.pch"
#import "ZP_ClassViewTool.h"
#define JFRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define JFRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]

static NSString * ID = @"collectionViewCell";

@interface MerchantController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    
}
#define fDeviceWidth ([UIScreen mainScreen].bounds.size.width)
#define fDeviceHeight ([UIScreen mainScreen].bounds.size.height)
@property (nonatomic, strong)UIButton * btn;
@property (nonatomic, strong)UIView * views;
@property (nonatomic, strong)UIView * topView;
@property (nonatomic, strong)UIScrollView * lastView;
@property (nonatomic, strong)UILabel * line;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong)UICollectionView * bottomVC;
@property (nonatomic, strong)NSArray * array;

@end

@implementation MerchantController
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
    [self setUpNavgationBar]; //navigationBar
    [self dataUI];
    //   关闭自动调整滚动视图（不关闭图片的轮播）
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self getNetData];
    //    self.navigationController.navigationBar.hidden = YES;  //   隐藏navigationBar
    
}

- (void)dataUI {
    self.title = @"zach的小店";
    NSArray * allTitle = @[NSLocalizedString(@"销量", nil),NSLocalizedString(@"最新", nil),NSLocalizedString(@"好评", nil),NSLocalizedString(@"价格", nil)];
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, 35)];
    topView.backgroundColor = [UIColor whiteColor];
    UIView * gayLine = [[UIView alloc]initWithFrame:CGRectMake(0, topView.height - 1, ZP_Width, 1)];
    gayLine.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
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
        [topView addSubview:btn];
    }
    [self.view addSubview:topView];
    self.topView = topView;
    self.line.x = self.btn.x;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getNetData) name:@"relodMerchantDaTa" object:nil];
}

- (void)btnClickAction:(UIButton *)sender {
    NSLog(@"111");
    self.btn.selected = NO;
    sender.selected = YES;
    self.btn = sender;
    self.lastView.contentOffset = CGPointMake((sender.tag - 100) * ZP_Width, 0);
    [UIView animateWithDuration:0.2 animations:^{
        self.line.x = sender.x;
    }];
}

// 获取数据
- (void)getNetData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"supplierid"] = self.Supplieerid;
    [ZP_ClassViewTool requestGetshopinfos:dic success:^(id obj) {
        
        ZPLog(@"%@",obj);
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
    }];
}

//   懒加载
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 37, ZP_Width, ZP_height - NavBarHeight - 85) collectionViewLayout:[[ZPHomeLayout alloc] init]];
        _collectionView.backgroundColor = JFRGBColor(238, 238, 238);
        
        //    注册Cell
        [_collectionView registerClass:[ZPHomeCell class] forCellWithReuseIdentifier:ID];
        
        //   注册UICollectionReusableView即headerView（切记要添加headerView一定要先注册）
        [_collectionView registerClass:[ZPHomeHeadrView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
    
}

/*****************************************************************************************************/
/*****************************************************************************************************/

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
    return @[@"店铺简介",
             @"满意度调查",
             @"反馈",
             @"分享"];
}

- (NSArray *) images {
    return @[@"ic_shop_filesearch",
             @"icon_shop_store_left",
             @"ic_shop_edit",
             @"ic_shop_share",];
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
//            self.hidesBottomBarWhenPushed = YES;
            ShopIntroduction.SupplierID = self.Supplieerid;
            [self.navigationController pushViewController:ShopIntroduction animated:YES];
//            self.hidesBottomBarWhenPushed = NO;
        }else {
            SatisfactionSurveyController * SatisfactionSurvey = [[SatisfactionSurveyController alloc]init];
//            self.hidesBottomBarWhenPushed = YES;
            SatisfactionSurvey.sid = self.Supplieerid;
            [self.navigationController pushViewController:SatisfactionSurvey animated:YES];
            
        }
        
    }];
}

/*****************************************************************************************************/
/*****************************************************************************************************/

- (void)loadView {
    [super loadView];
    
    //   添加collectionview
    [self.view addSubview:self.collectionView];
}

#pragma mark ---UICollectionViewDataSource 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZPHomeCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
//    cell.iconName = @"Shopping";
//    cell.describe = @"芭欧芭女爵系列*透水修护疑霜50ML...";
//    cell.currentPrice = @"NT888";
//    cell.originalPrice = @"NT8888";
//    cell.TrademarkImageName = @"ic_cp";
//    cell.numberingPrice = @"6666";
    return cell;
}

//   添加headerView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ZPHomeHeadrView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];;
    //    判断上面注册的UICollectionReusableView类型
    if (kind == UICollectionElementKindSectionHeader) {
        return headerView;
        
    }else {
        return nil;
    }
}

#pragma mark ---UICollectionViewDelegate
//   设置headerView的宽高
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(self.view.bounds.size.width, 200);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.hidesBottomBarWhenPushed = YES;
    
    NSLog(@"选中%ld",(long)indexPath.item);
}

#pragma mark ---UICollectionViewDelegateFlowLayout

//   设置collectionView的cell上、左、下、右的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(14, 0, 0, 0);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"relodMerchantDaTa" object:nil];
    NSInteger tag = scrollView.contentOffset.x/ZP_Width;
    UIButton *button = [self.topView viewWithTag:tag + 100];
    self.btn.selected = NO;
    button.selected = YES;
    self.btn = button;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.line.x = button.x;
    }];
    
}

@end
