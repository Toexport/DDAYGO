//
//  Pop-upMenuView.m
//  DDAYGO
//
//  Created by Login on 2017/9/19.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "Pop-upMenuView.h"
#import "Pop-upPrefixHeader.pch"

#define WBNUMBER 3

@interface Pop_upMenuView ()

@property (nonatomic, strong)Pop_upTableViewDataSource * tableViewDataSource;
@property (nonatomic, strong)Pop_upTableViewDelegate * tableViewDelegate;

@end


@implementation Pop_upMenuView

- (instancetype) init {
    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame
                     menuWidth:(CGFloat)menuWidth
                         items:(NSArray *)items
                        action:(void(^)(NSInteger index))action {
    if (self = [super initWithFrame:frame]) {
        self.menuWidth = menuWidth;
        self.menuItem = items;
        self.action = [action copy];
        
        self.tableViewDataSource = [[Pop_upTableViewDataSource alloc]initWithItems:items cellClass:[Pop_upViewCell class] configureCellBlock:^(Pop_upViewCell *cell, Pop_upMenuModle *model) {
            Pop_upViewCell * tableViewCell = (Pop_upViewCell *)cell;
            tableViewCell.textLabel.text = model.title;
            tableViewCell.imageView.image = [UIImage imageNamed:model.image];
        }];
        self.tableViewDelegate = [[Pop_upTableViewDelegate alloc]initWithDidSelectRowAtIndexPath:^(NSInteger indexRow) {
            if (self.action) {
                self.action(indexRow);
            }
        }];
        self.tableView = [[UITableView alloc]initWithFrame:[self menuFrame] style:UITableViewStylePlain];
        self.tableView.dataSource = self.tableViewDataSource;
        self.tableView.delegate   = self.tableViewDelegate;
        self.tableView.layer.cornerRadius = 10.0f;
        self.tableView.layer.anchorPoint = CGPointMake(1.0, 0);
        self.tableView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
        self.tableView.rowHeight = 40;
        self.tableView.tableFooterView = [[UIView alloc] init]; // 隐藏多余Tableview的线条
        [self addSubview:self.tableView];
        if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    return self;
}

- (CGRect)menuFrame {
    
    CGFloat menuX = [UIScreen mainScreen].bounds.size.width - 110;
    CGFloat menuY = 55 - 15 * WBNUMBER;
    CGFloat width = self.menuWidth;
    CGFloat heigh = 30 * WBNUMBER;
    return (CGRect){menuX,menuY,width,heigh};
}

#pragma mark 绘制三角形
- (void)drawRect:(CGRect)rect

{
    // 设置背景色
    [[UIColor whiteColor] set];
    //拿到当前视图准备好的画板
    
    CGContextRef  context = UIGraphicsGetCurrentContext();
    
    //利用path进行绘制三角形
    
    //    CGContextBeginPath(context);//标记
    //    CGFloat location = [UIScreen mainScreen].bounds.size.width-55;
    //    CGContextMoveToPoint(context,
    //                         location -  10 - 10, 180);//设置起点
    //
    //    CGContextAddLineToPoint(context,
    //                            location - 2*10 - 10 ,  170);
    //
    //    CGContextAddLineToPoint(context,
    //                            location - 10 * 3 - 10, 180);
    
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    
    [[UIColor whiteColor] setFill];  //设置填充色
    
    [[UIColor whiteColor] setStroke]; //设置边框颜色
    
    CGContextDrawPath(context,
                      kCGPathFillStroke);//绘制路径path
    
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[Pop_upMenuSingleton shareManager]hideMenu];
}


@end
