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
}

#pragma mark --- UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}
@end
