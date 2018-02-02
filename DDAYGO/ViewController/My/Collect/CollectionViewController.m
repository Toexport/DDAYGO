//
//  CollectionViewController.m
//  DDAYGO
//
//   Created by Login on 2017/9/7.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionTableViewCell.h"
#import "UINavigationBar+Awesome.h"
#import "PrefixHeader.pch"
#import "ZP_MyTool.h"
#import "ZP_ClassViewTool.h"
#import "collectionModel.h"
#import "BuyViewController.h"
@interface CollectionViewController (){
    int _i;
}
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) NoDataView * noDataView; // 数据为空加载次view
@end
@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self addRefresh];
    self.title = NSLocalizedString(@"collect", nil);
    [NoDataView initWithSuperView:self.view Content:nil FinishBlock:^(id response) {
        self.noDataView = response;
        [self.tableView reloadData];
    }];
}

//UI
- (void)initUI {
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    [self.tableView registerNib:[UINib nibWithNibName:@"CollectionTableViewCell" bundle:nil] forCellReuseIdentifier:@"CollectionTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

// 刷新
- (void)addRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.dataArray removeAllObjects];
        _i = _dataArray;
        [self getData];
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
    [self getData];
}
// 获取数据
- (void)getData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    dic[@"screen"] = @1;
    [ZP_MyTool requestgetcollections:dic success:^(id json) {
        ZPLog(@"%@",json);
    _dataArray = [collectionModel arrayWithArray:json[@"list"]];
    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
    } failure:^(NSError *error) {
        ZPLog(@"error");
    }];
}

- (void)CollectionBut:(UIButton *)sender {
    //取消收藏
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    collectionModel * model = _dataArray[sender.tag];
    dic[@"productid"] = model.productid;
    dic[@"token"] = Token;
    [ZP_ClassViewTool requCancelshoucang:dic success:^(id obj) {
        if ([obj[@"result"]isEqualToString:@"ok"]) {
            [self getData];
            [self.tableView reloadData];
            [SVProgressHUD showSuccessWithStatus:@"取消成功!"];
        }else
            if ([obj[@"result"]isEqualToString:@"failure"]) {
                [SVProgressHUD showInfoWithStatus:@"操作失败"];
        }
    } failure:^(NSError *error) {
        NSLog(@"error %@",error);
    }];
}

#pragma mark ---tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataArray.count > 0) {
        self.tableView.hidden = NO;
        self.noDataView.hidden = YES;
        return self.dataArray.count;
    }else {
        if (self.noDataView) {
            self.tableView.hidden = YES;
            self.noDataView.hidden = NO;
        }
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   collectionModel * model = _dataArray[indexPath.row];
    CollectionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CollectionTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果、
    cell.CollectionBut.tag = indexPath.row;
    [cell.CollectionBut addTarget:self action:@selector(CollectionBut:) forControlEvents:UIControlEventTouchUpInside];
//    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTag)];
//    [cell.ShopimageView addGestureRecognizer:tapGesture];
//    cell.ShopimageView.userInteractionEnabled = YES;
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 102;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    collectionModel * model = _dataArray[indexPath.row];
    BuyViewController * ByView = [[BuyViewController alloc]init];
    ByView.productId = model.productid;
    [self.navigationController pushViewController:ByView animated:YES];
    ZPLog(@"%ld",indexPath.row);
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    NSLog(@"go ");
//    return 10.0f;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, 10)];
//    v.backgroundColor = ZP_Graybackground;
//    return v;
//}

@end

