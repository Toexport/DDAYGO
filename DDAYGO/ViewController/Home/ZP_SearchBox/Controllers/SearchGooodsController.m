//
//  SearchGooodsController.m
//  DDAYGO
//
//  Created by Login on 2017/9/8.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "SearchGooodsController.h"
#import "SearchBar.h"
#import "PrefixHeader.pch"
#import "UIFont+Extension.h"
#import "UIView+Extension.h"
#import "UIColor+Extension.h"
#import "ZP_ClassViewTool.h"
#import "CPerViewController.h"
@interface SearchGooodsController () <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate>
@property (nonatomic, weak) SearchBar * searchBar;
@property (nonatomic, strong)NSArray * dataArray;
@property (nonatomic, strong)UITableView * tableView;
@end

@implementation SearchGooodsController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -44,ZP_Width , ZP_height) style:(UITableViewStyleGrouped)];
        _tableView.bounces = NO;
        _tableView.hidden = YES;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavgationBar];
    [self addUI];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.searchBar resignFirstResponder];
}

- (void)addUI {
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"nav_menu_search" bundle:nil] forCellReuseIdentifier:@"cell"];
}
#pragma mark - 私有
//设置导航栏
- (void)setUpNavgationBar {
    
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"input_home_search"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Cancel", nil) style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = ZP_TabBarTextColor;
    textAttrs[NSFontAttributeName] = ZP_TooBarFont;
    textAttrs[NSShadowAttributeName] = nil;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    SearchBar *searchBar = [[SearchBar alloc]init];
    searchBar.width = ZP_Width-60;
    searchBar.height = 30;
    searchBar.font = ZP_TooBarFont;
    [searchBar becomeFirstResponder];
    searchBar.keyboardType = UIKeyboardTypeWebSearch;
    searchBar.returnKeyType = UIReturnKeySearch;
    searchBar.delegate = self;
    self.searchBar = searchBar;
    self.navigationItem.titleView = searchBar;
}

#pragma mark - 请求数据
- (void)search:(NSString *)keywords {
    if (self.type == 666) {
        NSString * newStr = [keywords stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString * searchKit = [newStr stringByAddingPercentEscapesUsingEncoding:kCFStringEncodingUTF8];
        ZPLog(@"go - > %@ --- %@,kkk_> %@",keywords,newStr,searchKit);
        if (newStr.length > 0 ) {
            ZPLog(@"go");
            [SVProgressHUD showInfoWithStatus:@"暫無數據"];
    }
    }else {
    NSString * newStr = [keywords stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString * searchKit = [newStr stringByAddingPercentEscapesUsingEncoding:kCFStringEncodingUTF8];
    ZPLog(@"go - > %@ --- %@,kkk_> %@",keywords,newStr,searchKit);
    if (newStr.length > 0 ) {
        ZPLog(@"go");
        CPerViewController * CVPView = [[CPerViewController alloc]init];
        CVPView.fatherId = [NSNumber numberWithInteger:0];
        CVPView.keyword = searchKit;
        CVPView.titleString = @"搜索";
        [ZPProgressHUD showWithStatus:@"正在搜索..." maskType:ZPProgressHUDMaskTypeBlack];
        [self.navigationController pushViewController:CVPView animated:YES];
    }else{
    [SVProgressHUD showInfoWithStatus:@"請輸入你要寻找的商品"];
        ZPLog(@"no go");
        }
      }
}

#pragma mark - action
- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 82;
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self search:textField.text];
    [self.searchBar resignFirstResponder];
    return YES;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自身控制器
    BOOL isShowMyController = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowMyController animated:YES];
}

@end
