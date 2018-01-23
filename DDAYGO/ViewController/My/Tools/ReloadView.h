//
//  LXReloadView.h
//  分秒购
//
//  Created by 晓玮 on 16/8/31.
//  Copyright © 2016年 深圳来创智能科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^touch)(void);

@interface ReloadView : UIView
@property (copy, nonatomic)touch touchAction;
+ (void)showToView:(UIView *)view touch:(touch)touchAction;
+ (void)dismissFromView:(UIView *)superView;
@end
