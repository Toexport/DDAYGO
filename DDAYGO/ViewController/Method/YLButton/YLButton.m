
//
//  YLButton.m
//  YLButton
//
//  Created by HelloYeah on 2016/11/24.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "YLButton.h"

@implementation YLButton

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    if (!CGRectIsEmpty(self.titleRect) && !CGRectEqualToRect(self.titleRect, CGRectZero)) {
        return self.titleRect;
    }
    return [super titleRectForContentRect:contentRect];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    if (!CGRectIsEmpty(self.imageRect) && !CGRectEqualToRect(self.imageRect, CGRectZero)) {
        return self.imageRect;
    }
    return [super imageRectForContentRect:contentRect];
}

//
- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(0, self.titleLabel.frame.origin.y, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
    self.imageView.frame = CGRectMake(self.titleLabel.frame.size.width + 2, self.imageView.frame.origin.y, self.imageView.frame.size.width, self.imageView.frame.size.height);
}

- (void)sizeToFit {
    [super sizeToFit];
    [self setNeedsLayout];
}
@end
