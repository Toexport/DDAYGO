//
//  ShopevaluationViewCell.h
//  DDAYGO
//
//  Created by Login on 2017/9/25.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopevaluationViewCell : UITableViewCell<UITextFieldDelegate>
@property (nonatomic, strong) UIImageView * merchantsImage;
@property (nonatomic, strong) UILabel * merchantsLabel;
@property (nonatomic, strong) UITextField * Storeratingstext;
@property (nonatomic, strong) UIButton * Anonymousbutton;

@property (nonatomic, strong) UIButton * scoreBut;
@property (nonatomic, strong) UILabel * Anonymouslabel;
@property (nonatomic, strong) NSMutableArray *scoreButArray;
@property (nonatomic, copy) void(^ShopevaluationBlock)(NSInteger tag);
- (void)Shopevaluation:(NSArray *)Shopevaluation;

@property (nonatomic, copy) void (^ savaData)(NSString *title);

@end
