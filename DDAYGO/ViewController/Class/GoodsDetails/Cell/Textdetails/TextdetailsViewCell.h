//
//  TextdetailsViewCell.h
//  
//
//  Created by Login on 2017/9/18.
//
//

#import <UIKit/UIKit.h>

@interface TextdetailsViewCell : UITableViewCell {
    
    UIActivityIndicatorView * activityIndicator;
}

@property (weak, nonatomic) IBOutlet UIWebView *webView;
//@property (nonatomic, strong)UILabel * preferentialLabel;
//@property (nonatomic, strong)UILabel * priceLabel;
//@property (nonatomic, strong)UILabel * stockLabel;
//@property (nonatomic, strong)UILabel * salesLabel;
//@property (nonatomic, strong)UILabel * numberingLabel;

//- (void)cellWithdic:(NSDictionary *)dic;
@end
