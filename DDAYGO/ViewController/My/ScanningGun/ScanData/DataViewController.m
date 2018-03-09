
//
//  DataViewController.m
//  DDAYGO
//
//  Created by Login on 2017/10/11.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "DataViewController.h"
#import "PayViewController.h"
#import "PrefixHeader.pch"
#import "ZP_MyTool.h"
#import "PayPassController.h"
#import "PayFailController.h"
#import "OrderViewController.h"
@interface DataViewController ()<UIWebViewDelegate> {
    UIWebView * _webView;
    NSString * _str;
}
@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = MyLocal(@"Payment is being paid, please...");
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupWebView];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"ic_bar_return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(adjustStatusBar:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

- (void)backAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:MyLocal(@"Are you sure you want to quit") preferredStyle:UIAlertControllerStyleAlert];
    NSArray *array = [self.navigationController viewControllers];
    UIViewController *viewController = array.firstObject;
    [alert addAction:[UIAlertAction actionWithTitle:MyLocal(@"ok") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popToRootViewControllerAnimated:NO];
        [SVProgressHUD dismiss];
        _webView.delegate = nil;  // 退出停止加载Web，不然没加载完，退出了内存还在跑加载，容易内存泄漏
        viewController.tabBarController.selectedIndex = 3;
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:MyLocal(@"cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

// 添加webView，加载扫描过来的内容
- (void)setupWebView {
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate = self;
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[_jump_HeadURL stringByAppendingString:@"?"]]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[_jump_URL dataUsingEncoding:NSUTF8StringEncoding]];
    [_webView loadRequest:request];
    ZPLog(@"url : %@",request);
    NSLog(@"oid = %@",_Oid);
    
    //    NSURL * url = [NSURL URLWithString: _jump_HeadURL];
    //    NSString * body = _jump_URL;
    //    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL: url];
    //    [request setHTTPMethod: @"POST"];
    //    [request setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    //    [_webView loadRequest: request];
    [self.view addSubview:_webView];
}

#pragma mark -UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"当前连接--》%@",request.URL.absoluteString);
    //用一个字符串来接受  全局的· 后面要用
    _str = request.URL.absoluteString;
    [SVProgressHUD showWithStatus:MyLocal(@"Trying to load ing... Just a moment, please.")]; // 菊花
    return YES;
}

// 结束加载
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //    这里调用接口·
    [SVProgressHUD dismiss];
    if ([_str containsString:@"getpayresult"]) {
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        dic[@"poid"] = self.Oid;
        [ZP_MyTool requesOrdPay:dic uccess:^(id obj) {
            if ([obj[@"result"] isEqualToString:@"success"]) {
                [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Pay success", nil)];
                PayPassController * Pass = [[PayPassController alloc]init];
                [self.navigationController pushViewController:Pass animated:YES];
            }else
                if ([obj[@"result"]isEqualToString:@"failed"]) {
                    [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"Pay failure", nil)];
                }else
                    if ([obj[@"result"] isEqualToString:@"no_result"]) {
                        [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"No payment record", nil)];
                    }else
                        if ([obj[@"result"] isEqualToString:@"oid_err"]) {
                            [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"The order number cannot be empty.", nil)];
                        }
            ZPLog(@"%@",obj);
        } failure:^(NSError * error) {
            ZPLog(@"%@",error);
        }];
        [SVProgressHUD dismiss];
    }else{
        
    }
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"连接失败%@",error);
    [SVProgressHUD dismiss];
}

// 关闭侧滑
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
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
