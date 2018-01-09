//
//  MainViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/7.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "ClassificationViewController.h"
#import "ShoppingViewController.h"
#import "OrderViewController.h"
#import "MyViewController.h"
#import "ThemeManager.h"
#import "UITabBarItem+Theme.h"
#import "UIImage+Image.h"
#import "UIImage+Render.h"
#import "myNavigationController.h"
#import "PrefixHeader.pch"
#define AboveIOS9  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)

@interface MainViewController ()

@end

@implementation MainViewController

+ (void)load {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //字体颜色
    dict[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#828C98"];
    //字体大小
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionary];
    //字体颜色
    dict2[NSForegroundColorAttributeName] = [UIColor orangeColor];
    if (AboveIOS9) {
        UITabBarItem *tabbarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
        
        [tabbarItem setTitleTextAttributes:dict forState:UIControlStateNormal];
        
        [tabbarItem setTitleTextAttributes:dict2 forState:UIControlStateSelected];
        
        UITabBar *tabbar = [UITabBar appearanceWhenContainedInInstancesOfClasses:@[self]];
        [tabbar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
        
    }else{
        
        [[UITabBarItem appearance] setTitleTextAttributes:dict forState:UIControlStateNormal];
        [[UITabBarItem appearance]  setTitleTextAttributes:dict2 forState:UIControlStateSelected];
        
        [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTabBarUI];
}

- (void) initTabBarUI {
//    [[NSUserDefaults standardUserDefaults] setObject:@"6d864a3ef88554499df1878adcd65429" forKey:@"token"];
    //  字体颜色
    //    NSDictionary * dictHome = [NSDictionary dictionaryWithObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    //  主页
    
    Token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    ZPICUEToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"icuetoken"];
    
    [self setupOneChirlVc:[[HomeViewController alloc] init] withImage:[UIImage imageNamedWithOriginalImage:@"ic_tab_home_normal.png"] selImage:[UIImage imageNamedWithOriginalImage:@"ic_tab_home_pressed.png"] title:NSLocalizedString(@"Home", nil)];
    
    //  类
    
    [self setupOneChirlVc:[[ClassificationViewController alloc] init] withImage:[UIImage imageNamedWithOriginalImage:@"ic_tab_sort_normal.png"] selImage:[UIImage imageNamedWithOriginalImage:@"ic_tab_sort_pressed.png"] title:NSLocalizedString(@"Class", nil)];
    
    //  购物车
    
    [self setupOneChirlVc:[[ShoppingViewController alloc] init] withImage:[UIImage imageNamedWithOriginalImage:@"ic_tab_shopping_normal.png"] selImage:[UIImage imageNamedWithOriginalImage:@"ic_tab_shopping_pressed.png"] title:NSLocalizedString(@"Shopping", nil)];
    
    //  订单
    [self setupOneChirlVc:[[OrderViewController alloc] init] withImage:[UIImage imageNamedWithOriginalImage:@"ic_tab_order_normal.png"] selImage:[UIImage imageNamedWithOriginalImage:@"ic_tab_order_pressed.png"] title:NSLocalizedString(@"Order", nil)];
    
    //  个人中心
    [self setupOneChirlVc:[MyViewController sharedInstanceTool] withImage:[UIImage imageNamedWithOriginalImage:@"ic_tab_Persona_normal.png"] selImage:[UIImage imageNamedWithOriginalImage:@"ic_tab_Persona_pressed.png"] title:NSLocalizedString(@"My", nil)];
    
}


- (void)setupOneChirlVc:(UIViewController*)VC withImage:(UIImage *)image selImage:(UIImage *)selImage title:(NSString *)title {
    myNavigationController*nav = [[myNavigationController alloc] initWithRootViewController:VC];
    [self addChildViewController:nav];
    nav.tabBarItem.title = title;
    
    nav.tabBarItem.image = image;
    nav.tabBarItem.selectedImage = selImage;
    
}

@end

