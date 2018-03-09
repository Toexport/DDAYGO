//
//  ZP_ExtractController.h
//  DDAYGO
//
//  Created by Summer on 2017/12/5.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PromptBoxView.h"
@interface ZP_ExtractController : PromptBoxView
@property (strong, nonatomic) IBOutlet UITableView * tableView;
@property (nonatomic, strong) UILabel * DateTimeLabel;
/**
 * 供货商ID
 */
@property (nonatomic, strong) NSNumber * supplierId;










@end
