//
//  CollectionViewController.h
//  DDAYGO
//
//   Created by Login on 2017/9/7.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZP_GoodDetailsModel.h"
@interface CollectionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView * tableView;
@property (nonatomic, strong) ZP_GoodDetailsModel * model;
@end
