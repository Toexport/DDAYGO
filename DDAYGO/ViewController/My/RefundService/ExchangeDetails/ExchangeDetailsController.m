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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(adjustStatusBar:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

// UI
- (void)initUI {
    int a = [self.leeLabel intValue];
    switch (a) {
        case 0:
            self.title = MyLocal(@"refund");
            //            NSLog(@"%d",a);
            break;
        case 1:
            self.title = MyLocal(@"Returnrefund");
            //            NSLog(@"%d",a);
            break;
            
        case 2:
            self.title = MyLocal(@"Returnrefund");
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
        self.title = MyLocal(@"Returnrefund");
        dic[@"oid"] = self.Oid;
        [ZP_MyTool requestGetrefundinfoOrder:dic success:^(id obj) {
            //*************************************Token被挤掉***************************************************//
            if ([obj[@"result"]isEqualToString:@"token_not_exist"]) {
                //        清除所有的数据
                Token = nil;
                DDAYGO_REMOVE_TOKEN; DDAYGO_REMOVE_SYMBOL; DDAYGO_REMOVE_COUNTRYCODE; DDAYGO_REMOVE_ICUETOKEN; DDAYGO_REMOVE_STATE; DDAYGO_REMOVE_HEADERIMAGE; DDAYGO_REMOVE_NAMELABEL; DD_ChangeStaus;
                ZPICUEToken = nil;
                [[SDImageCache sharedImageCache] clearDisk];
#pragma make -- 提示框
                [self logouttt];
            }
            //****************************************************************************************//
            
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
            self.title = MyLocal(@"Returnrefund");
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
            //        self.title = @"退货退款";
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
            self.RequestTypeLabel.text = MyLocal(@"refund");
            [self.CancelBut setTitle:MyLocal(@"Cancel refund")  forState:UIControlStateNormal];
            self.RequestServiceBut.hidden = YES;
            _View3LayoutConstraint.constant = CGFLOAT_MIN;
            self.ViewLayoutConstraint.constant = 50;
            self.view3.hidden = YES;
            //            NSLog(@"Stata = %D",a);
            break;
            
        case 1:
            self.RequestTypeLabel.text = MyLocal(@"Return");
            [self.CancelBut setTitle:MyLocal(@"Cancel/refund")  forState:UIControlStateNormal];
            _View3LayoutConstraint.constant = CGFLOAT_MIN;
            self.ViewLayoutConstraint.constant = 50;
            self.view3.hidden = YES;
            self.RequestServiceBut.hidden = YES;
            //            NSLog(@"Stata = %D",a);
            break;
            
        case 2:
            self.RequestTypeLabel.text = MyLocal(@"Exchange goods");
            [self.CancelBut setTitle:MyLocal(@"cancel a replacement")  forState:UIControlStateNormal];
            _View3LayoutConstraint.constant = CGFLOAT_MIN;
            self.ViewLayoutConstraint.constant = 50;
            self.view3.hidden = YES;
            self.RequestServiceBut.hidden = YES;
            //            NSLog(@"Stata = %D",a);
            break;
        default:
            break;
    }
    
    //    NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"symbol"];
    //    self.CurrencyLabel.text = [NSString stringWithFormat:@"%@",str];
    self.CurrencyLabel.text = DD_MonetarySymbol;
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
    [self.imageview1 setContentScaleFactor:[[UIScreen mainScreen] scale]];
    self.imageview1.contentMode =  UIViewContentModeScaleAspectFill;
    self.imageview1.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.imageview1.clipsToBounds  = YES;
}

- (void)ExchangeDeatils1:(ExchangeDetailsModel *)model1 {
    [self.Mainimageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImgAPI,model1.defaultimg]] placeholderImage:[UIImage imageNamed:@""]];
    [self.Mainimageview setContentScaleFactor:[[UIScreen mainScreen] scale]];
    self.Mainimageview.contentMode =  UIViewContentModeScaleAspectFill;
    self.Mainimageview.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.Mainimageview.clipsToBounds  = YES;
    self.TitleLabel.text = model1.productname;
    if (model1.colorname.length < 1) {
        self.YanseLable.hidden = YES;
        self.YansesLabel.hidden = YES;
    }else {
        self.YanseLable.text = model1.colorname;
        self.YansesLabel.text = MyLocal(@"color");
    }
    if (model1.normname.length < 1) {
        self.ChimaLabel.hidden = YES;
        self.ChimaaLabel.hidden = YES;
    }else {
        self.ChimaLabel.text = model1.normname;
        self.ChimaaLabel.text = MyLocal(@"size");
    }
    self.NumberLabel.text = [model1.amount stringValue];
}

// 取消退款
- (IBAction)CancelButt:(id)sender {
    if (self.type == 666) {
        //72) 更改退换货状态
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        dic[@"token"] = Token;
        dic[@"refundid"] = self.model.refundid;
        dic[@"type"] = @"cancel";
        dic[@"rtimgs"] = @"";
        [ZP_MyTool RequestRefundStatus:dic success:^(id obj) {
            if ([obj[@"result"]isEqualToString:@"ok"]) {
                [self ExchangeDetails];
                [SVProgressHUD showSuccessWithStatus:MyLocal(@"Cancel success")];
            }else
                if ([obj[@"result"]isEqualToString:@"sys_err"]) {
                    [SVProgressHUD showInfoWithStatus:MyLocal(@"Operation failure")];
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
                    [SVProgressHUD showSuccessWithStatus:MyLocal(@"Cancel success")];
                }else
                    if ([obj[@"result"]isEqualToString:@"sys_err"]) {
                        [SVProgressHUD showInfoWithStatus:MyLocal(@"Operation failure")];
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
                    [SVProgressHUD showSuccessWithStatus:MyLocal(@"Cancel success")];
                }else
                    if ([obj[@"result"]isEqualToString:@"sys_err"]) {
                        [SVProgressHUD showInfoWithStatus:MyLocal(@"Operation failure")];
                    }
                ZPLog(@"%@",obj);
                [self.view4 removeFromSuperview];
            } failure:^(NSError *error) {
                ZPLog(@"%@",error);
            }];
        }
}

// 热点被接入，子类重写
- (void)adjustStatusBar:(NSNotification *)notification {
    NSValue * rectValue = [notification.userInfo objectForKey:UIApplicationStatusBarFrameUserInfoKey];
    CGRect statusRect = [rectValue CGRectValue];
    CGFloat height = statusRect.size.height;
    if (height > 20) {
        appD.window.frame = CGRectMake(0, 0, ZP_Width, ZP_height);
    }else{
        appD.window.frame = CGRectMake(0, 0, ZP_Width, ZP_height);
    }
}
@end
