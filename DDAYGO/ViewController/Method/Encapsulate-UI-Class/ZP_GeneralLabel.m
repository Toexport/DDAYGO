//
//  ZP_GeneralLabel.m
//  DDAYGO
//
//  Created by Summer on 2017/11/20.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_GeneralLabel.h"

@implementation ZP_GeneralLabel

+(instancetype)initWithtextLabel:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment bakcgroundColor:(UIColor *)bgColor {
    ZP_GeneralLabel * ZP_Generallbale = [[ZP_GeneralLabel alloc]init];
    ZP_Generallbale.text = text;
    ZP_Generallbale.textColor = textColor;
    ZP_Generallbale.font = font;
    ZP_Generallbale.textAlignment = textAlignment;
    ZP_Generallbale.backgroundColor = bgColor;
    return ZP_Generallbale;
}

@end
