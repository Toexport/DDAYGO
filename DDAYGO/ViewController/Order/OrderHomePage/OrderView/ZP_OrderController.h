//
//  ZP_OrderController.h
//  DDAYGO
//
//  Created by Summer on 2017/11/24.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSSegmentTitleView.h"
#import "PromptBoxView.h"
@interface ZP_OrderController : PromptBoxView<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) NSString * titleStr;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, strong) UILabel * RemindLabel;
@property (nonatomic, strong) FSSegmentTitleView * titleView;

@end


