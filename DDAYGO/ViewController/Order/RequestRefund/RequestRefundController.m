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
#import "LPDQuoteImagesView.h"
@interface RequestRefundController ()<LPDQuoteImagesViewDelegate>
@property (nonatomic, strong) NSMutableArray * DataArray;
@property (nonatomic, strong) NSMutableDictionary * prizeDic;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * view4LayoutConstraint;
@property (nonatomic, strong)LPDQuoteImagesView * imageView;
@end

@implementation RequestRefundController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    if (self.type == 555) {
        self.title = MyLocal(@"Exchange goods");
        _view4.hidden = NO;
    }else
    if (self.type == 666) {
        self.title = MyLocal(@"Exchange goods");
        _view4.hidden = NO;
    }else {
        self.title = MyLocal(@"refund", nil);
        _view4.hidden = YES;
    }
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(adjustStatusBar:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

// UI
- (void)initUI {
    [self requestRefundAllData];
    _imageView = [[LPDQuoteImagesView alloc] initWithFrame:CGRectMake(0, 25, RELATIVE_VALUE(220), RELATIVE_VALUE(80)) withCountPerRowInView:3 cellMargin:12];
    _imageView.collectionView.scrollEnabled = NO;
    _imageView.navcDelegate = self;
    _imageView.maxSelectedCount = 3;
    [self.view4 addSubview:_imageView];
}

- (void)initWithRequsetRefund:(SelectModel *)model {
    NSDictionary * dic = model.refundinfo;
    SelectModel2 * model2 = [SelectModel2 mj_objectWithKeyValues:dic];
    [_MainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImgAPI, model2.defaultimg]] placeholderImage:[UIImage imageNamed:@""]];
    _TitleLabel.text = model2.productname;
//    NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"symbol"];
//    _CurrencyLabel.text = [NSString stringWithFormat:@"%@",str];
    _CurrencyLabel.text = DD_MonetarySymbol;
    _PriceLabel.text = [model2.productamount stringValue];
}

// 66) 获取退换货原因列表
- (IBAction)yuanyinBut:(UIButton *)sender {
    self.WhyBut.userInteractionEnabled = NO;
    [self requsetRefundAllData];
   
}
// 66) 获取退换货原因列表
- (void)requsetRefundAllData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"countrycode"];
    dic[@"countrycode"] = str;
    [ZP_OrderTool requestSelect:dic success:^(id obj) {
        //*************************************Token被挤掉***************************************************//
        if ([obj[@"result"]isEqualToString:@"token_not_exist"]) {
            Token = nil;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"symbol"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"countrycode"];
            DD_ChangeStaus;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"headerImage"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"NameLabel"];
            ZPICUEToken = nil;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"icuetoken"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"state"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"headerImage"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"NameLabel"];
            [[SDImageCache sharedImageCache] clearDisk];
            [[NSUserDefaults standardUserDefaults]synchronize];
#pragma make -- 提示框
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:MyLocal(@"reminding") message:MyLocal(@"account exists") preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:MyLocal(@"cancel") style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                ZPLog(@"取消");
            }];
            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:MyLocal(@"ok") style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                [self.navigationController popToRootViewControllerAnimated:NO];
                //跳转
                if ([[[UIApplication sharedApplication] keyWindow].rootViewController isKindOfClass:[UITabBarController class]]) {
                    UITabBarController * tbvc = [[UIApplication sharedApplication] keyWindow].rootViewController;
                    [tbvc setSelectedIndex:0];
                }
            }];
            [alert addAction:defaultAction];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        //****************************************************************************************//
        self.WhyBut.userInteractionEnabled = YES;
        ZPLog(@"%@",obj);
        SelectView * seleView = [[SelectView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        seleView.dataArray = [SelectModel1 arrayWithArray:obj];
        seleView.ThirdBlock = ^(NSString * ContStr, NSNumber *code) {
            _showLabel.text = ContStr;
        };
        [seleView showInView:self.view];
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
}

// 67) 获取退换货申请页面商品信息
- (void) requestRefundAllData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    if (self.type == 555) {
        dic[@"oid"] = self.oid;
        dic[@"rty"] = @"1";
    }else
        if (self.type == 666) {
            dic[@"oid"] = self.oid;
            dic[@"rty"] = @"2";
        }else {
            dic[@"oid"] = self.oid;
            dic[@"rty"] = @"0";
        }
    [ZP_OrderTool requestRequestRefund:dic success:^(id obj) {
        
        //*************************************Token被挤掉***************************************************//
        if ([obj[@"result"]isEqualToString:@"token_not_exist"]) {
            Token = nil;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"symbol"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"countrycode"];
            DD_ChangeStaus;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"headerImage"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"NameLabel"];
            ZPICUEToken = nil;
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"icuetoken"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"state"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"headerImage"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"NameLabel"];
            [[SDImageCache sharedImageCache] clearDisk];
            [[NSUserDefaults standardUserDefaults]synchronize];
#pragma make -- 提示框
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:MyLocal(@"reminding") message:MyLocal(@"account exists") preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:MyLocal(@"cancel") style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                ZPLog(@"取消");
            }];
            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:MyLocal(@"ok") style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                [self.navigationController popToRootViewControllerAnimated:NO];
                //跳转
                if ([[[UIApplication sharedApplication] keyWindow].rootViewController isKindOfClass:[UITabBarController class]]) {
                    UITabBarController * tbvc = [[UIApplication sharedApplication] keyWindow].rootViewController;
                    [tbvc setSelectedIndex:0];
                }
            }];
            [alert addAction:defaultAction];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        //****************************************************************************************//
        
        ZPLog(@"%@",obj);
        SelectModel * model = [SelectModel mj_objectWithKeyValues:obj];
        self.prizeDic = obj;
        [self initWithRequsetRefund:model];
        NSLog(@"%@",model);
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
}
//69) 添加退换货记录
- (IBAction)TijiaoBut:(id)sender {
    
    if (_showLabel.text.length < 1) {
        [SVProgressHUD showInfoWithStatus:MyLocal(@"choose the reason")];
        return;
    }
    if (_MessageLabel.text.length < 1) {
        [SVProgressHUD showInfoWithStatus:MyLocal(@"enter the detailed reasons")];
        return;
    }
    [self addrefund];
}

