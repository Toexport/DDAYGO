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
@interface FourthViewCell ()<UITableViewDelegate,UITableViewDataSource> {
    
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
    
}

- (void)initUI {
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
    
//  图片1
    UIImageView * imageView1 = [UIImageView new];
    [self addSubview:imageView1];
    [imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(30);
        make.left.equalTo(self).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(160);
    }];
    _imageView1 = imageView1;
}

- (void)setArrDara:(NSArray *)arrDara {
    _arrDara = arrDara;
    [self.tableView reloadData];
}

- (void)InformationWithDic:(NSDictionary *)dic {
    _Titlelabel.text = dic[@"title"];
    _imageView1.image = [UIImage imageNamed:@"img_home_advertisemen"];
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
        make.left.equalTo(self).offset(100);
        make.bottom.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.top.equalTo(self).offset(30);
    }];
}
//// 数据
//- (void)allData {
////    NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"countrycode"];
//    NSDictionary * dict = @{@"count":@"5",@"countrycode":@"886"};
//    [ZP_HomeTool requestSellLikeHotCakes:dict success:^(id obj) {
//        NSArray * arr = obj;
//        ZPLog(@"%@",arr);
//        self. = [ZP_FourthModel arrayWithArray:arr];
//        [self.tableView reloadData];
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
//}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.arrDara.count;
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//
//    return self.newsData.count;
//}

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
        NSLog(@"111");
}
@end
