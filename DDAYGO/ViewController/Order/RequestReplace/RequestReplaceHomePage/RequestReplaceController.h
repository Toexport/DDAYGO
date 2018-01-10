//
//  RequestReplaceController.h
//  DDAYGO
//
//  Created by Summer on 2018/1/10.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestReplaceController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *RequestReplaceScrollView; // 滚动视图
/** 第1个view */
@property (weak, nonatomic) IBOutlet UIView * MianView1; // Mainview
@property (weak, nonatomic) IBOutlet UIImageView * MianimageView; // 商品图片
@property (weak, nonatomic) IBOutlet UILabel * TitleLabel; // 商品文字
@property (weak, nonatomic) IBOutlet UILabel * DetailedLabel; // 商品详情
@property (weak, nonatomic) IBOutlet UILabel * NumberLabel; // 商品数量
/** 第2个view */
@property (weak, nonatomic) IBOutlet UIView * MainView2;
/** MainView2里面分组View1*/
@property (weak, nonatomic) IBOutlet UIView * view1;
@property (weak, nonatomic) IBOutlet UIButton * Refund;

/** MainView2里面分组View2*/
@property (weak, nonatomic) IBOutlet UIView * view2;
@property (weak, nonatomic) IBOutlet UIButton * RefundsRefunds;

/** MainView2里面分组View3*/
@property (weak, nonatomic) IBOutlet UIView * view3;
@property (weak, nonatomic) IBOutlet UIButton * Exchange;

@end
