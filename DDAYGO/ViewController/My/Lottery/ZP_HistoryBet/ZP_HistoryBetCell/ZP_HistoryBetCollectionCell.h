//
//  ZP_HistoryBetCollectionCell.h
//  DDAYGO
//
//  Created by Summer on 2017/11/30.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZP_HistoryBetCollectionCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIButton *countBut;
- (void)setValue:(NSInteger)index;
@end