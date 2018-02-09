//
//  CPCollectionViewController.h
//  DDAYGO
//
//  Created by Summer on 2018/1/27.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPCollectionViewController : UIViewController

@property (nonatomic, strong) NSNumber * fatherId;

@property (nonatomic, strong) NSString * nameStr;

@property (nonatomic, copy) NSString * titleString;

@property (nonatomic, copy) NSString * keyword;

@property (nonatomic, strong) NSString * priceStrTag;

@property (nonatomic, strong) UILabel * RemindLabel;

@property (nonatomic, assign) NSInteger type; // 查看更多
@property (nonatomic, assign) NSInteger typee; //  商品分类
@property (nonatomic, assign) NSInteger typeew;  // 81) 闪购精选热销商品筛选

- (void)allData;

@end
