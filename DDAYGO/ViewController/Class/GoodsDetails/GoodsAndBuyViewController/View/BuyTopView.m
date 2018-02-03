//
//  BuyTopView.m
//  DDAYGO
//
//  Created by Login on 2017/9/14.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "BuyTopView.h"
#import "BGCenterLineLabel.h"

@interface BuyTopView()
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleScrollView;
@property (weak, nonatomic) IBOutlet UILabel *spjgLabel;    //商品价格
@property (weak, nonatomic) IBOutlet UILabel *ckLabel;      //库存
@property (weak, nonatomic) IBOutlet UILabel *yhLabel;      //优惠
@property (weak, nonatomic) IBOutlet UILabel *xlLabel;      //销量

@end

@implementation BuyTopView

-(void)awakeFromNib{
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
}

+ (instancetype)view {
    return [[[NSBundle mainBundle] loadNibNamed:@"BuyTopView" owner:nil options:nil] firstObject];
}

- (void)updateInfoWithModel:(ZP_GoodDetailsModel *)model {
    dispatch_async(dispatch_get_main_queue(), ^{
//        if (model == NULL) {
//            self.shopNameLabel.text = @"";
//            self.xlLabel.text = @"";
//            self.yhLabel.text = @"";
//            self.ckLabel.text = @"";
//            self.spjgLabel.text = @"";
//        }else {
        self.cycleScrollView.imageURLStringsGroup = @[model.defaultimg];
        self.shopNameLabel.text = model.productname;
        self.xlLabel.text = model.peramount;
        self.yhLabel.text = model.TrademarkLabel;
        self.ckLabel.text = model.productamount;
        self.spjgLabel.text = model.productprice;
//        }
    });
}

@end
