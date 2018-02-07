//
//  FourthViewCell.m
//  DDAYGO
//
//  Created by Login on 2017/9/12.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "FourthViewCell.h"
#import "PrefixHeader.pch"
#import "CustomCell.h"
#import "ZP_HomeTool.h"
#import "ZP_FourthModel.h"
#import "SDCycleScrollView.h"
@interface FourthViewCell ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate> {
    
//    NSArray * CustomAArray;
}

@property (nonatomic, strong) UITableView * tableView;
//@property (nonatomic, strong)NSMutableArray * newsData;

@end

@implementation FourthViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:@"Fourthcell"];
    if (self) {
        [self initUI];
        [self CustomCell];
        [self Registration];
        self.userInteractionEnabled = YES;
    }
    return self;
}
//  注册
- (void)Registration {
    [self.tableView registerClass:[CustomCell class] forCellReuseIdentifier:@"customCell"];
    self.tableView.backgroundColor = ZP_WhiteColor;
    
}

- (void)initUI {
    [self.contentView addSubview:self.scrollView];
//    标题
    ZP_GeneralLabel * Titlelabel = [ZP_GeneralLabel initWithtextLabel:_Titlelabel.text textColor:ZP_textblack font:ZP_addBtnTextdetaFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    [self addSubview:Titlelabel];
    [Titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.equalTo(self).offset(7);
    }];
    _Titlelabel = Titlelabel;
    
//  分割线
    UIView * view0 = [UIView new];
    view0.backgroundColor = ZP_Graybackground;
    [self.contentView addSubview:view0];
    [view0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(29);
        make.left.equalTo(self).offset(0);
        make.width.mas_equalTo(ZP_Width);
        make.height.mas_equalTo(1);
    }];
    
    
    [self.contentView addSubview:self.scrollView];
//  图片1
//    UIImageView * imageView1 = [UIImageView new];
//    [self addSubview:imageView1];
//    [imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).offset(30);
//        make.left.equalTo(self).offset(0);
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(160);
//    }];
//    _imageView1 = imageView1;
    
}

- (SDCycleScrollView *)scrollView {
    if (!_scrollView) {
        CGFloat With ;
        if (ZP_Width == 320) {
            With = 95;
        }else
            if(ZP_Width == 375) {
                With = 95 * 1.1;
        }else {
            With = 95 * 1.2;
            }
        _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 30, With,  160) delegate:self placeholderImage:[UIImage imageNamed:@""]];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        _scrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//        _scrollView.userInteractionEnabled = YES;
        _scrollView.backgroundColor = [UIColor whiteColor];
//        UITapGestureRecognizer * tap = [UITapGestureRecognizer alloc]initWithTarget:self action:<#(nullable SEL)#>
        
    }
    return _scrollView;
}


- (void)inisWithArray:(NSArray *)arr
{

    NSMutableArray * array = [NSMutableArray array];
    for (ZP_ZeroModel * model in arr) {
        [array addObject:[NSString stringWithFormat:@"%@%@",ImgAPI,model.advertimg]];
    }
    self.scrollView.imageURLStringsGroup = array;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    ZPLog(@"---点击了第%ld张图片", (long)index);
    if (self.fourthBlock1) {
        self.fourthBlock1(@(index));
    }
}


- (void)setArrDara:(NSArray *)arrDara {
    _arrDara = arrDara;
    [self.tableView reloadData];
}

- (void)InformationWithDic:(NSDictionary *)dic {
    _Titlelabel.text = dic[@"title"];
//    _imageView1.image = [UIImage imageNamed:@"img_home_advertisemen"];
//    [self allData];
}


/*****************************************************/
//  定制Cell
- (void)CustomCell {
    self.tableView = [[UITableView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏tableview多余的线条
    self.tableView.backgroundColor = ZP_Graybackground;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;  // 设置tableview不能上下滚动
    [self.contentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_scrollView).offset(115);
        make.bottom.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.top.equalTo(self).offset(30);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrDara.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        CustomCell * cell = [tableView dequeueReusableCellWithIdentifier:@"customCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果、
         ZP_FourthModel * model = self.arrDara[indexPath.row];
        [cell cellWithdic:model];
        return cell;
    
   }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 80;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.FourthBlock) {
        ZP_FourthModel * model = self.arrDara[indexPath.row];
        self.FourthBlock([model.producid longLongValue]);
    }
        ZPLog(@"111");
}
@end
