//
//  TextdetailsViewCell.m
//  
//
//  Created by Login on 2017/9/18.
//
//

#import "TextdetailsViewCell.h"
#import "PrefixHeader.pch"
@interface TextdetailsViewCell () <UIWebViewDelegate>

@end

@implementation TextdetailsViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.ddaygo.com/item/customerservice"]]];
    self.webView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

#pragma mark --- UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    //创建UIActivityIndicatorView背底半透明View
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZP_Width, ZP_height)];
    [view setTag:108];
    [view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [view setAlpha:0.5];
    [self addSubview:view];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activityIndicator setCenter:view.center];
    activityIndicator.color = [UIColor grayColor];
//    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [view addSubview:activityIndicator];
    [activityIndicator startAnimating];
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    [activityIndicator stopAnimating];
    UIView * view = (UIView*)[self viewWithTag:108];
    [view removeFromSuperview];
    NSLog(@"webViewDidFinishLoad");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//    [activityIndicator stopAnimating];
    UIView *view = (UIView*)[self viewWithTag:108];
    [view removeFromSuperview];
    NSLog(@"didFailLoadWithError:%@", error);
}
@end
