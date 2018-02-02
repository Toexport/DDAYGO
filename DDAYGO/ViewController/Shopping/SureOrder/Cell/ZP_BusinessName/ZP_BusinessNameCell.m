//
//  ZP_BusinessNameCell.m
//  DDAYGO
//
//  Created by Summer on 2018/1/31.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import "ZP_BusinessNameCell.h"
#import "PrefixHeader.pch"
#import "ZP_InformationModel.h"
@implementation ZP_BusinessNameCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:@"ZP_BusinessNameCell"];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
//   商家图片
        UIImageView * merchantsImage = [UIImageView new];
        merchantsImage.image = [UIImage imageNamed:@"ic_order_store"];
        [self addSubview:merchantsImage];
        [merchantsImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(5);
            make.top.equalTo(self).offset(10);
        }];

//    商家名字
        UILabel * merchantsLabel = [UILabel new];
        merchantsLabel.textAlignment = NSTextAlignmentLeft;
        merchantsLabel.textColor = ZP_textblack;
        merchantsLabel.font = ZP_titleFont;
        [self addSubview:merchantsLabel];
        [merchantsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(30);
            make.top.equalTo(self).offset(10);
        }];
        self.merchantsLabel = merchantsLabel;
}

- (void)InformationModel:(ZP_InformationModel *)model {
    self.merchantsLabel.text = model.shopname;
}
@end
