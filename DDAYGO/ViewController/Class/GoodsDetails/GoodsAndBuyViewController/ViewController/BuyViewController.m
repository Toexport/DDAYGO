//
//  BuyViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/14.
//  Copyright © 2017年 Summer. All rights reserved.
//

/*******框架头文件********/
#import "BuyViewController.h"
#import "global.h"
#import "BuyTopView.h"
#import "BuyMiddleView.h"
#import "MyOrderTopTabBar.h"
#import "NaviBase.h"

#define TopViewH 484
#define MiddleViewH 30
#define BottomH 52
#define SecondPageTop 534
#define TopTabBarH [global pxTopt:100]
#define NaviBarH 64.0

/*******源数据头文件********/
#import "DetailedViewCell.h"
#import "TextdetailsViewCell.h"
#import "MerchantController.h"
#import "PrefixHeader.pch"
#import "ZP_ClassViewTool.h"
#import "ShopIntroductionViewController.h"
#import "ProductDescriptionView.h"
#import "ShoppingViewController.h"
#import "PurchaseView.h"
#import "UIImageView+WebCache.h"
#import "ZP_GoodDetailsModel.h"
#import "PurchaseView.h"
#import "ConfirmViewController.h"
#import "ProductTableViewCell.h"
#import "EvaluateTableViewCell.h"
#import "MainViewController.h"

@interface BuyViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,MyOrderTopTabBarDelegate>

/*********框架属性*********/
@property(nonatomic,weak)MyOrderTopTabBar* TopTabBar;
@property (weak, nonatomic) UIScrollView * MyScrollView;
@property (weak, nonatomic) BuyTopView* topView;
@property (weak, nonatomic) BuyMiddleView* middleView;
@property (strong, nonatomic) UITableView* detailTableview;
@property (assign, nonatomic)float TopViewScale;

/********源文件属性********/
//**Xib 拖过来然后填写数据**/
@property (nonatomic, strong)UIImageView * ShopImageView;
@property (nonatomic, strong) NSArray * array;
@property (nonatomic, strong) UIWindow * window;
@property (nonatomic, strong) ProductDescriptionView * productDescriptionView;
@property (nonatomic, strong) PurchaseView * purchaseView;
@property (nonatomic ,strong) NSMutableArray * newsData;
@property (nonatomic, strong) ZP_GoodDetailsModel * model;


@property (nonatomic, strong) NSArray * normsArr;
@property (nonatomic, strong) NSArray * typeArr;
@property (nonatomic, strong) NSArray * pjArr;
@property (nonatomic, strong) NSMutableArray * productArray;
@property (nonatomic, strong) NSMutableArray * textdetaArray;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cpsmHeight;
@property (nonatomic, strong) NSMutableArray *evaluateArray;
@property (nonatomic, assign) NSInteger imageHeight;  //详情图片的高度
@property (nonatomic, strong) NSMutableDictionary *imageDic;  //详情图片的高度
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation BuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.evaluateArray = [NSMutableArray array];
    [self initFrameWords];
    [self initSource];
}

