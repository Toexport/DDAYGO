//
//  MyViewController.h
//  DDAYGO
//
//  Created by Login on 2017/9/7.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel * NameLabel;
@property (nonatomic ,assign) BOOL hasLogin;

+ (MyViewController *)sharedInstanceTool;

- (void)autoLogin:(void (^)(id obj))success;
@end
