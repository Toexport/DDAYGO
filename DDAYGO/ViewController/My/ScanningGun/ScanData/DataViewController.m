
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
@interface DataViewController ()<UIWebViewDelegate>
{
    UIWebView * _webView;
    NSString * _str;
}
@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"正在支付,请稍后...";
    self.view.backgroundColor = [UIColor whiteColor];
        [self setupWebView];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor]}];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"ic_bar_return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
}

- (void)backAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确定要退出吗?" preferredStyle:UIAlertControllerStyleAlert];
    NSArray *array = [self.navigationController viewControllers];
    UIViewController *viewController = array.firstObject;
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popToRootViewControllerAnimated:NO];
        [SVProgressHUD dismiss];
        viewController.tabBarController.selectedIndex = 3;
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
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
    [self.view addSubview:_webView];
}

#pragma mark -UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    ZPLog(@"当前连接--》%@",request.URL.absoluteString);
//用一个字符串来接受  全局的· 后面要用
    _str = request.URL.absoluteString;
    [SVProgressHUD showWithStatus:@"正在努力加载ing......请再稍等一下下~"]; // 菊花
    
    return YES;
}

///**清除缓存和cookie*/
//- (void)cleanCacheAndCookie {
//    //清除cookies
//    NSHTTPCookie * cookie;
//    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    for (cookie in [storage cookies]){
//        [storage deleteCookie:cookie];
//    }
//    //清除UIWebView的缓存
//    [[NSURLCache sharedURLCache] removeAllCachedResponses];
//    NSURLCache * cache = [NSURLCache sharedURLCache];
//    [cache removeAllCachedResponses];
//    [cache setDiskCapacity:0];
//    [cache setMemoryCapacity:0];
//}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSLog(@"finish");
//    这里调用接口·
    [_webView removeFromSuperview];
    if ([_str containsString:@"getpayresult"]) {
        [_webView removeFromSuperview];
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        dic[@"poid"] = self.Oid;
        [ZP_MyTool requesOrdPay:dic uccess:^(id obj) {
            if ([obj[@"result"] isEqualToString:@"success"]) {
                [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"支付成功", nil)];
                PayPassController * Pass = [[PayPassController alloc]init];
                [self.navigationController pushViewController:Pass animated:YES];
            }else
                if ([obj[@"result"]isEqualToString:@"failed"]) {
                    [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"支付失败", nil)];
            }else
                if ([obj[@"result"] isEqualToString:@"no_result"]) {
                    [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"無付款記錄", nil)];
            }else
                if ([obj[@"result"] isEqualToString:@"oid_err"]) {
                    [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"訂單號不能為空", nil)];
            }
            
        } failure:^(NSError * error) {
            ZPLog(@"%@",error);
//            [SVProgressHUD showInfoWithStatus:@"服務器連接失敗"];
        }];
        [SVProgressHUD dismiss];
    }else{
        
//      [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"連接錯誤", nil)];
        
    }
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"连接失败%@",error);
    [SVProgressHUD dismiss];
}


@end