- (void)initSource {
    [self.detailTableview registerNib:[UINib nibWithNibName:@"ProductTableViewCell" bundle:nil] forCellReuseIdentifier:@"ProductTableViewCell"];
    [self.detailTableview registerNib:[UINib nibWithNibName:@"EvaluateTableViewCell" bundle:nil] forCellReuseIdentifier:@"EvaluateTableViewCell"];
    self.detailTableview.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏tableview多余的线条
    self.detailTableview.rowHeight=UITableViewAutomaticDimension;//高度设置为自适应
    [self allData];
//    [self evaluation];
    self.titleLabel.text = self.title ? self.title : @"商品详情";
    self.navigationController.navigationBar.hidden = YES;
    self.shfwBottomView.hidden = YES;
    self.qbpjBottomView.hidden = YES;
    [self.view bringSubviewToFront:self.headView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    [self.shoucangBtn resizeWithDistance:5];
    [self.gouwuBtn resizeWithDistance:5];
    [self.dianpuBtn resizeWithDistance:5];
}

- (IBAction)clickBackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//updateViewConstraints
- (void)getimageData {
    if (_normsArr.count > 0) {
        NSLog(@"%ld",_normsArr.count);
        self.onScrollViewWidth.constant = ZP_Width * _normsArr.count;
        for (int i = 0; i < _normsArr.count; i ++) {
            ZP_GoodDetailsModel *model = _normsArr[i];
            _ShopImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ZP_Width * i, 0, ZP_Width, self.onScrollView.height)];
            [_ShopImageView sd_setImageWithURL:[NSURL URLWithString:model.cnimg] placeholderImage:[UIImage imageNamed:@""]];
            [self.onScrollView addSubview:_ShopImageView];
        }
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.smallScrollView.center.x - 19.5, self.smallScrollView.size.height - 37, 39, 37)];
        self.pageControl.numberOfPages = _normsArr.count;
        self.pageControl.currentPage = 0;
        [self.scrollView addSubview:self.pageControl];
        
    }
    else{
        self.onScrollViewWidth.constant = ZP_Width * 1;
        for (int i = 0; i < 1; i ++) {
            _ShopImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ZP_Width * i, 0, ZP_Width, self.onScrollView.height)];
            [self.onScrollView addSubview:_ShopImageView];
        }
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.smallScrollView.center.x - 19.5, self.smallScrollView.size.height - 37, 39, 37)];
        self.pageControl.numberOfPages = 1;
        self.pageControl.currentPage = 0;
        [self.scrollView addSubview:self.pageControl];
        [self.shoucangBtn resizeWithDistance:5];
        [self.gouwuBtn resizeWithDistance:5];
        [self.dianpuBtn resizeWithDistance:5];
    }
    
}

