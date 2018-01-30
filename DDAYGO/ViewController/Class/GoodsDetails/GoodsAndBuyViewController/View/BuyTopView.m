//
//  BuyTopView.m
//  testLogin
//
//  Created by huangzhibiao on 15/12/21.
//  Copyright © 2015年 haiwang. All rights reserved.
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
+ (instancetype)view
{
    return [[[NSBundle mainBundle] loadNibNamed:@"BuyTopView" owner:nil options:nil] firstObject];
}

- (void)updateInfoWithModel:(ZP_GoodDetailsModel *)model {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.cycleScrollView.imageURLStringsGroup = @[model.defaultimg];
        self.shopNameLabel.text = model.productname;
        self.xlLabel.text = model.peramount;
        self.yhLabel.text = [model.supplierid stringValue];
        self.ckLabel.text = model.productamount;
        self.spjgLabel.text = model.productprice;
    });
}

@end
