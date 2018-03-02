//
//  UIViewController+Listening.m
//  DDAYGO
//
//  Created by Summer on 2018/3/2.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import "UIViewController+Listening.h"
#import "PrefixHeader.pch"
@implementation UIViewController (Listening)

- (void)listening {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(adjustStatusBar:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

// 热点被接入，子类重写
- (void)adjustStatusBar:(NSNotification *)notification {
    NSValue * rectValue = [notification.userInfo objectForKey:UIApplicationStatusBarFrameUserInfoKey];
    CGRect statusRect = [rectValue CGRectValue];
    CGFloat height = statusRect.size.height;
    if (height > 20) {
        appD.window.frame = CGRectMake(0, 40, ZP_Width, ZP_height - 40);
    }else{
        appD.window.frame = CGRectMake(0, -40, ZP_Width, ZP_height);
    }
    
}


@end
