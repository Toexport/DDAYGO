//
//  FootprintCollectionViewCell.h
//  DDAYGO
//
//   Created by Login on 2017/9/7.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZP_FootprintModel.h"
@interface FootprintCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView * defaultimg; // 图片
@property (strong, nonatomic) IBOutlet UILabel * productname;  // 标题
@property (strong, nonatomic) IBOutlet UILabel *productprice; // 商品价格
@property (strong, nonatomic) IBOutlet UILabel * cp; // 商品cp
@property (weak, nonatomic) IBOutlet UIButton *deleBtn;

- (void)FootprintCollection:(ZP_FootprintModel *)model;

@end
