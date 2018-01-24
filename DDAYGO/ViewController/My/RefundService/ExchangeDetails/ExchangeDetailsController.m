//
//  ExchangeDetailsController.m
//  DDAYGO
//
//  Created by Summer on 2018/1/10.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import "ExchangeDetailsController.h"
#import "LPDQuoteImagesView.h"
#import "ExchangeDetailsModel.h"
#import "PrefixHeader.pch"
#import "ZP_MyTool.h"
@interface ExchangeDetailsController ()<LPDQuoteImagesViewDelegate>

@property (nonatomic, strong)LPDQuoteImagesView *imageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ViewLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *View3LayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *View4LayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *View5LayoutConstraint;

@property (nonatomic, strong) ExchangeDetailsModel * model;
@property (nonatomic, strong) ExchangeDetailsModel * model1;

@end

@implementation ExchangeDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self ExchangeDetails];
    
}

// UI
- (void)initUI {
    int a = [self.leeLabel intValue];
    switch (a) {
        case 0:
            self.title = @"退款";
            break;
            
        case 1:
            self.title = @"退货退款";
            break;
            
        case 2:
            self.title = @"退货退款";

            break;
        default:
            break;
    }
    _imageView = [[LPDQuoteImagesView alloc] initWithFrame:CGRectMake(75, 25, RELATIVE_VALUE(220), RELATIVE_VALUE(80)) withCountPerRowInView:3 cellMargin:12];
    _imageView.collectionView.scrollEnabled = NO;
    _imageView.navcDelegate = self;
    _imageView.maxSelectedCount = 3;
    [self.view3 addSubview:_imageView];
}

//71) 获取退换货详情
- (void)ExchangeDetails {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"countrycode"];
    dic[@"countrycode"] = str;
    if (self.type == 666) {
        dic[@"oid"] = self.Oid;
        [ZP_MyTool requestGetrefundinfoOrder:dic success:^(id obj) {
            ZPLog(@"%@",obj);
            _model = [ExchangeDetailsModel mj_objectWithKeyValues:obj[@"refund"]];
            _model1 = [ExchangeDetailsModel mj_objectWithKeyValues:obj[@"product"][0]];
            [self ExchangeDeatils:_model];
            [self ExchangeDeatils1:_model1];
        } failure:^(NSError *error) {
            ZPLog(@"%@",error);
        }];
//        _ViewLayoutConstraint.constant = CGFLOAT_MIN;
//        _View3LayoutConstraint.constant = CGFLOAT_MIN;
//        _View4LayoutConstraint.constant = CGFLOAT_MIN;
//        _View5LayoutConstraint.constant = CGFLOAT_MIN;
//        _view3.height = YES;
//        _View5.height = YES;
//        _view4.height = YES;
//        _View4titleLabel.height = YES;
//        _CancelBut.height = YES;
//        self.RequestServiceBut.hidden = YES;
    }else {
        dic[@"refundid"] = self.Oid;
        [ZP_MyTool requestGetrefundinfo:dic success:^(id obj) {
            ZPLog(@"%@",obj);
            _model = [ExchangeDetailsModel mj_objectWithKeyValues:obj[@"refund"]];
            _model1 = [ExchangeDetailsModel mj_objectWithKeyValues:obj[@"product"][0]];
            [self ExchangeDeatils:_model];
            [self ExchangeDeatils1:_model1];
            
        } failure:^(NSError *error) {
            ZPLog(@"%@",error);
        }];
    }
    
}

