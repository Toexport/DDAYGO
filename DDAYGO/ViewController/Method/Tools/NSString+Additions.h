//
//  NSString+Additions.h
//  HibyMusic
//
//  Created by sanj on 16/8/10.
//  Copyright © 2016年 hibymusic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Additions)

/**
 *  计算字符串显示大小，结果取整以方便设计 UIView 的 frame
 *  @param font  字体，不能为空
 *  @param width 最大显示宽度，为 0 时不限制宽度
 *  @return 返回的大小会取整，如实际高度是 115.15 时，会返回 116.0
 */
- (CGSize)sizeWithFont:(UIFont *)font forWidth:(CGFloat)width;
- (NSString *)encodeToPercentEscapeString;
- (NSString *)creatPirceString;
@end
