//
//  ZPHomeCell.m
//  merchants
//
//  Created by Summer on 2017/9/19.
//  Copyright © 2017年 PENG.ZHANG. All rights reserved.
//

#import "ZPHomeCell.h"
#import "PrefixHeader.pch"
@interface ZPHomeCell ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *describeLabel;
@property (nonatomic, strong) UILabel *originalPriceLabel;
@property (nonatomic, strong) UILabel *currentPriceLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIImageView * TrademarkImage;
@property (nonatomic, strong) UILabel * numberingLabel;

@end

@implementation ZPHomeCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        
        UILabel *describeLabel = [[UILabel alloc] init];
        describeLabel.font = ZP_titleFont;
        describeLabel.textColor = [UIColor grayColor];
        [self addSubview:describeLabel];
        
        UILabel *currentPriceLabel = [[UILabel alloc] init];
        currentPriceLabel.font = ZP_titleFont;
        currentPriceLabel.textColor = [UIColor redColor];
        [self addSubview:currentPriceLabel];
        
        UILabel *originalPriceLabel = [[UILabel alloc] init];
        originalPriceLabel.font = ZP_TrademarkFont;
        originalPriceLabel.textColor = [UIColor grayColor];
        [self addSubview:originalPriceLabel];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor grayColor];
        [self addSubview:line];
        
        UIImageView * TrademarkImage = [[UIImageView alloc]init];
        [self addSubview:TrademarkImage];
        
        UILabel * numberingLabel = [[UILabel alloc]init];
        numberingLabel.font = ZP_TrademarkFont;
        numberingLabel.textColor = [UIColor grayColor];
        [self addSubview:numberingLabel];
        
        self.iconView = iconView;
        self.describeLabel = describeLabel;
        self.currentPriceLabel = currentPriceLabel;
        self.originalPriceLabel = originalPriceLabel;
        self.line = line;
        self.TrademarkImage = TrademarkImage;
        self.numberingLabel = numberingLabel;
    }
    return self;
}

- (void)setIconName:(NSString *)iconName {
    _iconName = iconName;
    self.iconView.image = [UIImage imageNamed:iconName];
}

- (void)setDescribe:(NSString *)describe {
    _describe = describe;
    self.describeLabel.text = describe;
    self.describeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.describeLabel.numberOfLines = 0;
}

- (void)setCurrentPrice:(NSString *)currentPrice {
    _currentPrice = currentPrice;
    self.currentPriceLabel.text = currentPrice;
}

- (void)setOriginalPrice:(NSString *)originalPrice {
    _originalPrice = originalPrice;
    self.originalPriceLabel.text = originalPrice;
}

- (void)setTrademarkImageName:(NSString *)TrademarkImageName {
    
    _TrademarkImageName = TrademarkImageName;
    self.TrademarkImage.image = [UIImage imageNamed:TrademarkImageName];
}

- (void)setNumberingPrice:(NSString *)numberingPrice {
    _numberingPrice = numberingPrice;
    self.numberingLabel.text = numberingPrice;
}
- (void)layoutSubviews {
    [super layoutSubviews];
//    self.iconView.frame = CGRectMake(5, 5, self.frame.size.width - 10, self.frame.size.height - 60);
    self.describeLabel.frame = CGRectMake(5, CGRectGetWidth(self.frame)- 15, CGRectGetWidth(self.frame)-10, 40);
    self.currentPriceLabel.frame = CGRectMake(5, CGRectGetWidth(self.frame)+18, CGRectGetWidth(self.frame)-10, 20);
    self.originalPriceLabel.frame = CGRectMake(5, CGRectGetWidth(self.frame)+33, CGRectGetWidth(self.frame)-10, 20);;
    self.line.frame = CGRectMake(5, CGRectGetWidth(self.frame)+43, 53, 1);
    self.TrademarkImage.frame = CGRectMake(CGRectGetWidth(self.frame)- 60, CGRectGetWidth(self.frame)+ 25, 22*0.66, 20-5);
    self.numberingLabel.frame = CGRectMake(CGRectGetWidth(self.frame) - 40, CGRectGetWidth(self.frame)+ 23,CGRectGetWidth(self.frame)- 120, 20);
    
}


@end
