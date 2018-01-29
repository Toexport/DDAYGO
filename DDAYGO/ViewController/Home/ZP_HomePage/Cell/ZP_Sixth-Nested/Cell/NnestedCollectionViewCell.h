//
//  NnestedCollectionViewCell.h
//  DDAYGO
//
//  Created by Summer on 2018/1/29.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZP_SixthModel.h"
@interface NnestedCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView * ImageView;
@property (weak, nonatomic) IBOutlet UILabel * titleLabel;
@property (weak, nonatomic) IBOutlet UILabel * priceLabel;
@property (weak, nonatomic) IBOutlet UILabel * TrademarkLabel;

- (void)cellWithdic:(ZP_SixthModel *)dic;
@end
