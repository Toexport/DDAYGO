//
//  AppraiseController.m
//  DDAYGO
//
//  Created by Login on 2017/9/22.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "AppraiseController.h"
#import "AppraiseViewCell.h"
#import "ShopevaluationViewCell.h"
#import "UINavigationBar+Awesome.h"
#import "PrefixHeader.pch"
#import "ZP_OrderTool.h"
@interface AppraiseController ()
@property (nonatomic, strong) UITableView * tableview;
@end

@implementation AppraiseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"發佈評論", nil);
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    [self initUI];
    [self setUpNavgationBar];
}

- (void)initUI {
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, ZP_Width, ZP_height)];
    dataArray = @[@{@"":@""}];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏tableview多余的线条
    [self.tableview registerClass:[AppraiseViewCell class] forCellReuseIdentifier:@"prefixHeader"];
    [self.tableview registerClass:[ShopevaluationViewCell class] forCellReuseIdentifier:@"shopevaluation"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = ZP_Graybackground;
    [self.view addSubview:self.tableview];
}

//  navigationBar按钮
- (void) setUpNavgationBar {
    static CGFloat const kButtonWidth = 33.0f;
    static CGFloat const kButtonHeight = 43.0f;
    UIButton *cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cartButton.frame = CGRectMake(0.0f, 0.0f, kButtonWidth, kButtonHeight);
    cartButton.backgroundColor = [UIColor clearColor];
    [cartButton setTitle:NSLocalizedString(@"发布", nil) forState:UIControlStateNormal];
    cartButton.titleLabel.font = ZP_TooBarFont;
    [cartButton addTarget:self action:@selector(cartButton) forControlEvents:UIControlEventTouchUpInside];
    cartButton.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cartButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)cartButton {
    [self allData];
////  设置时间和动画效果
//    [UIView animateWithDuration:8.0 animations:^{
//        [SVProgressHUD showSuccessWithStatus:@"评价成功"];
//    } completion:^(BOOL finished) {
////  动画完毕从父视图移除
//
//        [self.navigationController popViewControllerAnimated:YES];
//    }];
////        NSLog(@"没选选中，不跳");
    }

// 数据
- (void)allData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//    写在这里就好
//    _model.addressid
    dic[@"preview"] = @"";  //逗號拼接： [商品详情ID,商品ID,分数,评价内容] 多个以 _ 连接
    dic[@"oid"] = _model.ordersnumber;   //订单编号
    dic[@"supscore"] = @""; // 店家评分
    dic[@"sreview"] = @""; //店家评论

    dic[@"token"] = Token;
    [ZP_OrderTool requestAppraise:dic success:^(id obj) {
        ZPLog(@"%@",obj);
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
//        [SVProgressHUD showInfoWithStatus:@"服務器鏈接失敗"];
    }];
}
#pragma mark - <UItableviewDelegate>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        NSArray * A = @[@"a",@"b",@"c",@"d",@"e"];
        NSString * AppraiseID = @"prefixHeader";
        AppraiseViewCell * cell = [tableView dequeueReusableCellWithIdentifier:AppraiseID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果
        cell.scoreBlock = ^(NSInteger tag) {
            NSLog(@"%ld",(long)tag);
        };
        [cell score:A];
        
        NSDictionary * dic = dataArray[indexPath.row];
        [cell Appraise:dic];
        return cell;

    }else {
        
        NSArray * B = @[@"a",@"b",@"c",@"d",@"e"];
        NSString * ShopevaluationID = @"shopevaluation";
        ShopevaluationViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ShopevaluationID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果
        cell.ShopevaluationBlock = ^(NSInteger tag) {
            NSLog(@"%ld",(long)tag);
        };
        [cell Shopevaluation:B];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 150;
    }else {
       return 160;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
