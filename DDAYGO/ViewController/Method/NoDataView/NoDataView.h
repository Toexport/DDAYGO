//
//  NoDataView.h
//  DDAYGO
//
//  Created by Summer on 2018/2/1.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^FinishBlock)(id response);
@interface NoDataView : UIView
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
+ (void)initWithSuperView:(UIView *)superView Content:(NSString *)content FinishBlock:(FinishBlock)finishBlock;
@end
