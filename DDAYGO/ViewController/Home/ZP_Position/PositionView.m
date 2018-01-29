//
//  PositionView.m
//  DDAYGO
//
//  Created by Login on 2017/9/18.
//  Copyright © 2017年 Summer. All rights reserved.
//
#import "PositionView.h"
#import "PrefixHeader.pch"
#import "ZP_PositionModel.h"
#import "UIImageView+WebCache.h"
#define kATTR_VIEW_HEIGHT (kHeight-215)

///******* 屏幕尺寸 *******/
#define     kWidth      [UIScreen mainScreen].bounds.size.width - 30
#define     kHeight     [UIScreen mainScreen].bounds.size.height - 50

@interface PositionView () <UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIView * contentView;
@property (nonatomic, strong) UIButton * button;
@property (nonatomic, strong) NSArray * arrar;
@property (nonatomic, strong) NSArray * arr;
@property (nonatomic, strong) NSString * titleStr;
@property (nonatomic, assign) NSInteger titleteger;
@end

@implementation PositionView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

#pragma mark - setupViews
/**
 *  设置视图的基本内容
 */
- (void)setupViews {
//  添加手势，点击背景视图消失
    UITapGestureRecognizer *tapBackGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
    tapBackGesture.delegate = self;
    [self addGestureRecognizer:tapBackGesture];
    UIView * bounceView = [UIView new];
    bounceView.backgroundColor = ZP_Graybackground;
    bounceView.layer.cornerRadius = 5.0;// View圆角弧度
    [self addSubview:bounceView];
    self.contentView = bounceView;
    [bounceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(150);
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self).offset(-TabbarHeight);
        
    }];
    
//  标题
    UILabel * titleLabel = [UILabel new];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textColor = ZP_textblack;
    titleLabel.text = NSLocalizedString(@"Choose your country", nil) ;
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [bounceView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bounceView).offset(20); // 上面
        make.left.equalTo(bounceView).offset(60); // 左边
        make.right.equalTo(bounceView).offset(- 60);
        make.width.mas_offset(ZP_height - 70 - 60);
        make.height.mas_offset(25);
    }];
    
}

- (void)Position:(NSArray *)sup {
    self.arr = sup;
    NSInteger num = 0;
    int z = 0;
    for (int i = 0; i < sup.count; i ++) {
        ZP_PositionModel *model = sup[i];
        if (i>0 && i%2==0) {
            z ++;
        }
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake((i-z*2) * (ZP_Width-40) / 2 + 5, z * 45 + 110, (ZP_Width-40) / 2 - 5, 0.5)];
        [view setBackgroundColor:ZP_DeepBlue];
        
        [self.contentView addSubview:view];
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake((i-z*2) * ZP_Width / 2 + 10 , z * 45 + 70, ZP_Width / 2- 40 , 35)];
        btn.titleLabel.font = ZP_titleFont;
        [btn setTitleColor:ZP_textblack forState:UIControlStateNormal];
        
        [self ZP_setButton:btn ImageWithUrl:model.imgurl WithName:model.name];
        
        btn.tag = num;
        [btn addTarget:self action:@selector(buttonType:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        num ++;
        
    }
    
}

#pragma mark - 点击事件
- (void)buttonType:(UIButton * )sender {
    self.titleteger = sender.tag;
    ZP_PositionModel * model = self.arr[sender.tag];
    self.ThirdBlock(model.name,model.code);
    [self removeView];
    
}
#pragma mark - UIGestureRecognizerDelegate
//  确定点击范围
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isDescendantOfView:self.contentView]) {
        return NO;
    }
    return YES;
}

#pragma mark - public
/**
 *  显示属性选择视图
 *
 *  @param view 要在哪个视图中显示
 */
- (void)showInView:(UIView *)view {
    [view addSubview:self];
    __weak typeof(self) _weakSelf = self;
    self.contentView.frame = CGRectMake(15, kHeight, kWidth, kATTR_VIEW_HEIGHT);;
    
    [UIView animateWithDuration:0.3 animations:^{
        _weakSelf.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        _weakSelf.contentView.frame = CGRectMake(15, kHeight - kATTR_VIEW_HEIGHT, kWidth, kATTR_VIEW_HEIGHT);
    }];
}

/**
 *  属性视图的消失
 */
- (void)removeView {
    __weak typeof(self) _weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        _weakSelf.backgroundColor = [UIColor clearColor];
        _weakSelf.contentView.frame = CGRectMake(15, kHeight, kWidth, kATTR_VIEW_HEIGHT);
    } completion:^(BOOL finished) {
        [_weakSelf removeFromSuperview];
    }];
}


/**
 *  异步加载图片
 */
- (void)ZP_setButton:(UIButton *)btn ImageWithUrl:(NSString *)urlStr WithName:(NSString *)name{
    
    [[SDImageCache sharedImageCache] storeImage:btn.imageView.image forKey:urlStr toDisk:NO];
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:urlStr] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        // 主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            CGSize imagesize;
            imagesize.height = 40;
            imagesize.width = image.size.width/(image.size.height/40);
            UIImage *image1 = [self imageWithImage:image scaledToSize:imagesize];
            [btn setImage:image1 forState:UIControlStateNormal];
            [btn setTitle:name forState:UIControlStateNormal];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        });
    }];
}


- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

@end
