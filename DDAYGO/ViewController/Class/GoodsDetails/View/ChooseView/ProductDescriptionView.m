//
//  ProductDescriptionView.m
//  DDAYGO
//
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ProductDescriptionView.h"
#import "UIView+Additions.h"

@implementation ProductDescriptionView

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    self.BGView.userInteractionEnabled = YES;
    [self.BGView addGestureRecognizer:tap];
    self.hidden = YES;
}

- (void)show {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.hidden = NO;
        self.BGView.alpha = 0;
        self.detailView.alpha = 1;
        self.detailView.originY = self.height;
        [UIView animateWithDuration:.3f animations:^{
            self.BGView.alpha = 0.5;
            self.detailView.originY = self.height - 300;
        } completion:^(BOOL finished) {
        }];
    });
}

- (void)dismiss {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.3f animations:^{
            self.BGView.alpha = 0;
            self.detailView.originY = self.height;
        } completion:^(BOOL finished) {
            self.hidden = YES;
        }];
    });
}

- (IBAction)dismiss:(id)sender {
    [self dismiss];
}
- (IBAction)ok:(id)sender {
    [self dismiss];
}

@end