// 获取数据
- (void)allData {
    if (nil == _productId) {
        return;
    }
    NSDictionary * dic;
    self.imageDic = [NSMutableDictionary dictionary];
    if (Token) {
        
        dic = @{@"productid":_productId,@"token":Token};
    } else {
        dic = @{@"productid":_productId,@"token":@""};
    }
    [ZP_ClassViewTool requDetails:dic success:^(id obj) {
        if (obj) {
            self.productArray = obj;
        }else{
            [self networkProblems];
        }
        ZPLog(@"%@",obj);
        NSDictionary * asdic = [obj[@"productdetail"] firstObject];
        NSString * asdtring = asdic[@"content"];
        self.productArray = [asdtring componentsSeparatedByString:@","];
        NSDictionary * tempDic = @{@"productid":_productId,@"page":@(1),@"pagesize":@(5)};
        [ZP_ClassViewTool requEvaluates:tempDic success:^(id obj) {
//            NSArray *tempArray = obj[@"reviewslist"][@"ReviewsData"];
//            self.evaluateArray = [EvaluateModel mj_keyValuesArrayWithObjectArray:obj[@"reviewslist"][@"ReviewsData"]];
            self.evaluateArray = [EvaluateModel mj_objectArrayWithKeyValuesArray:obj[@"reviewslist"][@"ReviewsData"]];
            
            [self successful];
            NSLog(@"%@",obj);
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        ZP_GoodDetailsModel * model = [ZP_GoodDetailsModel getGoodDetailsData:obj[@"products"][0]];
        _shoucangBtn.selected = [model.state boolValue];
        [self.topView updateInfoWithModel:model];
        NSString *value = [obj objectForKey:@"colornorms"];
        if ((NSNull *)value == [NSNull null]) {
        }else {
            NSArray *colorArr = obj[@"colornorms"];
            if (colorArr.count > 0) {
                _normsArr = [ZP_GoodDetailsModel arrayWithArray:obj[@"colornorms"]];
                _typeArr = [ZP_GoodDetailsModel arrayWithTypeArray:obj[@"colornorms"]];
                [self getimageData];
            }
        }
        _model = model;
    } failure:^(NSError * error) {
        [self loading];
        ZPLog(@"%@", error);
    }];
}

- (void)getRightItemDataWithProducttypeid:(NSInteger)producttypeid {
    NSDictionary * dictt = @{@"productid":@"2",@"fatherid":[@(producttypeid + 1) stringValue]};
    [ZP_ClassViewTool requClassIficationrj:dictt success:^(id obj) {
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
    }];
}

#pragma mark  - - 收藏
- (void)extracted:(UIButton *)sender {
    DD_CHECK_HASLONGIN;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"productid"] = _model.productid;
    dic[@"token"] = Token;
    if (!sender.selected) {
//收藏
    [ZP_ClassViewTool requshoucang:dic success:^(id obj) {
        sender.selected = !sender.selected;
        if ([obj[@"result"]isEqualToString:@"ok"]) {
            [SVProgressHUD showSuccessWithStatus:@"收藏成功!"];
        }else
            if ([obj[@"result"]isEqualToString:@"collected"]) {
                [SVProgressHUD showInfoWithStatus:@"已收藏"];
        }else
             if ([obj[@"result"]isEqualToString:@"failure"]) {
                 [SVProgressHUD showInfoWithStatus:@"操作失败"];
        }
    } failure:^(NSError *error) {
        NSLog(@"error %@",error);
    }];
  }else{
    //取消收藏
    [ZP_ClassViewTool requCancelshoucang:dic success:^(id obj) {
        sender.selected = !sender.selected;
        if ([obj[@"result"]isEqualToString:@"ok"]) {
            [SVProgressHUD showSuccessWithStatus:@"取消成功!"];
        }else
            if ([obj[@"result"]isEqualToString:@"count"]) {
                [SVProgressHUD showInfoWithStatus:@"0"];
        }else
            if ([obj[@"result"]isEqualToString:@"failure"]) {
                [SVProgressHUD showInfoWithStatus:@"操作失败"];
        }
    } failure:^(NSError *error) {
        NSLog(@"error %@",error);
    }];
    }
}

- (IBAction)shoucangAction:(UIButton *)sender {
    [self extracted:sender];
}

- (IBAction)ShoppingCartAction:(id)sender {
    DD_CHECK_HASLONGIN;
    [self.navigationController popToRootViewControllerAnimated:NO];
    if ([[[UIApplication sharedApplication] keyWindow].rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController * tbvc  = [[UIApplication sharedApplication] keyWindow].rootViewController;
        [tbvc setSelectedIndex:2];
    }
}

// 商家按钮
- (IBAction)dianpuAction:(id)sender {
//    DD_CHECK_HASLONGIN;
    MerchantController * Merchant = [[MerchantController alloc]init];
    Merchant.Supplieerid = self.model.supplierid;
    Merchant.fatherId = _fatherId;
    [self.navigationController pushViewController:Merchant animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
}

//- (IBAction)xzflAction:(UIButton *)sender {
//    DD_CHECK_HASLONGIN;
//    if (!self.purchaseView) {
//        static NSString * purchasseID = @"PurchaseView";
//        self.purchaseView = [[NSBundle mainBundle] loadNibNamed:purchasseID owner:self options:nil].firstObject;
//        self.purchaseView.frame = self.view.frame;
//        self.purchaseView.model = _model;
//        self.purchaseView.modeltypeArr = _typeArr;
//        self.purchaseView.modelArr = _normsArr;
//        [self.view addSubview:self.purchaseView];
//    }
//    [self.purchaseView show:^(id response) {
//        NSLog(@"re = %@",response);
//        [self.middleView.xzflBtn setTitle:response forState:UIControlStateNormal];
//    }];
//    __weak typeof(self) _weakSelf = self;
//    self.purchaseView.finishBtnBlock = ^(id response) {
//        NSLog(@"go");
//        _weakSelf.hidesBottomBarWhenPushed = YES;
//        _weakSelf.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
//        _weakSelf.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//        [_weakSelf.navigationController pushViewController:response animated:YES];
//    };
//}
//
//
//- (IBAction)cpsmAction:(UIButton *)sender {
//    DD_CHECK_HASLONGIN;
//    if (!self.productDescriptionView) {
//        self.productDescriptionView = [[NSBundle mainBundle] loadNibNamed:@"ProductDescriptionView" owner:self options:nil].firstObject;
//        self.productDescriptionView.frame = self.view.frame;
//        [self.view addSubview:self.productDescriptionView];
//    }
//    [self.productDescriptionView show];
//}

//立即购买
- (IBAction)ligmAction:(UIButton *)sender {
    DD_CHECK_HASLONGIN;
    if (!self.purchaseView) {
        static NSString * purchasseID = @"PurchaseView";
        self.purchaseView = [[NSBundle mainBundle] loadNibNamed:purchasseID owner:self options:nil].firstObject;
        self.purchaseView.frame = self.view.frame;
        NSLog(@"%@",_model.productamount);
        self.purchaseView.model = _model;
        self.purchaseView.modeltypeArr = _typeArr;
        self.purchaseView.modelArr = _normsArr;
        [self.view addSubview:self.purchaseView];
    }
    [self.purchaseView show:^(id response) {
        [self.middleView.xzflBtn setTitle:response forState:UIControlStateNormal];
    }];
    __weak typeof(self) _weakSelf = self;
    self.purchaseView.finishBtnBlock = ^(id response) {
        NSLog(@"go");
        _weakSelf.hidesBottomBarWhenPushed = YES;
        _weakSelf.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:_weakSelf action:nil];  // 隐藏返回按钮上的文字
        _weakSelf.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [_weakSelf.navigationController pushViewController:response animated:YES];
    };
}

//加入购物车
- (IBAction)jrgwcAction:(UIButton *)sender {
    DD_CHECK_HASLONGIN;
    if (!self.purchaseView) {
        static NSString * purchasseID = @"PurchaseView";
        self.purchaseView = [[NSBundle mainBundle] loadNibNamed:purchasseID owner:self options:nil].firstObject;
        self.purchaseView.frame = self.view.frame;
        self.purchaseView.model = _model;
        self.purchaseView.modeltypeArr = _typeArr;
        self.purchaseView.modelArr = _normsArr;
        [self.view addSubview:self.purchaseView];
    }
    [self.purchaseView show:^(id response) {
        NSLog(@"re = %@",response);
        [self.middleView.xzflBtn setTitle:response forState:UIControlStateNormal];
    }];
    __weak typeof(self) _weakSelf = self;
    self.purchaseView.finishBtnBlock = ^(id response) {
        NSLog(@"go");
        _weakSelf.hidesBottomBarWhenPushed = YES;
        _weakSelf.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
        _weakSelf.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [_weakSelf.navigationController pushViewController:response animated:YES];
    };
}

#pragma mark  --- tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (self.selectIndex) {
        case 0:
        {
            return self.productArray.count;
        }
            break;
        case 1:
        {
            if (self.evaluateArray.count == 0) {
                tableView.hidden = YES;
            }
            return self.evaluateArray.count;
        }
            break;
        case 2:
        {
            return 0;
        }
            break;
        default:
            return 0;
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.selectIndex) {
        case 0:
        {
            ProductTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ProductTableViewCell"];
            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:self.productArray[indexPath.row]] options:0 progress:nil completed:^(UIImage * image, NSError * error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                cell.productImageView.image = image;
//                NSLog(@"%f - %f",image.size.height,image.size.width);
                if (image) {
                    if (!self.imageDic[@(indexPath.row).stringValue]) {
                        self.imageDic[@(indexPath.row).stringValue] = @(ZP_Width * image.size.height / image.size.width);
                        [tableView reloadData];
                    }
                }
            }];
            return cell;
        }
            break;
        case 1:
        {
            EvaluateTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EvaluateTableViewCell"];
            EvaluateModel * model = self.evaluateArray[indexPath.row];
            [cell Evaluatemodel:model];
            return cell;
        }
            break;
        case 2:
        {
            TextdetailsViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TextdetailsViewCell"];
            return cell;
        }
            break;
        default:
            return nil;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)isPureFloat:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.selectIndex) {
            //self.imageDic
        case 0:
        {
            NSLog(@"%@",self.imageDic[@(indexPath.row).stringValue]); // man 所以是数据问题·  不是cgfloat
//            NSLog(@"bool = %d",[self isPureFloat:self.imageDic[@(indexPath.row).stringValue]]);
//            if ([self isPureFloat:self.imageDic[@(indexPath.row).stringValue]]) {
//                NSLog(@"go");
                return [self.imageDic[@(indexPath.row).stringValue] integerValue];
//            }else{
//                NSLog(@"no bu");
//                return CGFLOAT_MIN;

           
        }
            break;
        case 1:
        {
            return 111;
        }
            break;
        case 2:
        {
            return 100;
        }
            break;
            
        default:
            return 0;
            break;
    }
    if (indexPath.section == 0) {
        if (_productArray.count > 0) {
            return ZP_Width;
        }
        return CGFLOAT_MIN;
    } else {
        if (indexPath.section == 1){
            return self.imageHeight;
            return CGFLOAT_MIN;
        }else {
            return 0;
        }
    }
}

