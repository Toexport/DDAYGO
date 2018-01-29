//
//  HomePageViewController.h
//  DDAYGO
//
//  Created by Summer on 2018/1/16.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLButton.h"
#import "UIButton+Layout.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface HomePageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView * tableView;

@end
