//
//  CPerViewController.h
//  DDAYGO
//
//  Created by Summer on 2018/1/27.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPerViewController : UIViewController
@property (nonatomic, strong) NSNumber * fatherId;

@property (nonatomic, strong) NSString * nameStr;

@property (nonatomic, copy) NSString * titleString;

@property (nonatomic, copy) NSString * keyword;

@property (nonatomic, strong) NSString * priceStrTag; //价格筛选

@property (nonatomic, strong) UILabel * RemindLabel;

//@property (nonatomic, assign) NSInteger type;

@end
