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
@end

@implementation ExchangeDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self ExchangeDetails];
    
}

// UI
- (void)initUI {
    self.title = NSLocalizedString(@"退换货", nil);
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
        ExchangeDetailsModel * model = [ExchangeDetailsModel mj_objectWithKeyValues:obj[@"refund"]];
        NSLog(@"%@",model.ordersnumber);
        [self ExchangeDeatils:model];
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
    }];
}

- (void)ExchangeDeatils:(ExchangeDetailsModel *)model {
    self.OrderNumberLabel.text = [model.ordersnumber stringValue];
    self.RequestTypeLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:[model.returntype stringValue]];
    switch ([[[NSUserDefaults standardUserDefaults] objectForKey:[model.returntype stringValue]] integerValue]) {
        case 0:
            self.RequestTypeLabel.text = @"仅退款";
            break;
        case 1:
            self.RequestTypeLabel.text = @"退货/退款";
            break;
        case 2:
            self.RequestTypeLabel.text = @"换货";
            break;
        default:
            break;
    }
    NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"symbol"];
    self.CurrencyLabel.text = [NSString stringWithFormat:@"%@",str];
    self.PriceLabel.text = [model.ordersamount stringValue];
    self.RequestTimeLabel.text = model.createtime;
    self.RequestYuanyin.text = model.refundreason;
    self.NowStateLabel.text = [model.state stringValue];
    self.NowStateLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:[model.state stringValue]];
    switch ([[[NSUserDefaults standardUserDefaults] objectForKey:[model.state stringValue]] integerValue]) {
        case 0:
            self.NowStateLabel.text = @"待審核";
            break;
//        case 2:
//            self.NowStateLabel.text = @"買錯了";
//            break;
//        case 3:
//            self.NowStateLabel.text = @"發錯貨";
//            break;
//        case 4:
//            self.NowStateLabel.text = @"沒收到貨";
//            break;
//        case 5:
//            self.NowStateLabel.text = @"有瑕疵";
            break;
        default:
            break;
    }
    self.LogisticsLabel.text = model.logisticname;

    [self.Mainimageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.0.117:7000%@", model.defaultimg]] placeholderImage:[UIImage imageNamed:@""]];
    self.TitleLabel.text = model.productname;
    self.YanseLable.text = model.colorname;
    self.ChimaLabel.text = model.normname;
    self.NumberLabel.text = [model.amount stringValue];
}

//72) 更改退换货状态
- (void)RequestRefundStatus {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    dic[@"refundid"] = @"";
    dic[@"type"] = @"";
    dic[@"rtimgs"] = @"";
    [ZP_MyTool RequestRefundStatus:dic success:^(id obj) {
        ZPLog(@"%@",obj);
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
    }];
    
}

@end
