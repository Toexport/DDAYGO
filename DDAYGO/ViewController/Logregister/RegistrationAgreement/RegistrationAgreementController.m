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

@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end

@implementation RegistrationAgreementController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(adjustStatusBar:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

- (void)initUI {
//    webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.webView setDelegate:self];
    if (self.type == 111) {
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.ddaygo.com/item/privacy"]];
        self.title = NSLocalizedString(@"Privacy policy", nil);
        [self.webView loadRequest:request];
    }else
        if (self.type == 222) {
            NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.ddaygo.com/item/protocol"]];
            self.title = NSLocalizedString(@"terms service", nil);
            [self.webView loadRequest:request];
        }else
            if (self.type == 333) {
                NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.ddaygo.com/other/exchange"]];
                self.title = NSLocalizedString(@"exchange process", nil);
                [self.webView loadRequest:request];
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
    UIView * view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
    NSLog(@"didFailLoadWithError:%@", error);
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
