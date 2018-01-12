//
//  SelectView.h
//  DDAYGO
//
//  Created by Summer on 2018/1/12.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectModel.h"
@interface SelectView : UIView

@property (nonatomic, strong) UITableView * tableView;

/**
 *  显示属性选择视图
 *
 *  @param view 要在哪个视图中显示
 */
- (void)showInView:(UIView *)view;

/**
 *  属性视图的消失
 */
- (void)removeView;


@property (nonatomic, strong) NSArray *dataArray;

@end
