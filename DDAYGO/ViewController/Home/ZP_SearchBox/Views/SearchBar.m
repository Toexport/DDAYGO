//
//  SearchBar.m
//  DDAYGO
//
//  Created by Login on 2017/9/8.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "SearchBar.h"
#import "UIImage+Extension.h"
#import "UIView+Extension.h"
@implementation SearchBar

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //        设置背景
        self.background = [UIImage resizedImage:@"input_home_search"];
        //        设置内容 -- 垂直居中
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        //        设置左边显示一个放大镜
        UIImageView * leftView = [[UIImageView alloc]init];
        leftView.image = [UIImage imageNamed:@"nav_menu_search"];
        leftView.width = leftView.image.size.width + 10;
        leftView.height = leftView.image.size.height;
        //        设置leftView的内容居中
        leftView.contentMode = UIViewContentModeCenter;
        self.leftView = leftView;
        //        设置左边的View永远显示
        self.leftViewMode = UITextFieldViewModeAlways;
        //        设置右边永远显示清除按钮
        self.clearButtonMode = UITextFieldViewModeAlways;
    }
    return self;
}

+ (instancetype)searchBar {
    return [[self alloc]init];
}
@end