#pragma mark =============================框架代码=============================
/**
 添加导航栏背后的View
 */

- (void)initFrameWords {
    self.TopViewScale = 1.0;
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self initView];
}

-(UIScrollView *)MyScrollView{
    if (_MyScrollView == nil) {
        UIScrollView* scroll = [[UIScrollView alloc] init];
        _MyScrollView = scroll;
        _MyScrollView.backgroundColor = color(235, 235, 235, 1);
        scroll.delegate = self;
        scroll.frame = CGRectMake(0.0, 0.0, screenW, screenH-BottomH);
        scroll.pagingEnabled = YES;//进行分页
        scroll.showsVerticalScrollIndicator = NO;
        scroll.tag = 0;
        [self.view addSubview:scroll];
    }
    return _MyScrollView;
}

/**
 初始化相关的view
 */
-(void)initView{
    //初始化第一个页面
    //初始化第一个页面的父亲view
    UIView* firstPageView = [[UIView alloc] init];
    firstPageView.frame = CGRectMake(0, 0, screenW, SecondPageTop);
    firstPageView.backgroundColor = color(235.0,235.0,235.0,1.0);
    BuyTopView* topView = [BuyTopView view];
    self.topView = topView;
    topView.frame = CGRectMake(0,0, screenW, TopViewH);
    [firstPageView addSubview:topView];
    
    BuyMiddleView* middleView = [BuyMiddleView view];
    self.middleView = middleView;
    [middleView.xzflBtn addTarget:self action:@selector(ClassificationButt) forControlEvents:UIControlEventTouchUpInside];
    middleView.frame = CGRectMake(0,CGRectGetMaxY(topView.frame) + 10, screenW, MiddleViewH);
    [firstPageView addSubview:middleView];
    [self.MyScrollView addSubview:firstPageView];
    //初始化第二个页面
    [self addSecondPageTopTabBar];
    // 设置scrollview内容区域大小
    self.MyScrollView.contentSize = CGSizeMake(screenW, SecondPageTop+screenH-BottomH-NaviBarH);
}
/**
 添加第二个页面顶部tabBar
 */
