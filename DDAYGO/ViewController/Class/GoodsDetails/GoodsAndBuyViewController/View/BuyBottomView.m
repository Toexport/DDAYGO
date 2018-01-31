//
//  BuyBottomView.m
//  DDAYGO
//
//  Created by Login on 2017/9/14.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "BuyBottomView.h"

@implementation BuyBottomView

+ (instancetype)view
{
    return [[[NSBundle mainBundle] loadNibNamed:@"BuyBottomView" owner:nil options:nil] firstObject];
}

@end
