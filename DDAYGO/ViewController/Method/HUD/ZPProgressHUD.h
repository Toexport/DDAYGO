//
//  ZPProgressHUD.h

//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef enum : NSUInteger{
    ZPProgressHUDMaskTypeNone = 1,
    ZPProgressHUDMaskTypeBlack
} ZPProgressHUDMaskType;

@interface ZPProgressHUD : NSObject
+ (void)showWithStatus:(NSString *)status maskType:(ZPProgressHUDMaskType)maskType;
+ (void)showErrorWithStatus:(NSString *)status toViewController:(UIViewController *)viewController;
+ (void)showSuccessWithStatus:(NSString *)status toViewController:(UIViewController *)viewController;
+ (void)dismiss;
+ (void)showErrorWithStatus:(NSString *)status;

@end
