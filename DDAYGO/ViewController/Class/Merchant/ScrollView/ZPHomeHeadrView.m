//
//  ZPHomeHeadrView.m
//  merchants
//
//  Created by Summer on 2017/9/18.
//  Copyright © 2017年 PENG.ZHANG. All rights reserved.
//

#import "ZPHomeHeadrView.h"
#import "ZPLoopView.h"
//#import "ZPHomeHeadrCell.h"
#import "ZPHomeHeaderLayout.h"
#define JFSCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width//屏幕宽度
#define JFSCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height//屏幕高度

static NSString * ID = @"homeCollectionViewCell";

@interface ZPHomeHeadrView ()


/** 菜单按钮图片  */
@property (nonatomic, strong) NSMutableArray * buttonIconMutableArray;

@end
@implementation ZPHomeHeadrView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        //   添加图片轮播器
        CGFloat loopViewH = 200;
//        NSArray * imageArray = @[@"banner_jiazai.jpg",@"banner_jiazai.jpg",@"banner_jiazai.jpg"];
//        ZPLoopView * loopView = [[ZPLoopView alloc] initWithImageArray:imageArray];
//        loopView.frame = CGRectMake(0, 0, JFSCREEN_WIDTH, loopViewH);
//        [self addSubview:loopView];
        
    }
    return self;
}
@end
