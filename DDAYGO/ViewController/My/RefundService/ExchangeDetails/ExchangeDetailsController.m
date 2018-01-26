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
//            NSLog(@"%d",a);
            break;
            
        case 1:
            self.title = @"退货退款";
//            NSLog(@"%d",a);
            break;
            
        case 2:
            self.title = @"退货退款";
//            NSLog(@"%d",a);
            break;
        default:
            break;
    }
    _imageView = [[LPDQuoteImagesView alloc] initWithFrame:CGRectMake(75, 25, RELATIVE_VALUE(220), RELATIVE_VALUE(80)) withCountPerRowInView:3 cellMargin:12];
    _imageView.collectionView.scrollEnabled = NO;
    _imageView.navcDelegate = self;
    _imageView.maxSelectedCount = 3;
    [self.view3 addSubview:_imageView];
//    _imageview1.userInteractionEnabled = YES;// 打开用户交互
//    UIGestureRecognizer * singleTap = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
//    //为图片添加手势
//    [_imageview1 addGestureRecognizer:singleTap];
//    //显示
//    [self.view addSubview:_imageview1];
}

//71) 获取退换货详情
- (void)ExchangeDetails {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"countrycode"];
    dic[@"countrycode"] = str;
    if (self.type == 666) {
        self.title = self.STrtltle;
        dic[@"oid"] = self.Oid;
        [ZP_MyTool requestGetrefundinfoOrder:dic success:^(id obj) {
//            ZPLog(@"%@",obj);
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
    }else
        if (self.type == 777) {
            self.title = self.STrtltle;
            dic[@"oid"] = self.Oid;
            [ZP_MyTool requestGetrefundinfoOrder:dic success:^(id obj) {
                //            ZPLog(@"%@",obj);
                _model = [ExchangeDetailsModel mj_objectWithKeyValues:obj[@"refund"]];
                _model1 = [ExchangeDetailsModel mj_objectWithKeyValues:obj[@"product"][0]];
                [self ExchangeDeatils:_model];
                [self ExchangeDeatils1:_model1];
            } failure:^(NSError *error) {
                ZPLog(@"%@",error);
            }];
    }else{
        dic[@"refundid"] = self.Oid;
        [ZP_MyTool requestGetrefundinfo:dic success:^(id obj) {
//            ZPLog(@"%@",obj);
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
//    NSLog(@"%@",model.returntype);
    int a = [model.returntype intValue];
//    NSLog(@"Stata = %D",a);
//     按钮文字及属性
    switch (a) {
        case 0:
            self.RequestTypeLabel.text = @"退款";
            [self.CancelBut setTitle:@"取消退款"  forState:UIControlStateNormal];
            self.RequestServiceBut.hidden = YES;
            _View3LayoutConstraint.constant = CGFLOAT_MIN;
            self.ViewLayoutConstraint.constant = 50;
            self.view3.hidden = YES;
//            NSLog(@"Stata = %D",a);
            break;
            
        case 1:
            self.RequestTypeLabel.text = @"退货";
            [self.CancelBut setTitle:@"取消退货"  forState:UIControlStateNormal];
            _View3LayoutConstraint.constant = CGFLOAT_MIN;
            self.ViewLayoutConstraint.constant = 50;
            self.view3.hidden = YES;
            self.RequestServiceBut.hidden = YES;
//            NSLog(@"Stata = %D",a);
            break;
            
        case 2:
            self.RequestTypeLabel.text = @"换货";
            [self.CancelBut setTitle:@"取消换货"  forState:UIControlStateNormal];
            _View3LayoutConstraint.constant = CGFLOAT_MIN;
           self.ViewLayoutConstraint.constant = 50;
            self.view3.hidden = YES;
            self.RequestServiceBut.hidden = YES;
//            NSLog(@"Stata = %D",a);
            break;
        default:
            break;
    }
    
    NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"symbol"];
    self.CurrencyLabel.text = [NSString stringWithFormat:@"%@",str];
    self.PriceLabel.text = [model.ordersamount stringValue];
    self.RequestTimeLabel.text = model.createtime;
    self.RequestYuanyin.text = model.refundreason;
    self.NowStateLabel.text = model.statestr;
//    NSLog(@"%@",model.statestr);
    int b = [model.state intValue];
    NSLog(@"Stata11 = %D",b);
    switch (b) {
//         根据返回的数字来识别隐藏是否显示View
        case 1:
            _View3LayoutConstraint.constant = CGFLOAT_MIN;
             _View5LayoutConstraint.constant = CGFLOAT_MIN;
            self.ViewLayoutConstraint.constant = 50;
            self.view3.hidden = YES;
            self.View5.hidden = YES;
            NSLog(@"Stata = %D",b);
            break;
            
        case 4:
            _View3LayoutConstraint.constant = CGFLOAT_MIN;
            _View5LayoutConstraint.constant = CGFLOAT_MIN;
            self.view3.hidden = YES;
            self.view4.hidden = YES;
            self.View5.hidden = YES;
            NSLog(@"Stata = %D",b);
            break;
        case 5:
            _View3LayoutConstraint.constant = CGFLOAT_MIN;
            self.ViewLayoutConstraint.constant = 150;
            self.view3.hidden = YES;
            self.view4.hidden = YES;
            NSLog(@"Stata = %D",b);
            break;
            
        case 10:
            _View3LayoutConstraint.constant = CGFLOAT_MIN;
            _View5LayoutConstraint.constant = CGFLOAT_MIN;
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
    if (model1.colorname.length < 1) {
        self.YanseLable.hidden = YES;
        self.YansesLabel.hidden = YES;
    }else {
        self.YanseLable.text = model1.colorname;
        self.YansesLabel.text = @"颜色";
    }
    if (model1.normname.length < 1) {
        self.ChimaLabel.hidden = YES;
        self.ChimaaLabel.hidden = YES;
    }else {
        self.ChimaLabel.text = model1.normname;
        self.ChimaaLabel.text = @"尺码";
    }
    self.NumberLabel.text = [model1.amount stringValue];
}

//(lldb) po model.colorname.length
//<nil>
//
//(lldb) po model.colorname
//<object returned empty description>
// 取消退款
- (IBAction)CancelButt:(id)sender {
    if (self.type == 666) {
        //72) 更改退换货状态
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        dic[@"token"] = Token;
        dic[@"refundid"] = self.model.refundid;
        dic[@"type"] = @"cancel";
        dic[@"rtimgs"] = @"";
        //    [self extracted:dic];
        [ZP_MyTool RequestRefundStatus:dic success:^(id obj) {
            if ([obj[@"result"]isEqualToString:@"ok"]) {
                [self ExchangeDetails];
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
    }else
        if (self.type == 777) {
            //72) 更改退换货状态
            NSMutableDictionary * dic = [NSMutableDictionary dictionary];
            dic[@"token"] = Token;
            dic[@"refundid"] = self.model.refundid;
            dic[@"type"] = @"cancel";
            dic[@"rtimgs"] = @"";
            //    [self extracted:dic];
            [ZP_MyTool RequestRefundStatus:dic success:^(id obj) {
                if ([obj[@"result"]isEqualToString:@"ok"]) {
                    [self ExchangeDetails];
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
        }else {
//72) 更改退换货状态
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    dic[@"refundid"] = self.Oid;
    dic[@"type"] = @"cancel";
    dic[@"rtimgs"] = @"";
    [ZP_MyTool RequestRefundStatus:dic success:^(id obj) {
        if ([obj[@"result"]isEqualToString:@"ok"]) {
            [self ExchangeDetails];
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
}

@end
