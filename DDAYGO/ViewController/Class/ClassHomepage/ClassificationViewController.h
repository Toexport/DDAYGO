//
//  ClassificationViewController.h
//  DDAYGO
//
//
//  Created by Login on 2017/9/7.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassificationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView * leftTableView;
@property (weak, nonatomic) IBOutlet UITableView * rightTableView;

- (void)getRightItemDataWithProducttypeid:(NSInteger)producttypeid;

@end
