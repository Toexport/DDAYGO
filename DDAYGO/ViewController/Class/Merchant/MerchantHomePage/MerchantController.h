//
//  MerchantController.h
//  DDAYGO
//
//  Created by Login on 2017/10/24.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MerchantController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView * collectionView1;
@property (nonatomic, strong) UICollectionView * collectionView2;
@property (nonatomic, strong) UICollectionView * collectionView3;
@property (nonatomic, strong) UICollectionView * collectionView4;
@property (nonatomic, strong)UIImageView * imageview;
@property (nonatomic, strong) NSString * priceStrTag;
@property (nonatomic, strong) NSNumber * Supplieerid; // 供货商ID
@property (nonatomic, strong) NSNumber * fatherId;
@end
