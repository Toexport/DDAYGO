//
//  CollectionTableViewCell.h
//  DDAYGO
//
//   Created by Login on 2017/9/7.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "collectionModel.h"
@interface CollectionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView * ShopimageView;  // 主图
@property (weak, nonatomic) IBOutlet UILabel * shopTextLabel;  // 标题
@property (weak, nonatomic) IBOutlet UILabel * priceLabel;  // 价格
@property (strong, nonatomic) IBOutlet UILabel * Cp; // 编号

@property (nonatomic, strong) collectionModel *model;

@end