- (void)ExchangeDeatils:(ExchangeDetailsModel *)model {
    self.OrderNumberLabel.text = [model.ordersnumber stringValue];
    self.RequestTypeLabel.text = [model.returntype stringValue];
    NSLog(@"%@",model.returntype);
    int a = [model.returntype intValue];
    NSLog(@"Stata = %D",a);
    switch (a) {
        case 0:
            self.RequestTypeLabel.text = @"退款";
            [self.CancelBut setTitle:@"取消退款"  forState:UIControlStateNormal];
            self.RequestServiceBut.hidden = YES;
            _View3LayoutConstraint.constant = CGFLOAT_MIN;
            self.ViewLayoutConstraint.constant = 50;
            self.view3.hidden = YES;
            break;
            
        case 1:
            self.RequestTypeLabel.text = @"退货";
            [self.CancelBut setTitle:@"取消退货"  forState:UIControlStateNormal];
            _View3LayoutConstraint.constant = CGFLOAT_MIN;
            self.ViewLayoutConstraint.constant = 50;
            self.view3.hidden = YES;
            self.RequestServiceBut.hidden = YES;
            break;
            
        case 2:
            self.RequestTypeLabel.text = @"换货";
            [self.CancelBut setTitle:@"取消换货"  forState:UIControlStateNormal];
            _View3LayoutConstraint.constant = CGFLOAT_MIN;
           self.ViewLayoutConstraint.constant = 50;
            self.view3.hidden = YES;
            self.RequestServiceBut.hidden = YES;
            break;
        default:
            break;
    }
    
    NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"symbol"];
    self.CurrencyLabel.text = [NSString stringWithFormat:@"%@",str];
    self.PriceLabel.text = [model.returnamount stringValue];
    self.RequestTimeLabel.text = model.createtime;
    self.RequestYuanyin.text = model.refundreason;
    self.NowStateLabel.text = model.statestr;
    NSLog(@"%@",model.statestr);
    int b = [model.returntype intValue];
    NSLog(@"Stata = %D",b);
    switch (b) {
        case 0:
            _View3LayoutConstraint.constant = CGFLOAT_MIN;
//            _View4LayoutConstraint.constant = CGFLOAT_MIN;
            _View5LayoutConstraint.constant = CGFLOAT_MIN;
//            self.ViewLayoutConstraint.constant = 50;
            self.view3.hidden = YES;
            self.view4.hidden = YES;
            self.View5.hidden = YES;
//            self.RequestServiceBut.hidden = YES;
            NSLog(@"Stata = %D",b);
            break;
            
        case 1:
            _View3LayoutConstraint.constant = CGFLOAT_MIN;
            _View4LayoutConstraint.constant = CGFLOAT_MIN;
             _View5LayoutConstraint.constant = CGFLOAT_MIN;
//            self.ViewLayoutConstraint.constant = 150;
            self.view3.hidden = YES;
            self.view4.hidden = YES;
            self.View5.hidden = YES;
            NSLog(@"Stata = %D",b);
            break;
        default:
            break;
    }
    self.LogisticsLabel.text = model.logisticname;
    [self.imageview1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImgAPI,model.logisticimg]] placeholderImage:[UIImage imageNamed:@""]];
}

- (void)ExchangeDeatils1:(ExchangeDetailsModel *)model1 {
    [self.Mainimageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImgAPI,model1.defaultimg]] placeholderImage:[UIImage imageNamed:@""]];
    self.TitleLabel.text = model1.productname;
    self.YanseLable.text = model1.colorname;
    self.ChimaLabel.text = model1.normname;
    self.NumberLabel.text = [model1.amount stringValue];
}

// 取消退款
- (IBAction)CancelButt:(id)sender {
//72) 更改退换货状态
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    dic[@"refundid"] = self.Oid;
    dic[@"type"] = @"cancel";
    dic[@"rtimgs"] = @"";
//    [self extracted:dic];
    [ZP_MyTool RequestRefundStatus:dic success:^(id obj) {
        if ([obj[@"result"]isEqualToString:@"ok"]) {
            [SVProgressHUD showSuccessWithStatus:@"取消成功"];
        }else
            if ([obj[@"result"]isEqualToString:@"sys_err"]) {
                [SVProgressHUD showInfoWithStatus:@"操作失败"];
            }
        ZPLog(@"%@",obj);
        [self.view4 removeFromSuperview];
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
    }];
}

@end
