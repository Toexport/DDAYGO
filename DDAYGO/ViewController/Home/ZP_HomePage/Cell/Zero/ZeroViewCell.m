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
#import "ZP_HomeTool.h"
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
    NSLog(@"go -- - - - ");
    [self.contentView addSubview:self.scrollView];
}


- (SDCycleScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ZP_Width, zeroHeight) delegate:self placeholderImage:[UIImage imageNamed:@""]];
//        [_scrollView addObject:[NSString stringWithFormat:@"%@%@",ImgAPI,[model.imgurl stringByReplacingOccurrencesOfString:@"~" withString:@""]]];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        _scrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    }
    return _scrollView;
}

- (void)setArr:(NSMutableArray *)arr {
    NSMutableArray *barr = [NSMutableArray array];
    for (ZP_ZeroModel *model in arr) {
        [barr addObject:[NSString stringWithFormat:@"%@%@",ImgAPI,model.advertimg]];
    }

    self.scrollView.imageURLStringsGroup = barr;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"---点击了第%ld张图片", (long)index);
    if (self.finishBlock) {
        self.finishBlock(@(index));
    }
}

@end
