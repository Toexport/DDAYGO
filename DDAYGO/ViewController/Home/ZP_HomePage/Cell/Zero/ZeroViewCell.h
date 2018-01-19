//
//  ZeroViewCell.h
//  DDAYGO
//
//  Created by Login on 2017/9/13.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#define zeroHeight 320.0/768.0 * ZP_Width
#import "ZP_ZeroModel.h"
typedef void (^FinishBlock)(id response);
@interface ZeroViewCell : UITableViewCell

@property (nonatomic ,strong) NSMutableArray * arr;
@property (nonatomic ,strong) SDCycleScrollView * scrollView;


@property (nonatomic ,strong) FinishBlock finishBlock;
@end
