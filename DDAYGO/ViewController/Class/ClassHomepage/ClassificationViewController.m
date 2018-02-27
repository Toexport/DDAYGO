//
//  ClassificationViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/7.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ClassificationViewController.h"
#import "LeftTableViewCell.h"
#import "RightTableViewCell.h"
#import "PrefixHeader.pch"
#import "CPerViewController.h"
#import "FourthViewCell.h"
#import "ZP_ClassViewTool.h"
#import "ZP_LeftModel.h"
#import "ZP_RightModel.h"
@interface ClassificationViewController ()<UITableViewDataSource,UITableViewDelegate> {

    NSInteger num;
}
@property (assign ,nonatomic) NSInteger leftSelectRow;
@property (assign ,nonatomic) NSInteger rightSelectRow;
@property (nonatomic ,strong) NSMutableArray * newsData;
@property (nonatomic, strong) NSMutableDictionary * rightData;
@property (strong ,nonatomic) NSString * titleStr;
@property (nonatomic, strong) NSNumber * sendCode;
@property (nonatomic, strong) NSNumber * code;


@end

@implementation ClassificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self allData];
}

- (void)initUI {
    self.title = MyLocal(@"Class");
    [self.navigationController.navigationBar setBarTintColor:ZP_NavigationCorlor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    self.rightData = [NSMutableDictionary dictionary];
    [self.leftTableView registerNib:[UINib nibWithNibName:@"LeftTableViewCell" bundle:nil] forCellReuseIdentifier:@"LeftTableViewCell"];
    [self.rightTableView registerNib:[UINib nibWithNibName:@"RightTableViewCell" bundle:nil] forCellReuseIdentifier:@"RightTableViewCell"];
    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

//  左边
- (void)selectLeftCell:(UIButton *)sender {
    self.leftSelectRow = sender.tag;
    [self.leftTableView reloadData];
    if (![self.rightData objectForKey:@(self.leftSelectRow)]) {
        [self getRightItemDataWithProducttypeid:self.leftSelectRow];
    } else {
        [self.rightTableView reloadData];
    }
}

// 右边
- (void)selectRightCell:(UIButton *)sender {
    self.rightSelectRow = sender.tag;
    [self.rightTableView reloadData];
}

// 数据（左边）
- (void)allData{
    NSNumber * sendCode;
    self.sendCode = sendCode;
    if ([self.code intValue] > 0) {
        sendCode = self.code;
    }else {
        sendCode = @886;
    }
    NSDictionary * dict = @{@"level":@"1",@"countrycode":sendCode};
    [ZP_ClassViewTool requClassIfication:dict success:^(id obj) {
        NSArray * arr = obj;
        ZPLog(@"%@",obj);
        self.newsData = [ZP_LeftModel arrayWithArray:arr];
        [self getRightItemDataWithProducttypeid:0];
        [self.leftTableView reloadData];
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
  }];
}

//  数据（右边）
- (void)getRightItemDataWithProducttypeid:(NSInteger)producttypeid {
    ZP_LeftModel *Molde =self.newsData[producttypeid];
    NSNumber * sendCode;
    self.sendCode = sendCode;
    if ([self.code intValue] > 0) {
        sendCode = self.code;
    }else {
        sendCode = @886;
    }
    NSDictionary * dictt = @{@"level":@"2",@"countrycode":sendCode,@"fatherid":[Molde.producttypeid stringValue]};
//     NSDictionary * dictt = @{@"level":@"2",@"language":@"zh-tw",@"fatherid": [NSString stringWithFormat:@"producttypeid+%ld",producttypeid]};
    ZPLog(@"%@",dictt);
    [ZP_ClassViewTool requClassIficationrj:dictt success:^(id obj) {
        ZPLog(@"%@",obj);
        NSArray * arr = obj;
        [self.rightData setObject:[ZP_RightModel arrayWithArray:arr] forKey:@(producttypeid)];
        [self.rightTableView reloadData];
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
    }];
}

#pragma mark ---tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return self.newsData.count;
    } else {
        NSArray * array = self.rightData[@(self.leftSelectRow)];
        return array.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.leftTableView) {
        LeftTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LeftTableViewCell"];
        [cell updateData:self.newsData[indexPath.row]];
        cell.contentBtn.tag = indexPath.row;
        [cell.contentBtn removeTarget:self action:@selector(selectLeftCell:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentBtn addTarget:self action:@selector(selectLeftCell:) forControlEvents:UIControlEventTouchUpInside];
        [cell updateSelectState:indexPath.row == self.leftSelectRow];
        if (indexPath.row == self.leftSelectRow) {
            _titleStr = cell.contentBtn.titleLabel.text;
        }
        return cell;
        
    } else {
        
        RightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RightTableViewCell" forIndexPath:indexPath];
        NSArray *array = self.rightData[@(self.leftSelectRow)];
        if (array.count > indexPath.row) {
            ZP_RightModel * model = array[indexPath.row];
            [cell updateData:model];
        }
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.rightTableView) {
        CPerViewController * CVPView = [[CPerViewController alloc]init];
        ZP_RightModel * model = self.rightData[@(self.leftSelectRow)][indexPath.row];
        CVPView.fatherId = model.producttypeid;
        CVPView.titleString = model.contentLabel;
        [self.rightTableView deselectRowAtIndexPath:indexPath animated:YES];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:CVPView animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    } else {
        
    }
}

@end
