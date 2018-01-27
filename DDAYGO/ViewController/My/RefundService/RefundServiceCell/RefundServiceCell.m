//
//  RefundServiceCell.m
//  DDAYGO
//
//  Created by Summer on 2018/1/10.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import "RefundServiceCell.h"

@implementation RefundServiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (UIImageView *)MaimImageView {
    [_MaimImageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
    _MaimImageView.contentMode =  UIViewContentModeScaleAspectFill;
    _MaimImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _MaimImageView.layer.contentsGravity = kCAGravityResizeAspectFill;
    _MaimImageView.clipsToBounds  = YES;
    return _MaimImageView;
}
@end
