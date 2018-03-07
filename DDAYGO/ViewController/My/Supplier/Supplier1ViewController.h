//
//  Supplier1ViewController.h
//  DDAYGO
//
//  Created by Summer on 2017/12/29.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Supplier1ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView * tableView;
@property (weak, nonatomic) IBOutlet UIView *noStoreView;
@property (weak, nonatomic) IBOutlet UIButton *sendingBtn;
@property (assign, nonatomic) NSInteger stausType;
@property (weak, nonatomic) IBOutlet UILabel * TExtLabel; // 状态Label
@property (nonatomic, strong) NSString * reason;
@property (nonatomic, strong) NSString * TExtLabel1; // 状态Label

@property (weak, nonatomic) IBOutlet UILabel * LocationLabel; // 地区Label


@end
