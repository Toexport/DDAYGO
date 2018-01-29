//
//  CPerViewController.m
//  DDAYGO
//
//  Created by Summer on 2018/1/27.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import "CPerViewController.h"
#import "CPCollectionViewCell.h"
#import "DetailedController.h"
#import "PrefixHeader.pch"
#import "ZP_ClassViewTool.h"
#import "ClassificationViewController.h"
#import "ZP_ClassGoodsModel.h"
#import "CPCollectionViewController.h"
@interface CPerViewController ()<UIScrollViewDelegate>
{
    NSInteger  _indexTag;
    UIButton * button;
}
@property (nonatomic, strong) NSArray * titleArray;
@property (nonatomic, strong) UIScrollView * contentScrollView;
@property (nonatomic, strong) UIView * topView;
@property (nonatomic, strong) UIView * line;
@end

@implementation CPerViewController

- (UIScrollView *)contentScrollView{
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 37, ZP_Width, ZP_height - 37-NavBarHeight)];
        _contentScrollView.contentSize = CGSizeMake(ZP_Width * 4, 0);
        _contentScrollView.pagingEnabled  = YES;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.showsVerticalScrollIndicator = NO;
        _contentScrollView.delegate = self;
        [self.view addSubview:_contentScrollView];
    }
    return _contentScrollView;
}

-(UIView *)topView {
    
    if (!_topView) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, 37)];
        line.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:line];
        _topView = line;
    }
    return _topView;
}

-(UIView *)line {
    if (!_line) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 34, ZP_Width / 4, 1.4)];
        line.backgroundColor = [UIColor colorWithHexString:@"#e74940"];
        [self.topView addSubview:line];
        _line = line;
    }
    return _line;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = _titleString;
    [self.navigationController.navigationBar setBarTintColor:ZP_NavigationCorlor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    [self initView];
}

- (void)initView{
    _titleArray =  @[NSLocalizedString(@"Acquiescence", nil),NSLocalizedString(@"Sales Volume", nil),NSLocalizedString(@"Latest", nil),NSLocalizedString(@"Price", nil)];
    for (NSInteger i = 0; i<_titleArray.count; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*(ZP_Width/4), 0, ZP_Width/4, 34);
        [button setTitle:_titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = ZP_titleFont;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=i;
#warning 默认图片
        if (i == 3) {
//          默认图片
            [button setImage:[UIImage imageNamed:@"icon_shop_classification_01"] forState:UIControlStateNormal];
           
        }
        [self.topView addSubview:button];
    }
    self.line.x = 0;
    for (NSInteger j =0; j<_titleArray.count; j++) {
        CPCollectionViewController * vc = [[CPCollectionViewController alloc]init];
        vc.fatherId = self.fatherId;
        vc.nameStr = self.nameStr;
        vc.titleString = self.titleString;
        vc.keyword = self.keyword;
        vc.priceStrTag = self.priceStrTag;
        vc.type = j;
        [self addChildViewController:vc];
        [self.contentScrollView addSubview:vc.view];
        vc.view.frame = CGRectMake(j*ZP_Width, 0, ZP_Width, self.contentScrollView.height);
    }
    self.contentScrollView.contentOffset = CGPointMake(0, 0);
   // UIViewController * vcs = self.childViewControllers[0];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger tag = scrollView.contentOffset.x/ZP_Width;
    _indexTag = tag;
    self.contentScrollView.contentOffset = CGPointMake(tag*ZP_Width, 0);
    UIViewController * vcs = self.childViewControllers[tag];
    vcs.view.frame = CGRectMake(tag*ZP_Width, 0, ZP_Width, self.contentScrollView.frame.size.height);
    [UIView animateWithDuration:0.1 animations:^{
        self.line.x = (ZP_Width/4)*tag;
    }];
}

- (void)btnClick:(UIButton *)button {
    _indexTag = button.tag ;
    if (button.tag == 3) {
        if (button.selected) {
#warning 选中
            [button setImage:[UIImage imageNamed:@"icon_shop_classification_02"] forState:UIControlStateNormal];
            _priceStrTag = @"asc";
        } else {
#warning 取消选中
            [button setImage:[UIImage imageNamed:@"icon_shop_classification_03"] forState:UIControlStateNormal];
            _priceStrTag = @"desc";
        }
        button.selected = !button.selected;
        CPCollectionViewController * vcs = (CPCollectionViewController *)self.childViewControllers[button.tag];
        vcs.priceStrTag = _priceStrTag;
        [vcs allData];
    }else {
        self.contentScrollView.contentOffset = CGPointMake(button.tag*ZP_Width, 0);
        UIViewController * vcs = self.childViewControllers[button.tag];
        vcs.view.frame = CGRectMake(button.tag*ZP_Width, 0, ZP_Width, self.contentScrollView.frame.size.height);
        }
        [UIView animateWithDuration:0.1 animations:^{
          self.line.x = (ZP_Width/4)*button.tag;
    }];
}

@end
