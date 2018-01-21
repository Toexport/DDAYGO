//
//  CPViewController.h
//  DDAYGO
//
//  Created by Login on 2017/9/14.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>{
    
//    NSMutableArray *_cellArray;     //collectionView数据
}
//@property (strong, nonatomic) UITableView * myTableView;

@property (nonatomic, strong) UICollectionView * collectionView1;
@property (nonatomic, strong) UICollectionView * collectionView2;
@property (nonatomic, strong) UICollectionView * collectionView3;
@property (nonatomic, strong) UICollectionView * collectionView4;

@property (nonatomic, strong) NSNumber * fatherId;

@property (nonatomic, strong) NSString * nameStr;

@property (nonatomic, copy) NSString * titleString;

@property (nonatomic, copy) NSString * keyword;

//@property (nonatomic, strong) NSString * tagid;

@property (nonatomic, strong) UILabel * RemindLabel;
@end