//69) 添加退换货记录
- (void)addrefund {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
//    dic[@"rty"] = @"0"; // 这个是类型（默认为0）
    dic[@"oid"] = self.oid; // 订单号
    dic[@"reason"] = self.showLabel.text; // 这个是原因
    dic[@"reasondetail"] = _MessageLabel.text; // 这个是输入的文字
    if (self.type == 555) {
        dic[@"oid"] = self.oid;
        dic[@"rty"] = @"1";
        dic[@"imgs"] = @"";
    }else
        if (self.type == 666) {
            dic[@"oid"] = self.oid;
            dic[@"rty"] = @"2";
            dic[@"imgs"] = @"";
        }else {
            dic[@"oid"] = self.oid;
            dic[@"rty"] = @"0";
            dic[@"imgs"] = @"";// 这个是图片(退款不需要添加图片)
        }
    [ZP_OrderTool requestAddRefund:dic success:^(id obj) {
        ZPLog(@"%@",obj);
        if ([obj[@"result"]isEqualToString:@"ok"]) {
            [SVProgressHUD showSuccessWithStatus:MyLocal(@"Application is successful")];
            [self.navigationController popViewControllerAnimated:YES];
        }else
            //*************************************Token被挤掉***************************************************//
            if ([obj[@"result"]isEqualToString:@"token_not_exist"]) {
                Token = nil;
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"symbol"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"countrycode"];
            DD_ChangeStaus;
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"headerImage"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"NameLabel"];
                ZPICUEToken = nil;
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"icuetoken"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"state"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"headerImage"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"NameLabel"];
                [[SDImageCache sharedImageCache] clearDisk];
                [[NSUserDefaults standardUserDefaults]synchronize];
#pragma make -- 提示框
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:MyLocal(@"reminding") message:MyLocal(@"account exists") preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:MyLocal(@"cancel") style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                    ZPLog(@"取消");
                }];
                UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:MyLocal(@"ok") style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                    [self.navigationController popToRootViewControllerAnimated:NO];
                    //跳转
                    if ([[[UIApplication sharedApplication] keyWindow].rootViewController isKindOfClass:[UITabBarController class]]) {
                        UITabBarController * tbvc = [[UIApplication sharedApplication] keyWindow].rootViewController;
                        [tbvc setSelectedIndex:0];
                    }
                }];
                [alert addAction:defaultAction];
                [alert addAction:cancelAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
        //****************************************************************************************//
        
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
}


// 上传按钮
- (IBAction)ShangchuanBut:(id)sender {
    // 图片在这里
    NSArray * imageArray =  [NSArray arrayWithArray:_imageView.selectedPhotos];
    NSLog(@"%ld,%@",imageArray.count,imageArray);
    
}

//// 68) 上传退换货相关图片
//- (void)uploadrefundimgs {
//
//
//
//    [ZP_OrderTool requestUploadrefundimgs:nil success:^(id obj) {
//
//        ZPLog(@"%@",obj);
//    } failure:^(NSError * error) {
//        ZPLog(@"%@",error);
//    }];
//}

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