-(void)addSecondPageTopTabBar{
    //初始化第二个页面的父亲view
    UIView * secondPageView = [[UIView alloc] init];
    secondPageView.frame = CGRectMake(0, SecondPageTop, screenW, screenH-NaviBarH-BottomH);
    NSArray* array  = @[@"产品内容",@"产品评价",@"售后服务"];
    MyOrderTopTabBar* tabBar = [[MyOrderTopTabBar alloc] initWithArray:array] ;
    tabBar.frame = CGRectMake(0,0, screenW, TopTabBarH);
    tabBar.backgroundColor = [UIColor whiteColor];
    tabBar.delegate = self;
    self.TopTabBar = tabBar;
    [secondPageView addSubview:tabBar];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_evaluate_nocontent"]];
    imageView.frame = CGRectMake(ZP_Width/2-40,SecondPageTop/2-40, 80, 80);
    [secondPageView addSubview:imageView];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"暂无评论内容哦";
    label.textColor = [UIColor darkGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, imageView.y+imageView.height+5, secondPageView.width, 20);
    [secondPageView addSubview:label];
    
    //初始化一个UITableView
    UITableView * tableview = [[UITableView alloc] init];
    self.detailTableview = tableview;
    tableview.dataSource = self;
    tableview.delegate = self;
    tableview.tag = 1;
    tableview.frame = CGRectMake(0, CGRectGetMaxY(tabBar.frame)+10, screenW,secondPageView.frame.size.height - tabBar.frame.size.height-10);

    [secondPageView addSubview:tableview];
    [self.MyScrollView addSubview:secondPageView];
}

