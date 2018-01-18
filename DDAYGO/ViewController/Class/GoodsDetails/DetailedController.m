//
//  DetailedController.m
//  DDAYGO
//
//  Created by Login on 2017/9/14.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "DetailedController.h"
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
@interface DetailedController ()<UICollectionViewDelegate,UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource>

//**Xib 拖过来然后填写数据**/
@property (nonatomic, strong)UIImageView * ShopImageView;
@property (weak, nonatomic) IBOutlet UILabel * ShopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel * CurrencySymbolLabel;
@property (weak, nonatomic) IBOutlet UILabel * ShopMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel * ShopOldMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel * quantityLable;
@property (weak, nonatomic) IBOutlet UILabel * peramountLable;
@property (weak, nonatomic) IBOutlet UILabel * productidLable;
@property (strong, nonatomic) IBOutlet UILabel * ShoppingIdLabel;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailViewTop;
@property (weak, nonatomic) IBOutlet UITableView * detailTableView;

@property (nonatomic, strong) NSArray * array;
@property (nonatomic, strong) UIWindow * window;
@property (nonatomic, strong) ProductDescriptionView * productDescriptionView;
@property (nonatomic, strong) PurchaseView * purchaseView;
@property (nonatomic ,strong) NSMutableArray * newsData;
@property (weak, nonatomic) IBOutlet UIButton * ljgmBtn;
@property (weak, nonatomic) IBOutlet UIButton * jrgwcBtn;
@property (nonatomic, strong) ZP_GoodDetailsModel * model;
@property (nonatomic, strong) NSArray * normsArr;
@property (nonatomic, strong) NSArray * typeArr;
@property (nonatomic, strong) NSArray * pjArr;
@property (nonatomic, strong) NSMutableArray *productArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cpsmHeight;
@property (nonatomic, strong) NSMutableArray *evaluateArray;

@end

@implementation DetailedController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self allData];
    [self evaluation];
    self.navigationController.navigationBar.hidden = YES;
    [self.detailTableView registerNib:[UINib nibWithNibName:@"ProductTableViewCell" bundle:nil] forCellReuseIdentifier:@"ProductTableViewCell"];
    [self.detailTableView registerNib:[UINib nibWithNibName:@"EvaluateTableViewCell" bundle:nil] forCellReuseIdentifier:@"EvaluateTableViewCell"];
    self.shfwBottomView.hidden = YES;
    self.qbpjBottomView.hidden = YES;
    
    self.evaluateArray = [NSMutableArray array];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

//updateViewConstraints
- (void)getimageData {
    if (_normsArr.count > 0) {
        NSLog(@"%ld",_normsArr.count);
        self.onScrollViewWidth.constant = ZP_Width * _normsArr.count;
        for (int i = 0; i < _normsArr.count; i ++) {
            ZP_GoodDetailsModel *model = _normsArr[i];
            _ShopImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ZP_Width * i, 0, ZP_Width, self.onScrollView.height)];
//            _ShopImageView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255. green:arc4random_uniform(256)/255. blue:arc4random_uniform(256)/255. alpha:1];
            [_ShopImageView sd_setImageWithURL:[NSURL URLWithString:model.cnimg] placeholderImage:[UIImage imageNamed:@""]];
            [self.onScrollView addSubview:_ShopImageView];
        }
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.smallScrollView.center.x - 19.5, self.smallScrollView.size.height - 37, 39, 37)];
        self.pageControl.numberOfPages = _normsArr.count;
        self.pageControl.currentPage = 0;
        [self.scrollView addSubview:self.pageControl];
        [self.shoucangBtn resizeWithDistance:5];
        [self.gouwuBtn resizeWithDistance:5];
//        [self.dianpuBtn resizeWithDistance:5]; // 暂时不需要商铺按钮
    }
    else{
        self.onScrollViewWidth.constant = ZP_Width * 1;
        for (int i = 0; i < 1; i ++) {
            _ShopImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ZP_Width * i, 0, ZP_Width, self.onScrollView.height)];
