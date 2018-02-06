//
//  FootprintViewController.m
//  DDAYGO
//
//   Created by Login on 2017/9/7.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "FootprintViewController.h"
#import "UINavigationBar+Awesome.h"
#import "FootprintCollectionViewCell.h"
#import "PrefixHeader.pch"
#import "ZP_MyTool.h"
#import "BuyViewController.h"
@interface FootprintViewController (){
    int _i;
}

@property (nonatomic, strong)NSMutableArray * newsData;
@property (nonatomic, strong) ZP_FootprintModel1 * model1;
@property (nonatomic, strong) NoDataView * NoDataView;
@end

@implementation FootprintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"footprint", nil);
    [self allData];
    [self addRefresh];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    [self.collectionView registerNib:[UINib nibWithNibName:@"FootprintCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"FootprintCollectionViewCell"];
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    //    self.collectionView.alwaysBounceVertical = YES;
    [NoDataView initWithSuperView:self.view Content:nil FinishBlock:^(id response) {
        self.NoDataView = response;
        [self.collectionView reloadData];
    }];
}
// 刷新
- (void)addRefresh {
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.newsData removeAllObjects];
        _i = _newsData;
        [self allData];
    }];
    
    //    [self.tableview.mj_header beginRefreshing];
    //    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
    //         [self.newsData removeAllObjects];
    //        _i+=10;
    //        [self getDataWithState];
    //    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

// 获取数据
- (void)allData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    int i = arc4random_uniform(999);  // 随机数
    dic[@"nonce"] = @(i);
    [ZP_MyTool requtsFootprint:dic success:^(id obj) {
        //*************************************Token被挤掉***************************************************//
        if ([obj[@"result"]isEqualToString:@"token_not_exist"]) {
            Token = nil;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"symbol"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"countrycode"];
            [[NSUserDefaults standardUserDefaults] objectForKey:@"headerImage"];
            ZPICUEToken = nil;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"icuetoken"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"state"];
            [[NSUserDefaults standardUserDefaults] objectForKey:@"headerImage"];
            [[SDImageCache sharedImageCache] clearDisk];
            [[NSUserDefaults standardUserDefaults]synchronize];
#pragma make -- 提示框
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"您的账号已在其他地方登陆,您已被迫下线,如果非本人登录请尽快修改密码",nil) preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                ZPLog(@"取消");
            }];
            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"確定",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                [self.navigationController popToRootViewControllerAnimated:NO];
                //跳转
                if ([[[UIApplication sharedApplication] keyWindow].rootViewController isKindOfClass:[UITabBarController class]]) {
                    UITabBarController * tbvc = [[UIApplication sharedApplication] keyWindow].rootViewController;
                    [tbvc setSelectedIndex:0];
                }
            }];
            [alert addAction:defaultAction];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        //****************************************************************************************//
        ZPLog(@"%@",obj);
        NSDictionary * dic = obj;
        NSArray * arr = [ZP_FootprintModel arrayWithArray:dic[@"historyslist"]];
        [arr enumerateObjectsUsingBlock:^(ZP_FootprintModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            [model.historyArray enumerateObjectsUsingBlock:^(ZP_FootprintModel1 *model1, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.newsData addObject:model1];
            }];
        }];
        [self.collectionView.mj_header endRefreshing];  // 結束刷新
        [self.collectionView reloadData];
    } failure:^(NSError * error) {
        ZPLog(@"error");
    }];
}

//  删除按钮
- (void)deleBtn:(UIButton *)btn{
    if (self.newsData.count == 0) {
        return;
    }
    ZP_FootprintModel1 *model = self.newsData[btn.tag];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    dic[@"historyid"] = model.historyid;
    [ZP_MyTool requtsDeleFootprint:dic success:^(id obj) {
        NSLog(@"dele %@",obj);
        [self.newsData removeObjectAtIndex:btn.tag];
        if ([obj[@"result"]isEqualToString:@"ok"]) {
            [SVProgressHUD showSuccessWithStatus:@"刪除成功"];
        }else {
            if ([obj[@"result"]isEqualToString:@"failure"]) {
                [SVProgressHUD showInfoWithStatus:@"刪除失敗"];
            }
        }
        [self.collectionView reloadData];
    } failure:^(NSError * error) {
        NSLog(@"dele %@",error);
    }];
}
#pragma mark --- collectionView delegate

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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZP_FootprintModel1 *model = self.newsData[indexPath.row];
    FootprintCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FootprintCollectionViewCell" forIndexPath:indexPath];
    cell.deleBtn.tag = indexPath.row;
    [cell.deleBtn addTarget:self action:@selector(deleBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell FootprintCollection:model];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (self.view.frame.size.width-55)/3;
    return CGSizeMake(width + 5, width * 140 / 95);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    ZP_FootprintModel1 *model = self.newsData[indexPath.row];
    BuyViewController * ByView = [[BuyViewController alloc]init];
    ByView.productId = model.productid;
    [self.navigationController pushViewController:ByView animated:YES];
    ZPLog(@"%ld",indexPath.row);
}

- (NSMutableArray *)newsData {
    if (!_newsData) {
        _newsData = [NSMutableArray array];
    }
    return _newsData;
}

@end

