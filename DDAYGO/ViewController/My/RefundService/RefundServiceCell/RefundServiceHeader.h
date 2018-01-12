//
//  RefundServiceHeader.h
//  DDAYGO
//
//  Created by Summer on 2018/1/12.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefundServiceHeader : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UITableView *Tableview;

@property (nonatomic, copy) void(^RefundServiceHeaderBlock)(NSInteger tag);
@end