// 选择分类规格
- (void)ClassificationButt {
    DD_CHECK_HASLONGIN;
    if (!self.purchaseView) {
        static NSString * purchasseID = @"PurchaseView";
        self.purchaseView = [[NSBundle mainBundle] loadNibNamed:purchasseID owner:self options:nil].firstObject;
        self.purchaseView.frame = self.view.frame;
        self.purchaseView.model = _model;
        self.purchaseView.modeltypeArr = _typeArr;
        self.purchaseView.modelArr = _normsArr;
        [self.view addSubview:self.purchaseView];
    }
    [self.purchaseView show:^(id response) {
        NSLog(@"re = %@",response);
        [self.middleView.xzflBtn setTitle:response forState:UIControlStateNormal];
    }];
    __weak typeof(self) _weakSelf = self;
    self.purchaseView.finishBtnBlock = ^(id response) {
        NSLog(@"go");
        _weakSelf.hidesBottomBarWhenPushed = YES;
        _weakSelf.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
        _weakSelf.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [_weakSelf.navigationController pushViewController:response animated:YES];
    };
}

#pragma -- <UIScrollViewDelegate>
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@" --== %f",scrollView.contentOffset.y);
    if(scrollView.tag == 0){
        if(scrollView.contentOffset.y<0){
            if(self.TopViewScale<1.01){
                self.TopViewScale += 0.00015f;
            }
            scrollView.contentOffset = CGPointMake(0, 0);
        }else{
            self.headView.backgroundColor = color(255.0,147.0,0.0, scrollView.contentOffset.y/(SecondPageTop-NaviBarH));
            self.titleLabel.alpha = scrollView.contentOffset.y/(SecondPageTop-NaviBarH);
        }
        if(scrollView.contentOffset.y > (SecondPageTop-NaviBarH)){
            [scrollView setContentOffset:CGPointMake(0, SecondPageTop-NaviBarH)];
        }else if (scrollView.contentOffset.y == -NaviBarH && !scrollView.isDragging){
            [UIView animateWithDuration:0.3 animations:^{
                scrollView.contentOffset = CGPointMake(0, 0);
            }];
        }else;
    }
}

#pragma -- MyOrderTopTabBarDelegate(顶部标题栏delegate)
-(void)tabBar:(MyOrderTopTabBar *)tabBar didSelectIndex:(NSInteger)index{
    self.selectIndex = index;
    if (self.detailTableview.hidden) {
        self.detailTableview.hidden = NO;
    }
    [self.detailTableview reloadData];
}

#pragma mark =============================框架代码=============================

-(void)loading {
    [ZPProgressHUD showErrorWithStatus:connectFailed toViewController:self];
    __weak typeof(self)weakSelf = self;
    [ReloadView showToView:self.view touch:^{
        [weakSelf allData];
        [ReloadView dismissFromView:weakSelf.view];
    }];
}

-(void)successful {
    [self.detailTableview reloadData];
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
