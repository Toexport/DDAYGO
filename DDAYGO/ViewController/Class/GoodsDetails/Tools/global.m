//
//  global.m
//  DDAYGO
//
//  Created by Login on 2017/9/14.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "global.h"

@implementation global

/**
 从像素px转换为ios的点阵pt
 */
+ (CGFloat)pxTopt:(CGFloat)px {
    CGFloat standardPt = px/2.0;
    if (iphone5) {
        standardPt = (iphone5W/iphone6W)*standardPt;
    }else if(iphone6){
        
    }else if(iphone6plus){
        standardPt = (iphone6plusW/iphone6W)*standardPt;
    }else;
    return standardPt;
}

/**
 UIColor 转UIImage
 */
+ (UIImage*) createImageWithColor: (UIColor*) color {
    CGRect rect=CGRectMake(0,0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end
