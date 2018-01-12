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
    dic[@"oid"] = @"118011215115932693";
    [ZP_OrderTool requestRequestRefund:dic success:^(id obj) {
        ZPLog(@"%@",obj);
        SelectModel * model = [SelectModel mj_objectWithKeyValues:obj];
        self.prizeDic = obj;
        [self initWithRequsetRefund:model];
        NSLog(@"%@",model);
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
}

- (void)initWithRequsetRefund:(SelectModel *)model {
    NSDictionary * dic = model.refundinfo;
    SelectModel2 * model2 = [SelectModel2 mj_objectWithKeyValues:dic];
    [_MainImageView sd_setImageWithURL:[NSURL URLWithString:model2.defaultimg] placeholderImage:[UIImage imageNamed:@""]];
    _TitleLabel.text = model2.productname;
    NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"symbol"];
    _CurrencyLabel.text = [NSString stringWithFormat:@"%@",str];
    _PriceLabel.text = [model2.productamount stringValue];
    
    
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
        seleView.dataArray = [SelectModel1 arrayWithArray:obj];
        NSLog(@"获取退换货");
        [seleView showInView:self.view];
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
}

// 上传按钮
- (IBAction)ShangchuanBut:(id)sender {
    [self uploadrefundimgs];
}

// 上传退换货相关图片
- (void)uploadrefundimgs {
    [ZP_OrderTool requestUploadrefundimgs:nil success:^(id obj) {
        
        ZPLog(@"%@",obj);
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
}

// 提交按钮
- (IBAction)TijiaoBut:(id)sender {
    [self addrefund];
}

// 添加退换货记录
- (void)addrefund {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    dic[@"rty"] = @"0"; // 这个是类型
    dic[@"oid"] = @"";
    dic[@"reason"] = @"不想要了"; // 这个是原因
    dic[@"reasondetail"] = @"不想要了"; // 这个是输入的文字
    dic[@"imgs"] = @"";// 这个是图片
    [ZP_OrderTool requestAddRefund:dic success:^(id obj) {
        ZPLog(@"%@",obj);
        
        
        
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
}


@end
