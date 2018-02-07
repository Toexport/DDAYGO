//
//  BuyViewController.h
//  DDAYGO
//
//  Created by Login on 2017/9/14.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+UIButtonImageWithLable.h"

@interface BuyViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView * onScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView * smallScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * onScrollViewWidth;
@property (strong, nonatomic) UIPageControl * pageControl;
@property (weak, nonatomic) IBOutlet UIButton * shoucangBtn;
@property (weak, nonatomic) IBOutlet UIButton * gouwuBtn;
@property (weak, nonatomic) IBOutlet UIButton * dianpuBtn;
@property (weak, nonatomic) IBOutlet UIScrollView * scrollView;
@property (weak, nonatomic) IBOutlet UIView * cpnrBottomView;
@property (weak, nonatomic) IBOutlet UIView * shfwBottomView;
@property (weak, nonatomic) IBOutlet UIView * qbpjBottomView;
@property (nonatomic, assign) NSInteger type; //识别号

@property (nonatomic, strong) NSNumber * productId;

@property (nonatomic, strong) NSNumber * fatherId;

@end
