//
//  NSString+Additions.m
//  HibyMusic
//
//  Created by sanj on 16/8/10.
//  Copyright © 2016年 hibymusic. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)
- (CGSize)sizeWithFont:(UIFont *)font forWidth:(CGFloat)width {
    NSParameterAssert(font);
    if (width > 0) {
        CGRect rect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil];
        return CGSizeMake(ceil(rect.size.width), ceil(rect.size.height));
    } else {
        CGSize size = [self sizeWithAttributes:@{NSFontAttributeName: font}];
        return CGSizeMake(ceil(size.width), ceil(size.height));
    }
}

- (NSString *)encodeToPercentEscapeString
{
    NSString *outputStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)self,NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8));
    
    return outputStr;
}

- (NSString *)creatPirceString {
    
    NSMutableString *string = [[NSMutableString alloc] initWithString:self];
    NSInteger index = 1;
    
    while (self.length > index) {
        if (index%3 == 0) {
            [string insertString:@"," atIndex:self.length-index];
        }
        index ++;
    }
    
    return string;
}
@end
