//
//  UIView+Frame.m
//  DDAYGO
//
//  Created by Summer on 2017/11/28.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
- (CGFloat)lq_height
{
    return self.frame.size.height;
}

- (void)setLq_height:(CGFloat)lq_height
{
    CGRect frame = self.frame;
    frame.size.height = lq_height;
    self.frame = frame;
}
- (CGFloat)lq_width
{
    return self.frame.size.width;
}

- (void)setLq_width:(CGFloat)lq_width
{
    CGRect frame = self.frame;
    frame.size.width = lq_width;
    self.frame = frame;
}

- (void)setLq_x:(CGFloat)lq_x
{
    CGRect frame = self.frame;
    frame.origin.x = lq_x;
    self.frame = frame;
    
}
- (CGFloat)lq_x
{
    return self.frame.origin.x;
}

- (void)setLq_y:(CGFloat)lq_y
{
    CGRect frame = self.frame;
    frame.origin.y = lq_y;
    self.frame = frame;
}
- (CGFloat)lq_y
{
    return self.frame.origin.y;
}

- (void)setLq_centerX:(CGFloat)lq_centerX
{
    CGPoint center = self.center;
    center.x = lq_centerX;
    self.center = center;
}
- (CGFloat)lq_centerX
{
    return self.center.x;
}
- (void)setLq_centerY:(CGFloat)lq_centerY
{
    CGPoint center = self.center;
    center.y = lq_centerY;
    self.center = center;
}
- (CGFloat)lq_centerY
{
    return self.center.y;
}

- (void)setLq_bottom:(CGFloat)lq_bottom
{
    CGRect frame = self.frame;
    frame.origin.y = lq_bottom - self.lq_height;
    self.frame = frame;
}
- (CGFloat)lq_bottom
{
    return self.lq_y + self.lq_height;
}

- (void)setLq_right:(CGFloat)lq_right{
    CGRect frame = self.frame;
    frame.origin.x = lq_right - self.lq_width;
    self.frame = frame;
}

- (CGFloat)lq_right{
    return self.lq_x + self.lq_width;
}


@end


@implementation UIView (cornerRadius)

-(void)setMyCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.layer.shouldRasterize = YES;
}

@end

