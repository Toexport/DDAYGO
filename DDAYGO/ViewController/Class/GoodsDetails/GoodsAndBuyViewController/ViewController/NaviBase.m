//
//  NaviBase.m
//  DDAYGO
//
//  Created by Login on 2017/9/14.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "NaviBase.h"
#import "global.h"

@interface NaviBase ()

@end

@implementation NaviBase
/**
 这个方法只会在类第一次使用的时候调用
 */
+(void)initialize{
    [super initialize];
    UINavigationBar* NaviBar = [UINavigationBar appearance];
    [NaviBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //设置主题字体颜色
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [NaviBar setTitleTextAttributes:dict];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    for(UIView* view in self.navigationBar.subviews){
        for(UIView* vi in view.subviews){
            if([vi isKindOfClass:[UIImageView class]]){
                [vi removeFromSuperview];
            }
        }
    }
}
@end
