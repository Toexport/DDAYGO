//
//  RefundServiceHeader.m
//  DDAYGO
//
//  Created by Summer on 2018/1/12.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import "RefundServiceHeader.h"
#import "PrefixHeader.pch"
#import "RefundServiceCell.h"
#import "RequestRefundController.h"
@interface RefundServiceHeader () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation RefundServiceHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
}

// UI
- (void)initUI {
    self.Tableview.delegate = self;
    self.Tableview.dataSource = self;
    [self.Tableview registerNib:[UINib nibWithNibName:@"RefundServiceCell" bundle:nil] forCellReuseIdentifier:@"RefundServiceCell"];
    self.Tableview.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏tableview多余的线条
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RefundServiceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RefundServiceCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果、
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {


}
@end
