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
#import "ZP_GoodDetailsModel.h"

@interface CollectionViewController ()
{
    NSArray *_dataArray;
}
@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.title = NSLocalizedString(@"collect", nil);
}

//UI
- (void)initUI {
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    [self.tableView registerNib:[UINib nibWithNibName:@"CollectionTableViewCell" bundle:nil] forCellReuseIdentifier:@"CollectionTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
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
//    if (_dataArray.count < 1) {
//        UIImageView * image = [UIImageView new];
//        image.image = [UIImage imageNamed:@"icon_fail"];
//        [self.view addSubview:image];
//        [image mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.view).offset(ZP_Width / 2 -25);
//            make.top.equalTo(self.view).offset(20);
//            make.width.mas_offset(50);
//            make.height.mas_equalTo(50);
//        }];
//    }
    _dataArray = [collectionModel arrayWithArray:json[@"list"]];
    [self.tableView reloadData];
    } failure:^(NSError *error) {
        ZPLog(@"error");
        
    }];
}

- (void)CollectionBut:(UIButton *)sender {
    
    //取消收藏
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"productid"] = _model.productid;
    dic[@"token"] = Token;
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

#pragma mark ---tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    collectionModel * model = _dataArray[indexPath.row];
    CollectionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CollectionTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果、
    cell.CollectionBut.tag = indexPath.row;
    [cell.CollectionBut addTarget:self action:@selector(CollectionBut:) forControlEvents:UIControlEventTouchUpInside];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 102;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZPLog(@"%ld",indexPath.row);
}
@end

