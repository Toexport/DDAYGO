//
//  global.h
//  DDAYGO
//
//  Created by Login on 2017/9/14.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define screenH [UIScreen mainScreen].bounds.size.height
#define screenW [UIScreen mainScreen].bounds.size.width
#define color(r,g,b,al) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:al]
#define font(size) [UIFont systemFontOfSize:[global pxTopt:size]]
#define BGFont(size) [UIFont systemFontOfSize:size]

#define iphone5 ((screenW==320)?1:0)
#define iphone6 ((screenW==375)?1:0)
#define iphoneX ((screenH==812)?1:0)
#define iphone6plus ((screenW==414)?1:0)
#define iphone5W 320.0
#define iphone6W 375.0
#define iphone6plusW 414.0

@interface global : NSObject

/**
 从像素px转换为ios的点阵pt
 */
+(CGFloat)pxTopt:(CGFloat)px;
/**
 UIColor 转UIImage
 */
+ (UIImage*) createImageWithColor: (UIColor*) color;
@end
