//
//  TextdetailsViewCell.m
//  
//
//  Created by Login on 2017/9/18.
//
//

#import "TextdetailsViewCell.h"
#import "PrefixHeader.pch"
@implementation TextdetailsViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:@"textdetailsViewCell"];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI {
    
    UILabel * titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 8, 359, 25)];
    titlelabel.font = ZP_NavTextdetaFont;
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.backgroundColor = [UIColor grayColor];
    _titleLabel = titlelabel;
    [self addSubview:titlelabel];
    
    UILabel * preferentialLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 45, 84, 30)];
    preferentialLabel.font = ZP_NavTextFont;
    preferentialLabel.textAlignment = NSTextAlignmentCenter;
    preferentialLabel.backgroundColor = [UIColor blueColor];
    _preferentialLabel = preferentialLabel;
    [self addSubview:preferentialLabel];
    
    UILabel * priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 83, 84, 25)];
    priceLabel.font = ZP_titleFont;
    priceLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.backgroundColor = [UIColor yellowColor];
    _priceLabel = priceLabel;
    [self addSubview:priceLabel];
    
    UILabel * stockLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 120, 84, 20)];
    stockLabel.font = ZP_titleFont;
    stockLabel.textAlignment = NSTextAlignmentCenter;
    stockLabel.backgroundColor = [UIColor purpleColor];
    _stockLabel = stockLabel;
    [self addSubview:stockLabel];
    
    UILabel * salesLabel = [[UILabel alloc]initWithFrame:CGRectMake(118, 120, 84, 20)];
    salesLabel.font = ZP_titleFont;
    salesLabel.textAlignment = NSTextAlignmentCenter;
    salesLabel.backgroundColor = [UIColor orangeColor];
    _salesLabel = salesLabel;
    [self addSubview:salesLabel];
    
    UILabel * numberingLabel = [[UILabel alloc]initWithFrame:CGRectMake(229, 120, 132, 20)];
    numberingLabel.font = ZP_titleFont;
    numberingLabel.textAlignment = NSTextAlignmentCenter;
    numberingLabel.backgroundColor = [UIColor redColor];
    _numberingLabel = numberingLabel;
    [self addSubview:numberingLabel];
}

- (void)cellWithdic:(NSDictionary *)dic {
    _titleLabel.text = @"title";
    _preferentialLabel.text = dic[@"preferential"];
    _priceLabel.text = dic[@"price"];
    _stockLabel.text = dic[@"stock"];
    _salesLabel.text = dic[@"sales"];
    _numberingLabel.text = dic[@"numbering"];
}
@end
