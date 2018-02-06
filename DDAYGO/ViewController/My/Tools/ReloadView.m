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
@property (nonatomic, strong) UILabel * label1;
@property (nonatomic, strong) UILabel * label2;
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
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconn_no_network"]];
    imageView.frame = CGRectMake(ZP_Width / 2 - 15, ZP_height / 2 - 90, 30, 25);
    self.imageView.center = self.center;
    
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(ZP_Width / 2 - 70,CGRectGetMaxY(imageView.frame)+ 20, 150, 15)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text =NSLocalizedString(@"網路異常,請檢查您的網路", nil);
    label1.font = ZP_stockFont;
    
    UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(ZP_Width / 2 - 20, CGRectGetMaxY(label1.frame) + 25, 50, 30)];
    label2.text = NSLocalizedString(@"刷新", nil);
    label2.textAlignment = NSTextAlignmentCenter;
    label2.backgroundColor = [UIColor orangeColor];
    label2.font = ZP_stockFont;
    [self addSubview:imageView];
    [self addSubview:label1];
    [self addSubview:label2];
    self.imageView = imageView;
    self.label1 = label1;
    self.label2 = label2;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //设置imageView的frame
}

+ (instancetype)reloadView{
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
