//
//  SatisfactionSurveyController.m
//  DDAYGO
//
//  Created by Summer on 2018/1/19.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import "SatisfactionSurveyController.h"
#import "SatisfactionSurveyCell.h"
#import "SatisfactionSurveyModel.h"

#import "PrefixHeader.pch"
#import "ZP_ClassViewTool.h"
@interface SatisfactionSurveyController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray * NewsData;
@property (nonatomic, strong) NoDataView * NoDataView;
@end

@implementation SatisfactionSurveyController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self Getshopreviews];
    [NoDataView initWithSuperView:self.view Content:nil FinishBlock:^(id response) {
        self.NoDataView = response;
        [self.tableView reloadData];
    }];
}
// UI
- (void)initUI {
    self.title = NSLocalizedString(@"Satisfaction survey", nil);
    [self.tableView registerNib:[UINib nibWithNibName:@"SatisfactionSurveyCell" bundle:nil] forCellReuseIdentifier:@"SatisfactionSurveyCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏tableview多余的线条
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

// 76) 获取店铺评论
- (void)Getshopreviews {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"sid"] = self.sid;
    dic[@"page"] = @"1";
    dic[@"pagesize"] = @"3";
    [ZP_ClassViewTool requestGetshopreviews:dic success:^(id obj) {
        NSDictionary * dict = obj;
        NSArray * arr = dict[@"datalist"];
        _NewsData = [SatisfactionSurveyModel SatisfactionSurvey:arr];
        ZPLog(@"%@",obj);
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
        ZPLog(@"%@",error);
    }];
}

#pragma mark --- tableviewdelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.NewsData.count > 0) {
        self.tableView.hidden = NO;
        self.NoDataView.hidden = YES;
        return self.NewsData.count;
    }else {
        if (self.NoDataView) {
            self.tableView.hidden = YES;
            self.NoDataView.hidden = NO;
        }
    return 0;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SatisfactionSurveyCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SatisfactionSurveyCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果、
    SatisfactionSurveyModel * model = _NewsData[indexPath.section];
    [cell SatisfactionSurvey:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

@end
