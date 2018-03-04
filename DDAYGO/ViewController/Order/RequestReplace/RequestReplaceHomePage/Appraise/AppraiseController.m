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
#import "ZP_OrderModel.h"
@interface AppraiseController ()
@property (nonatomic, strong) UITableView * tableview;
@property (nonatomic, assign) NSInteger score1;
@property (nonatomic, strong) NSString * pjstr;

@property (nonatomic, assign) NSUInteger Score2;
@property (nonatomic, strong) NSString * jpstr;


@end

@implementation AppraiseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = MyLocal(@"Release comments");
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"ic_bar_return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [self initUI];
    [self setUpNavgationBar];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(adjustStatusBar:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    
    
}

// 返回按钮
- (void)backAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:MyLocal(@"Are you sure you want to quit") preferredStyle:UIAlertControllerStyleAlert];
    NSArray *array = [self.navigationController viewControllers];
    UIViewController *viewController = array.firstObject;
    [alert addAction:[UIAlertAction actionWithTitle:MyLocal(@"ok") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self.navigationController popToRootViewControllerAnimated:NO];
//        viewController.tabBarController.selectedIndex = 3;
//        viewController.popoverPresentationController = YES;
        [viewController.navigationController popViewControllerAnimated:YES];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:MyLocal(@"cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

// UI
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
    [cartButton setTitle:MyLocal(@"Release") forState:UIControlStateNormal];
    cartButton.titleLabel.font = ZP_TooBarFont;
    [cartButton addTarget:self action:@selector(cartButton) forControlEvents:UIControlEventTouchUpInside];
    cartButton.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cartButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)cartButton {
// 数据
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    NSString * allStr = [NSString stringWithFormat:@"%@,%@,%ld,%@",_model2.detailid,_model2.productid,_score1+1,_pjstr];
    NSString * utf8Str = [allStr stringByAddingPercentEscapesUsingEncoding:kCFStringEncodingUTF8];
    dic[@"preview"] = utf8Str;
//    ZPLog(@"%ld",_score1);
//    ZPLog(@"%@",_pjstr);
    dic[@"oid"] = self.ordersnumber;   //订单编号
    dic[@"supscore"] = [NSNumber numberWithFloat:_Score2+1]; // 店家评分
//    ZPLog(@"%ld",_Score2);
    NSString * djStr = [_jpstr stringByAddingPercentEscapesUsingEncoding:kCFStringEncodingUTF8];
    dic[@"sreview"] = djStr; //店家评论
//    ZPLog(@"%@",_jpstr);
    dic[@"token"] = Token;
    if (_score1 < 1) {
        [SVProgressHUD showInfoWithStatus:MyLocal(@"Is no comment")];
        return;
    }
    if (_pjstr.length < 1) {
        [SVProgressHUD showInfoWithStatus:MyLocal(@"Is no comment")];
        return;
    }
    if (_Score2 < 1) {
        [SVProgressHUD showInfoWithStatus:MyLocal(@"Is no comment")];
        return;
    }
    if (_jpstr.length < 1) {
        [SVProgressHUD showInfoWithStatus:MyLocal(@"Is no comment")];
        return;
    }
    [ZP_OrderTool requestAppraise:dic success:^(id obj) {
        
        if ([obj[@"result"]isEqualToString:@"ok"]) {
            [SVProgressHUD showSuccessWithStatus:MyLocal(@"Evaluation success")];
            [self.navigationController popViewControllerAnimated:YES];
        }
        ZPLog(@"%@",obj);
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
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
        NSLog(@"image url = %@",_model2.defaultimg);
        [cell.FigureImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImgAPI,_model2.defaultimg]]];
        cell.scoreBlock = ^(NSInteger tag) {
            _score1 = tag;
            NSLog(@"%ld",(long)tag);
        };
        cell.savaData = ^(NSString *title) {
            _pjstr = title;
        };
        [cell score:A];
        return cell;

    }else {
        NSArray * B = @[@"a",@"b",@"c",@"d",@"e"];
        NSString * ShopevaluationID = @"shopevaluation";
        ShopevaluationViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ShopevaluationID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果
        cell.ShopevaluationBlock = ^(NSInteger tag) {
            _Score2 = tag;
            NSLog(@"%ld",(long)tag);
        };
        cell.savaData = ^(NSString *title) {
            _jpstr = title;
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

// 热点被接入，子类重写
- (void)adjustStatusBar:(NSNotification *)notification {
    NSValue * rectValue = [notification.userInfo objectForKey:UIApplicationStatusBarFrameUserInfoKey];
    CGRect statusRect = [rectValue CGRectValue];
    CGFloat height = statusRect.size.height;
    if (height > 20) {
        appD.window.frame = CGRectMake(0, 0, ZP_Width, ZP_height);
    }else{
        appD.window.frame = CGRectMake(0, 0, ZP_Width, ZP_height);
    }
}
@end
