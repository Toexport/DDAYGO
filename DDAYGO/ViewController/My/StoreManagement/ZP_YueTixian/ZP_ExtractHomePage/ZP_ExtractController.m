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
@property (nonatomic, strong) NSArray * ExtractArr;
@end

@implementation ZP_ExtractController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self AllData];
}

- (void)initUI {
    self.title = NSLocalizedString(@"提現記錄", nil);
    [self.tableView registerNib:[UINib nibWithNibName:@"ZP_ExtractCell" bundle:nil] forCellReuseIdentifier:@"ZP_ExtractCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = ZP_DeepBlue;
/**** IOS 11 ****/
    if (@available(iOS 11.0, *)) {
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
    }
}

// 数据
- (void)AllData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;;
    dic[@"sid"] = _supplierId;
    dic[@"page"] = @"1";
    [ZP_MyTool requesWithdrawalRecord:dic uccess:^(id obj) {
        
    ZPLog(@"%@",obj);
        
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
//        [SVProgressHUD showInfoWithStatus:@"服務器鏈接失敗"];
    }];
}

#pragma mark - tableview delegate
//// 表头
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *myView = [[UIView alloc]init];
//    self.tableView.tableHeaderView = myView; // 表头跟着cell一起滚动
//    [myView setBackgroundColor:ZP_Graybackground];
//
//    ZP_GeneralLabel * DateTimeLabel = [ZP_GeneralLabel initWithtextLabel:_DateTimeLabel.text textColor:ZP_WhiteColor font:ZP_TooBarFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_titlecokeColor];
//    DateTimeLabel.text = @"2017-12-02 13:38";
//    [myView addSubview:DateTimeLabel];
//    _DateTimeLabel = DateTimeLabel;
//    [DateTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(myView).offset(ZP_Width / 2 - 60);
//        make.top.equalTo(myView).offset(10);
////        make.right.equalTo(myView).offset(ZP_Width- 50);
//        make.width.mas_equalTo(120);
//    }];
//    return myView;
//}
//
////  设置表头高度
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//
//    return 35;
//}


// 1.设置section的数目，即是你有多少个cell
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.ExtractArr.count; // in your case, there are 3 cells
}

//2.对于每个section返回一个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

//3.设置cell之间headerview的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.; // you can have your own choice, of course
}
//4.设置headerview的颜色
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZP_ExtractCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ZP_ExtractCell"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 410;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZPLog(@"%ld",(long)indexPath.item);
}
@end
