//
//  NoDataView.m
//  DDAYGO
//
//  Created by Summer on 2018/2/1.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import "NoDataView.h"

@implementation NoDataView

+ (void)initWithSuperView:(UIView *)superView Content:(NSString *)content FinishBlock:(FinishBlock)finishBlock {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NoDataView * noDataView =  [[[NSBundle mainBundle] loadNibNamed:@"NoDataView" owner:self options:nil] lastObject];
        noDataView.frame = CGRectMake(superView.frame.size.width/2-100, superView.frame.size.height/2-60, 200, 120);
        if (content) {
            noDataView.contentLabel.text = content;
        }
        [superView addSubview:noDataView];
        finishBlock(noDataView);
    });
}

@end
