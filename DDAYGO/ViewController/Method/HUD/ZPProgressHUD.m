//
//  ZPProgressHUD.m

//

#import "ZPProgressHUD.h"
#import "SVProgressHUD.h"
#import "PrefixHeader.pch"
@implementation ZPProgressHUD

+ (void)initialize {
    
    [SVProgressHUD setMinimumDismissTimeInterval:0.3];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"#000000" alpha:0.5]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setSuccessImage:[UIImage imageNamed:@"success"]];
    [SVProgressHUD setErrorImage:[UIImage imageNamed:@"error"]];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];

}

+ (void)showWithStatus:(NSString *)status maskType:(ZPProgressHUDMaskType)maskType {
    switch (maskType) {
        case ZPProgressHUDMaskTypeNone:
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            break;
        case ZPProgressHUDMaskTypeBlack:
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            break;
        default:
            break;
    }
    
    [SVProgressHUD showWithStatus:status];
}

+(void)showSuccessWithStatus:(NSString *)status toViewController:(UIViewController *)viewController{
    if (viewController.isViewLoaded && viewController.view.window) {
        [SVProgressHUD showSuccessWithStatus:status];
    }
    else{
        [self dismiss];
    }
}

+ (void)showErrorWithStatus:(NSString *)status toViewController:(UIViewController *)viewController{
    
    if (viewController.isViewLoaded && viewController.view.window) {
        [SVProgressHUD showErrorWithStatus:status];
    }
    else{
        [self dismiss];
    }
}

+ (void)dismiss{
    [SVProgressHUD dismiss];
}

+ (void)showErrorWithStatus:(NSString *)status{
    [SVProgressHUD showErrorWithStatus:status];
}

@end
