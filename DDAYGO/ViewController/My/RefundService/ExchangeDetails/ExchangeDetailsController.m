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

- (void)ExchangeDeatils:(ExchangeDetailsModel *)model {
    self.OrderNumberLabel.text = [model.ordersnumber stringValue];
    self.RequestTypeLabel.text = [model.returntype stringValue];
    NSLog(@"%@",model.returntype);
    int a = [model.returntype intValue];
    NSLog(@"Stata = %D",a);
    switch (a) {
        case 0:
            self.RequestTypeLabel.text = @"退款";
            break;
        case 1:
            self.RequestTypeLabel.text = @"退货退款";
            break;
        case 2:
            self.RequestTypeLabel.text = @"换货";
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
//    self.NowStateLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:[model.state stringValue]];
//    switch ([[[NSUserDefaults standardUserDefaults] objectForKey:[model.state stringValue]] integerValue]) {
//        case 0:
//
//            self.NowStateLabel.text = @"待審核";
//            self.RequestServiceBut.hidden = YES; // 隐藏客服按钮
//            [self.CancelBut addTarget:self action:@selector(CancelButt:) forControlEvents:UIControlEventEditingDidEnd];
//
//            break;
//        case 2:
//            self.NowStateLabel.text = @"買錯了";
//            self.CancelBut.hidden = YES;//隐藏取消
//            break;
//        case 3:
//            self.NowStateLabel.text = @"發錯貨";
//            self.CancelBut.hidden = YES;//隐藏取消
//            break;
//        case 4:
//            self.NowStateLabel.text = @"沒收到貨";
//            self.CancelBut.hidden = YES;//隐藏取消
//            break;
//        case 5:
//            self.NowStateLabel.text = @"有瑕疵";
//            self.CancelBut.hidden = YES;//隐藏取消
//            break;
//        default:
//            break;
//    }
    self.LogisticsLabel.text = model.logisticname;
   
}

- (void)ExchangeDeatils1:(ExchangeDetailsModel *)model1 {
    [self.Mainimageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImgAPI,model1.defaultimg]] placeholderImage:[UIImage imageNamed:@""]];
    self.TitleLabel.text = model1.productname;
    self.YanseLable.text = model1.colorname;
    self.ChimaLabel.text = model1.normname;
    self.NumberLabel.text = [model1.amount stringValue];
}

// 取消退款
- (void)CancelButt:(UIButton *)sender {
    [self RequestRefundStatus];
}


- (void)extracted:(NSMutableDictionary *)dic {
    [ZP_MyTool RequestRefundStatus:dic success:^(id obj) {
        ZPLog(@"%@",obj);
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
    }];
}

//72) 更改退换货状态
- (void)RequestRefundStatus {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    dic[@"refundid"] = self.Oid;
//    NSLog(@"%@",_model.state);
    dic[@"rtimgs"] = @"";
    [self extracted:dic];
    
}

@end
