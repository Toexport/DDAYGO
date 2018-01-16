//
//  ZeroViewCell.m
//  DDAYGO
//
//  Created by Login on 2017/9/13.
//  Copyright © 2017年 Summer. All rights reserved.
//

//
//  ZeroViewCell.m
//  DDAYGO
//
//  Created by Login on 2017/9/13.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZeroViewCell.h"
#import "SDCycleScrollView.h"
#import "PrefixHeader.pch"

@interface ZeroViewCell () <SDCycleScrollViewDelegate>

@end

@implementation ZeroViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:@"ceaa"];
    if (self) {
    [self initUI];
    }
    return self;
}
- (void)initUI {
//    NSArray * imagesURLStrings = @[
//                                   @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
//                                   @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
//                                   @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
//                                   ];
    
//    768 × 320

    SDCycleScrollView *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ZP_Width, zeroHeight) delegate:self placeholderImage:[UIImage imageNamed:@"ddg_propaganda.png"]];
    
    scrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    scrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//    scrollView.imageURLStringsGroup = imagesURLStrings;
    [self.contentView addSubview:scrollView];
//    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.and.left.mas_equalTo(-1);
//        make.right.mas_equalTo(0);
//        make.height.mas_equalTo(zeroHeight);
//    }];

//    UIView * SegmentationView = [UIView new];
//    [self.contentView addSubview:SegmentationView];
//    SegmentationView.backgroundColor = ZP_DeepBlue;
//    [SegmentationView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).offset(ZP_Width / 2);
//        make.left.equalTo(self).offset(ZP_Width);
//        make.width.mas_offset(ZP_Width);
//    }];
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"---点击了第%ld张图片", (long)index);
    if (self.finishBlock) {
        self.finishBlock(@(index));
    }
}

@end
