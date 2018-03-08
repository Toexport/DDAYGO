//
//  PromptView.h
//  DDAYGO
//
//  Created by Summer on 2018/3/8.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromptView : UIViewController
@property (nonatomic, strong) UIAlertAction * okAction;
@property (nonatomic, strong) UIAlertAction * cancelAction;

- (void)LineIsBusyMode;
@end
