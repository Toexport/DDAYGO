//
//  BuyTopView.m
//  DDAYGO
//
//  Created by Login on 2017/9/14.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "BuyTopView.h"
#import "BGCenterLineLabel.h"
#import "PrefixHeader.pch"
@interface BuyTopView()
@property (weak, nonatomic) IBOutlet UILabel * shopNameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * cycleScrollViewLayoutConstraint;
@property (weak, nonatomic) IBOutlet SDCycleScrollView * cycleScrollView;

@property (weak, nonatomic) IBOutlet UILabel * spjgLabel;    //商品价格
@property (weak, nonatomic) IBOutlet UILabel * ckLabel;      //库存
@property (weak, nonatomic) IBOutlet UILabel * yhLabel;      //优惠
@property (weak, nonatomic) IBOutlet UILabel * xlLabel;      //销量

@end

@implementation BuyTopView

-(void)awakeFromNib {
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.CurrencyLabel.text = DD_MonetarySymbol;
    //iphone X
    if ([[UIApplication sharedApplication] statusBarFrame].size.height>20) {
        //在这里写你想要的高度 其他地方不用动
        _cycleScrollViewLayoutConstraint.constant = 20;
    }
}

+ (instancetype)view {
    return [[[NSBundle mainBundle] loadNibNamed:@"BuyTopView" owner:nil options:nil] firstObject];
}

- (void)updateInfoWithModel:(ZP_GoodDetailsModel *)model {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.cycleScrollView.imageURLStringsGroup = @[model.defaultimg];
         self.shopNameLabel.text = model.productname;
        if ([model.peramount isEqualToString:@"(null)"]) {
            self.xlLabel.hidden = YES;
        }else {
            self.xlLabel.text = model.peramount;
        }
        if ([model.TrademarkLabel isEqualToString:@"(null)"]) {
            self.yhLabel.hidden = YES;
        }else {
            self.yhLabel.text = model.TrademarkLabel;
        }
        if ([model.productamount isEqualToString:@"(null)"]) {
            self.ckLabel.hidden = YES;
        }else {
            self.ckLabel.text = model.productamount;
        }
        if ([model.productprice isEqualToString:@"(null)"]) {
            self.spjgLabel.hidden = YES;
        }else {
            self.spjgLabel.text = model.productprice;
        }
    });
}

@end
