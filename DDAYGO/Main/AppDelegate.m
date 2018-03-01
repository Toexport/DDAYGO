//
//  AppDelegate.m
//  DDAYGO
//
//  Created by Login on 2017/9/7.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "AppDelegate.h"
#import "ThemeManager.h"
#import "MainViewController.h"
#import "NotificationMacro.h"
#import "NSBundle+Language.h"
#import "PrefixHeader.pch"
#import "HomePageViewController.h"
#import "ClassificationViewController.h"
#import "ShoppingViewController.h"
#import "OrderViewController.h"
#import "MyViewController.h"
#import "LogregisterController.h"

#import <IQKeyboardManager.h>

@interface AppDelegate ()<UITabBarControllerDelegate>
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSString *current = [NSLocale preferredLanguages][0];
    
    if (![current isEqualToString:@"zh-Hant"] && ![current isEqualToString:@"zh-Hans"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@[@"zh-Hant"] forKey:@"AppleLanguages"];
        [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hant" forKey:@"Language"];
        [NSBundle setLanguage:@"zh-Hant"];
    }
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    [self MainViewController];
    [self initUserDefaultConfig];
    return YES;
}
- (void)MainViewController {
    
    MainViewController * rootViewController = [[MainViewController alloc]init];
    rootViewController.delegate = self;
    self.window.rootViewController = rootViewController;
    self.window.backgroundColor = [UIColor whiteColor];
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController * nav = viewController;
        UIViewController *firstVC = [nav.viewControllers firstObject];
        UINavigationController *homeVC = tabBarController.selectedViewController;
        if ([firstVC isMemberOfClass:[HomePageViewController class]]) {
            return YES;
        }
        else if ([firstVC isMemberOfClass:[ClassificationViewController class]]) {
            return YES;
        }
        else if ([firstVC isMemberOfClass:[ShoppingViewController class]]) {
            if (Token.length > 0) {
                return YES;
            }else{
                //跳转到登录
                LogregisterController * Login = [[LogregisterController alloc]init];
                [homeVC pushViewController:Login animated:YES];
                [SVProgressHUD showErrorWithStatus:MyLocal(@"Please log in")];
                return NO;}
        }
        else if ([firstVC isMemberOfClass:[OrderViewController class]]) {
            if (Token.length > 0) {
                return YES;
            }else{
                //跳转到登录
                LogregisterController * Login = [[LogregisterController alloc]init];
                [homeVC pushViewController:Login animated:YES];
                [SVProgressHUD showErrorWithStatus:MyLocal(@"Please log in")];
                return NO;
            }
        }
        else {
            if (Token.length > 0) {
                return YES;
            }else {
                //跳转到登录
                LogregisterController * Login = [[LogregisterController alloc]init];
                [homeVC pushViewController:Login animated:YES];
                [SVProgressHUD showErrorWithStatus:MyLocal(@"Please log in")];
                return NO;
            }
        }
    }
    else {
        return YES;
    }

}

- (void)initUserDefaultConfig {
    NSString * themeName = [[NSUserDefaults standardUserDefaults] objectForKey:kThemeChangedNotification];
    ThemeManager * themeManager = [ThemeManager sharedThemeManager];
    themeManager.themeNage = themeName;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
