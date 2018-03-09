//
//  MerchantController.h
//  DDAYGO
//
//  Created by Login on 2017/10/24.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PromptBoxView.h"
@interface MerchantController : PromptBoxView<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView * collectionView1;
@property (nonatomic, strong) UICollectionView * collectionView2;
@property (nonatomic, strong) UICollectionView * collectionView3;
@property (nonatomic, strong) UICollectionView * collectionView4;
@property (nonatomic, strong)UIImageView * imageview;  // 主图没有数据的时候不显示，有数据显示
@property (nonatomic, strong) NSString * priceStrTag;
@property (nonatomic, strong) NSNumber * Supplieerid; // 供货商ID
@end
