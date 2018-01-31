//
//  RegistrationAgreementController.m
//  DDAYGO
//
//  Created by Summer on 2017/12/28.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "RegistrationAgreementController.h"
#import "PrefixHeader.pch"
@interface RegistrationAgreementController ()<UIWebViewDelegate>

@end

@implementation RegistrationAgreementController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
//    self.title = NSLocalizedString(@"用戶協議", nil);
    webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [webView setDelegate:self];
    if (self.type == 111) {
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.ddaygo.com/item/privacy"]];
        self.title = @"隱私政策";
        [self.view addSubview: webView];
        [webView loadRequest:request];
    }else
        if (self.type == 222) {
            NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.ddaygo.com/item/protocol"]];
            self.title = @"服務條款";
            [self.view addSubview: webView];
            [webView loadRequest:request];
    }else
        if (self.type == 333) {
            NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.ddaygo.com/other/exchange"]];
            self.title = @"退換貨流程";
            [self.view addSubview: webView];
            [webView loadRequest:request];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (void) webViewDidStartLoad:(UIWebView *)webView {
    //创建UIActivityIndicatorView背底半透明View
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZP_Width, ZP_height)];
    [view setTag:108];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.5];
    [self.view addSubview:view];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [activityIndicator setCenter:view.center];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [view addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
    NSLog(@"webViewDidStartLoad");
}

- (void) webViewDidFinishLoad:(UIWebView *)webView {
    [activityIndicator stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
    NSLog(@"webViewDidFinishLoad");
    
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [activityIndicator stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
    NSLog(@"didFailLoadWithError:%@", error);
}
@end
