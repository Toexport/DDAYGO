//
//  CollectionViewController.h
//  DDAYGO
//
//   Created by Login on 2017/9/7.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "collectionModel.h"
#import "PromptBoxView.h"
@interface CollectionViewController : PromptBoxView
@property (weak, nonatomic) IBOutlet UITableView * tableView;
@property (nonatomic, strong) collectionModel * model;
@end