//            _ShopImageView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255. green:arc4random_uniform(256)/255. blue:arc4random_uniform(256)/255. alpha:1];
            [self.onScrollView addSubview:_ShopImageView];
        }
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.smallScrollView.center.x - 19.5, self.smallScrollView.size.height - 37, 39, 37)];
        self.pageControl.numberOfPages = 1;
        self.pageControl.currentPage = 0;
        [self.scrollView addSubview:self.pageControl];
        
        [self.shoucangBtn resizeWithDistance:5];
        [self.gouwuBtn resizeWithDistance:5];
//        [self.dianpuBtn resizeWithDistance:5]; // 暂时不需要商铺按钮
    }
    
}

// 获取数据
- (void)allData {
    if (nil == _productId) {
        return;
    }
    NSDictionary * dic;
    if (Token) {
        dic = @{@"productid":_productId,@"token":Token};
    } else {
        dic = @{@"productid":_productId};
    }
    
    [ZP_ClassViewTool requDetails:dic success:^(id obj) {
        ZPLog(@"%@",obj);
        NSDictionary *asdic = [obj[@"productdetail"] firstObject];
        NSString *asdtring = asdic[@"content"];
        self.productArray = [asdtring componentsSeparatedByString:@","];
        [self.detailTableView reloadData];
        NSDictionary *tempDic = @{@"productid":_productId,@"page":@(1),@"pagesize":@(5)};
        [ZP_ClassViewTool requEvaluates:tempDic success:^(id obj) {
            [self.evaluateArray addObject:obj];
//            NSLog(@"%@",obj);
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
        ZP_GoodDetailsModel * model = [ZP_GoodDetailsModel getGoodDetailsData:obj[@"products"][0]];
        _shoucangBtn.selected = [model.state boolValue];
        NSString *value = [obj objectForKey:@"colornorms"];
        if ((NSNull *)value == [NSNull null]) {
//            NSLog(@"kkk");
        }else{
            NSArray *colorArr = obj[@"colornorms"];
            if (colorArr.count > 0) {
                _normsArr = [ZP_GoodDetailsModel arrayWithArray:obj[@"colornorms"]];
                _typeArr = [ZP_GoodDetailsModel arrayWithTypeArray:obj[@"colornorms"]];
                [self getimageData];
            }
            
        }
        _model = model;
        [self getDataWithModel:model];
        
    } failure:^(NSError * error) {
        ZPLog(@"%@", error);
    }];
}

- (void)getRightItemDataWithProducttypeid:(NSInteger)producttypeid {
    NSDictionary * dictt = @{@"productid":@"2",@"fatherid":[@(producttypeid + 1) stringValue]};
    [ZP_ClassViewTool requClassIficationrj:dictt success:^(id obj) {
//        ZPLog(@"%@",obj);
    } failure:^(NSError *error) {
//        [SVProgressHUD showInfoWithStatus:@"服务器链接失败"];
        ZPLog(@"%@",error);
    }];
}

//填写数据
- (void)getDataWithModel:(ZP_GoodDetailsModel *)model {
    if (_normsArr.count < 1){
        [self getimageData];
        [_ShopImageView sd_setImageWithURL:[NSURL URLWithString:model.defaultimg] placeholderImage:[UIImage imageNamed:@""]];
        
    }
    _ShopNameLabel.text = model.productname;
    _ShopMoneyLabel.text = model.productprice;
    _quantityLable.text = model.productamount;
    _peramountLable.text = model.peramount;
    _productidLable.text = model.productid;
    _ShoppingIdLabel.text = model.TrademarkLabel;
    
}
// 获取评价数据
- (void)evaluation {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"productid"] = _productId;
    dic[@"page"] = @"1";
    dic[@"pagesize"] = @"5";
    [ZP_ClassViewTool requEvaluates:dic success:^(id obj) {
        NSLog(@"go? %@",obj);
        
//        这里到时候需要根据 接口返回的类型来判断，不然一样会奔溃·
        _pjArr = obj;
        if (obj == nil) {
//            [SVProgressHUD showInfoWithStatus:@"服务器链接失败"];
            ZPLog(@"-----");
            
        }
        ZPLog(@"%@",obj);
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
//        [SVProgressHUD showInfoWithStatus:@"服务器链接失败"];
    }];
    
}

//  自定义返回按钮
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
// 分享
- (IBAction)shareAction:(id)sender {
    
}

- (IBAction)editAction:(id)sender {
    
}

#pragma mark  - - 收藏
- (IBAction)shoucangAction:(UIButton *)sender {
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

- (IBAction)ShoppingCartAction:(id)sender {
//
//    ShoppingViewController * Shopping = [[ShoppingViewController alloc]init];
//    self.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:Shopping animated:YES];
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
//    self.hidesBottomBarWhenPushed = YES;
    
}

- (IBAction)dianpuAction:(id)sender {
    /** 暂不需要
    MerchantController * Merchant = [[MerchantController alloc]init];
    [self.navigationController pushViewController:Merchant animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
     */
}

- (IBAction)xzflAction:(UIButton *)sender {
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
        [self.xzflBtn setTitle:response forState:UIControlStateNormal];
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

- (IBAction)cpsmAction:(UIButton *)sender {
    DD_CHECK_HASLONGIN;
    if (!self.productDescriptionView) {
        self.productDescriptionView = [[NSBundle mainBundle] loadNibNamed:@"ProductDescriptionView" owner:self options:nil].firstObject;
        self.productDescriptionView.frame = self.view.frame;
        [self.view addSubview:self.productDescriptionView];
    }
    [self.productDescriptionView show];
}
//


//这里才是点击的事件,
- (IBAction)cpnrAction:(id)sender {
    
    if (_pjArr.count >0) {
        [self.detailTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }else {
        ZPLog(@"----==");
//       [SVProgressHUD showInfoWithStatus:@"数据加载失败!"];
    }
     [self updateDetailView:0];
}

- (IBAction)qupjAction:(id)sender {
    if (_pjArr.count > 0) {
        [self.detailTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }else {
//        [SVProgressHUD showInfoWithStatus:@"数据加载失败!"];
    }
    [self updateDetailView:1];
}

- (IBAction)shfwAction:(id)sender {
    if (_pjArr.count >0) {
        [self.detailTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }else {
//        [SVProgressHUD showInfoWithStatus:@"数据加载失败!"];
    }
    [self updateDetailView:2];
}

- (void)updateDetailView:(NSInteger)index {
    self.cpnrBottomView.hidden = YES;
    self.qbpjBottomView.hidden = YES;
    self.shfwBottomView.hidden = YES;
    
    if (index == 0) {
        self.cpnrBottomView.hidden = NO;;
    } else if (index == 1) {
        self.qbpjBottomView.hidden = NO;
    } else {
        self.shfwBottomView.hidden = NO;
    }
}

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
        [self.xzflBtn setTitle:response forState:UIControlStateNormal];
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
        [self.xzflBtn setTitle:response forState:UIControlStateNormal];
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
    return self.productArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.section == 0) {
        ProductTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ProductTableViewCell"];
        [cell.productImageView sd_setImageWithURL:self.productArray[indexPath.row]];
        return cell;
    } else {
        
        EvaluateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EvaluateTableViewCell"];
        [cell updateData:self.evaluateArray.firstObject];
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return ZP_Width;
    } else {
        return 192;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, ZP_Width - 8, 30)];
    label.backgroundColor = [UIColor whiteColor];
    if (section == 0) {
        label.text = @"产品内容";
    } else if (section == 1) {
        label.text = @"全部评价";
    } else {
        label.text = @"售后服务";
    }
    return label;
}

#pragma mark --- scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        self.headView.alpha = 1 - scrollView.contentOffset.y / 200.0;
        if (scrollView.contentOffset.y >= 524) {
            self.detailViewTop.constant = scrollView.contentOffset.y - 524 + 8;
        } else if (self.detailViewTop.constant != 8) {
            self.detailViewTop.constant = 8;
        }
    }
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    self.scrollView.contentSize =CGSizeMake(ZP_Width,ZP_height * 2);
    if (scrollView == self.smallScrollView) {
        if (!velocity.y && velocity.x) {
            CGPoint point = *targetContentOffset;
            self.pageControl.currentPage = point.x/scrollView.width;
        }
    }
}
@end


