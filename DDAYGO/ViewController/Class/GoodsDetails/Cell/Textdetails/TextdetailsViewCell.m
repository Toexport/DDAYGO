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
//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    self = [super initWithStyle:style reuseIdentifier:@"TextdetailsViewCell"];
//    if (self) {
//        [self initUI];
//    }
//    return self;
//}
- (void)awakeFromNib {
    [super awakeFromNib];
//    [self initUI];
}

//- (void)initUI {
//    [webView setDelegate:self];
//    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.ddaygo.com/item/customerservice"]];
//    [self addSubview:webView];
//    [webView loadRequest:request];
//}
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//}
//
//- (void) webViewDidStartLoad:(UIWebView *)webView {
//    //创建UIActivityIndicatorView背底半透明View
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZP_Width, ZP_height)];
//    [view setTag:108];
//    [view setBackgroundColor:[UIColor blackColor]];
//    [view setAlpha:0.5];
//    [self addSubview:view];
//    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
//    [activityIndicator setCenter:view.center];
//    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
//    [view addSubview:activityIndicator];
//    [activityIndicator startAnimating];
//    NSLog(@"webViewDidStartLoad");
//}
//
//- (void) webViewDidFinishLoad:(UIWebView *)webView {
//    [activityIndicator stopAnimating];
//    UIView * view = (UIView*)[self viewWithTag:108];
//    [view removeFromSuperview];
//    NSLog(@"webViewDidFinishLoad");
//
//}
//
//- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//    [activityIndicator stopAnimating];
//    UIView * view = (UIView*)[self viewWithTag:108];
//    [view removeFromSuperview];
//    NSLog(@"didFailLoadWithError:%@", error);
//}
@end
