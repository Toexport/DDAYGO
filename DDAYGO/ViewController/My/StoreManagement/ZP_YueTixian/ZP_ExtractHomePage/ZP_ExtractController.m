//
//  ZP_ExtractController.m
//  DDAYGO
//
//  Created by Summer on 2017/12/5.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_ExtractController.h"
#import "ZP_ExtractCell.h"
#import "PrefixHeader.pch"
#import "ZP_MyTool.h"
@interface ZP_ExtractController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ZP_ExtractController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self AllData];
}

- (void)initUI {
    
    self.title = NSLocalizedString(@"提现记录", nil);
    [self.tableView registerNib:[UINib nibWithNibName:@"ZP_ExtractCell" bundle:nil] forCellReuseIdentifier:@"ZP_ExtractCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

// 数据
- (void)AllData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = @"ec77b922d25bb303f27f63d23de84f73";
    dic[@"sid"] = _supplierId;
    dic[@"page"] = @"2";
    [ZP_MyTool requesWithdrawalRecord:dic uccess:^(id obj) {
        ZPLog(@"%@",obj);
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
}

#pragma mark - tableview delegate

// 表头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *myView = [[UIView alloc]init];
    self.tableView.tableHeaderView = myView; // 表头跟着cell一起滚动
    [myView setBackgroundColor:ZP_Graybackground];
    
    ZP_GeneralLabel * DateTimeLabel = [ZP_GeneralLabel initWithtextLabel:_DateTimeLabel.text textColor:ZP_WhiteColor font:ZP_TooBarFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_titlecokeColor];
    DateTimeLabel.text = @"2017-12-02 13:38";
    [myView addSubview:DateTimeLabel];
    _DateTimeLabel = DateTimeLabel;
    [DateTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myView).offset(ZP_Width / 2 - 60);
        make.top.equalTo(myView).offset(10);
//        make.right.equalTo(myView).offset(ZP_Width- 50);
        make.width.mas_equalTo(120);
        
    }];
    return myView;
}

//  设置表头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 35;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZP_ExtractCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ZP_ExtractCell"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 350;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZPLog(@"%ld",(long)indexPath.item);
}
@end