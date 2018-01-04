//
//  ZeroViewCell.h
//  DDAYGO
//
//  Created by Login on 2017/9/13.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

#define zeroHeight 320.0/768.0 * ZP_Width

typedef void (^FinishBlock)(id response);
@interface ZeroViewCell : UITableViewCell

@property (nonatomic ,strong) FinishBlock finishBlock;
@end
