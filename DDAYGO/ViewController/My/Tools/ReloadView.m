//
//  LXReloadView.m
//  分秒购
//
//  Created by 晓玮 on 16/8/31.
//  Copyright © 2016年 深圳来创智能科技有限公司. All rights reserved.
//

#import "ReloadView.h"
#import "PrefixHeader.pch"
@interface ReloadView ()
@property (nonatomic, weak)UIImageView *imageView;
//@property (nonatomic, strong) UILabel * label;
@end

@implementation ReloadView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupImageView];
    }
    return self;
}

//设置imgaeView
- (void)setupImageView{
//    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconn_no_network@3x"]];
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ZP_Width / 2, ZP_height / 2 + 100,30, 30)];
    [imageView setImage:[UIImage imageNamed:@"iconn_no_network"]];
//    label.text = @"网络异常，请检查您的网络";
//    [self addSubview:label];
    [self addSubview:imageView];
    self.imageView = imageView;
//    self.label = label;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //设置imageView的frame
    self.imageView.center = self.center;
//    self.label.center = self.center;
}

+ (instancetype)reloadView{
//    static LXReloadView *reloadView = nil;
//    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        reloadView = [[self alloc]init];
//    });
//    
    return [[self alloc]init];
}

+ (void)showToView:(UIView *)view touch:(touch)touchAction{
    ReloadView *reloadView = [self reloadView];
    reloadView.touchAction = touchAction;
    reloadView.frame = view.bounds;
    [view addSubview:reloadView];
}

+ (void)dismissFromView:(UIView *)superView{
//    [[self reloadView]removeFromSuperview];
    for (UIView *view in superView.subviews) {
        if ([view isKindOfClass:[self class]]) {
            [view removeFromSuperview];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.touchAction) {
        self.touchAction();
    }
}

@end
