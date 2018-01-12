//
//  RequestRefundController.m
//  DDAYGO
//
//  Created by Summer on 2018/1/10.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import "RequestRefundController.h"
#import "PrefixHeader.pch"
#import "ZP_OrderTool.h"
#import "SelectModel.h"
#import "SelectView.h"
@interface RequestRefundController ()
@property (nonatomic, strong) NSMutableArray * DataArray;
@property (nonatomic, strong) NSMutableDictionary * prizeDic;
@end

@implementation RequestRefundController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

// UI
- (void)initUI {
    self.title = NSLocalizedString(@"申请退款", nil);
    [self requestRefundAllData];
}

// 获取退换货申请列表
- (void) requestRefundAllData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    dic[@"rty"] = @"0";
    dic[@"oid"] = @"";
    [ZP_OrderTool requestRequestRefund:dic success:^(id obj) {
        ZPLog(@"%@",obj);
        NSDictionary * dict = obj;
        SelectModel1 * model = [SelectModel1 mj_objectWithKeyValues:dict];
        self.prizeDic = obj;
        [self initWithRequsetRefund:model];
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
}

- (void)initWithRequsetRefund:(SelectModel1 *)model {
    [_MainImageView sd_setImageWithURL:[NSURL URLWithString:model.defaultimg] placeholderImage:[UIImage imageNamed:@""]];
    _TitleLabel.text = model.productname;
    
    
}

// 申请类型
- (IBAction)typebut:(id)sender {
    [self type];
}

// 类型选择
- (void)type {
    
}

// 退款原因按钮
- (IBAction)yuanyinBut:(UIButton *)sender {
    [self requsetRefundAllData];
   
}

// 获取退换货原因列表
- (void)requsetRefundAllData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    dic[@"countrycode"] = @"886";
    [ZP_OrderTool requestSelect:dic success:^(id obj) {
        ZPLog(@"%@",obj);
        SelectView * seleView = [[SelectView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        seleView.dataArray = [SelectModel arrayWithArray:obj];
        NSLog(@"提交订单");
        [seleView showInView:self.view];
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
}

@end
