//
//  ZP_MyTool.m
//  DDAYGO
//
//  Created by Summer on 2017/10/30.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_MyTool.h"
#import "PrefixHeader.pch"
#import "ZP_NetorkingTools.h"
#import "NSString+Additions.h"
@implementation ZP_MyTool
// 个人资料
+ (void)requestSetHomePage:(NSDictionary *)SetHomePage success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@accountinfo?token=%@&nonce=%@",URLAPI,SetHomePage[@"token"],SetHomePage[@"nonce"]] parameters:nil success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
// 修改资料(暂时只有昵称，性别)
+ (void)requesModifydata:(NSDictionary *)Modifydata uccess:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString * nickname = Modifydata[@"nickname"];
    NSString * address = Modifydata[@"address"];
    NSString * sex = Modifydata[@"sex"];
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@updateaccountinfo?nickname=%@&realname=%@&sex=%@&birth=%@&phone=%@&address=%@&token=%@",URLAPI,nickname.encodeToPercentEscapeString,Modifydata[@"realname"],sex.encodeToPercentEscapeString ,Modifydata[@"birth"],Modifydata[@"phone"],address.encodeToPercentEscapeString,Modifydata[@"token"]] parameters:nil success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//  新增地址
+ (void)requesnewAaddress:(NSDictionary *)newAaddress success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString * str = [NSString stringWithFormat:@"%@addupdatereceipt?adsid=%@&name=%@&phone=%@&cell=%@&email=%@&zipcode=%@&address=%@&isdefault=%@&token=%@",URLAPI,newAaddress[@"adsid"],newAaddress[@"name"],newAaddress[@"phone"],newAaddress[@"cell"],newAaddress[@"email"],newAaddress[@"zipcode"],newAaddress[@"address"],newAaddress[@"isdefault"],newAaddress[@"token"]];
    NSString * urlString = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ZP_NetorkingTools POST:urlString parameters:nil success:^(NSDictionary *responseObject) {
        
        success(responseObject);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//  收货地址
+ (void)requesAddress:(NSDictionary *)Address success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@%@",URLAPI,RequestAddress] parameters:Address success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
        //        ZPLog(@"%@",error);
    }];
}
//  设定默认地址
+ (void) requestDefaultAddress:(NSDictionary *)DefaultAddress success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@setadressdefault?adsid=%@&token=%@",URLAPI,DefaultAddress[@"adsid"],DefaultAddress[@"token"]] parameters:nil success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 删除地址
+ (void)requesDeleteAddress:(NSDictionary *)DeleteAddress success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@deleteadress?adsid=%@&token=%@",URLAPI,DeleteAddress[@"adsid"],DeleteAddress[@"token"]] parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//  绑定ICUE
+ (void)requestBindingICUE:(NSDictionary *)Binding success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@updateicueaccount?acc=%@&pwd=%@&token=%@",URLAPI,Binding[@"icueaccount"],Binding[@"pwd"],Binding[@"token"]] parameters:nil success:^(NSDictionary *responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//  绑定介绍人
+ (void)requesIntroduce:(NSDictionary *)Introduce success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString * str = [NSString stringWithFormat:@"%@checkintroducer?acc=%@&token=%@",URLAPI,Introduce[@"acc"],Introduce[@"token"]];
    NSString * urlString = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ZP_NetorkingTools POST:urlString parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
// 获取用户收藏商品列表
+ (void)requestgetcollections:(NSDictionary *)Binding success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@getcollections?screen=%@&token=%@",URLAPI,Binding[@"screen"],Binding[@"token"]] parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
// 获取浏览记录
+ (void)requtsFootprint:(NSDictionary *)Footprint success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@gethistorylist?nonce=%@&token=%@",URLAPI,Footprint[@"nonce"],Footprint[@"token"]] parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}
//  删除浏览记录
+ (void)requtsDeleFootprint:(NSDictionary *)Footprint success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@deletehistory?historyid=%@&token=%@",URLAPI,Footprint[@"historyid"],Footprint[@"token"]] parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//  获取生成二维码所需要的商家ID
+ (void)requesQrCode:(NSDictionary *)QrCoed success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@getqrcode?token=%@&nonce=%@",URLAPI,QrCoed[@"token"],QrCoed[@"nonce"]] parameters:nil success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 用户扫码后请求付款链接
+ (void)requesQrCodePay:(NSDictionary *)QrCoed success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    //    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@getqrcodepaylink?",URLAPI] parameters:QrCoed success:^(NSDictionary *responseObject) {
    //        success(responseObject);
    //    } failure:^(NSError *error) {
    //        failure(error);
    //    }];
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@getqrcodepaylink?amount=%@&countrycode=%@&icuetoken=%@&payway=%@&shopcode=%@&token=%@",URLAPI,QrCoed[@"amount"],QrCoed[@"countrycode"],QrCoed[@"icuetoken"],QrCoed[@"payway"],QrCoed[@"shopcode"],QrCoed[@"token"]] parameters:nil success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//  获取用户供货商ID
+ (void)requesSupplier:(NSDictionary *)Supplier success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@getaccountsupplierid?token=%@&nonce=%@",URLAPI,Supplier[@"token"],Supplier[@"nonce"]] parameters:nil success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 获取商家余额
+ (void)requesMerchantsBalance:(NSDictionary *)MerchantsBalance success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@getsupplierbalance?token=%@&sid=%@",URLAPI,MerchantsBalance[@"token"],MerchantsBalance[@"sid"]] parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 添加提现申请  addsuppliertakeout
+ (void)requesAddSupplierTakeOut:(NSDictionary *)QrCoed success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString * str = [NSString stringWithFormat:@"%@addsuppliertakeout?token=%@&sid=%@&amount=%@&bankname=%@&bankcardno=%@&bankcardname=%@&phone=%@&email=%@",URLAPI,QrCoed[@"token"],QrCoed[@"sid"],QrCoed[@"amount"],QrCoed[@"bankname"],QrCoed[@"bankcardno"],QrCoed[@"bankcardname"],QrCoed[@"phone"],QrCoed[@"email"]];
    NSString * urlString = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ZP_NetorkingTools POST:urlString parameters:nil success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 获取用户提现记录列表
+ (void)requesWithdrawalRecord:(NSDictionary *)WithdrawalRecord uccess:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@getsupplieroutlist?token=%@&sid=%@&page=%@",URLAPI,WithdrawalRecord[@"token"],WithdrawalRecord[@"sid"],WithdrawalRecord[@"page"]] parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 取消余额提现
+ (void)requestCanceltakeout:(NSDictionary *)Canceltakeout uccess:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString * strUrl = [NSString stringWithFormat:@"%@canceltakeout?token=%@&sid=%@&takeid=%@",URLAPI,Canceltakeout[@"token"],Canceltakeout[@"sid"],Canceltakeout[@"takeid"]];
    NSString * str = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ZP_NetorkingTools POST:str parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 获取订单支付结果
+ (void)requesOrdPay:(NSDictionary *)OrdPay uccess:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@getpayresult?poid=%@",URLAPI,OrdPay[@"poid"]] parameters:nil success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 获取浏览记录、收藏的数量
+ (void)requesBrowseCollection:(NSDictionary *)BrowseCollection uccess:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@gethistorycount?token=%@",URLAPI,BrowseCollection[@"token"]] parameters:nil success:^(id responseObject) {
        success(responseObject);
        ZPLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 获取上一期开奖号码及奖金分配信息
+ (void)getPrizeInfo:(void (^)(id obj))success failure:(void (^)(NSError *error))failure {
    if (DD_TOKEN) {
        [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@getlastlotterywinrecord?token=%@",URLAPI,DD_TOKEN] parameters:nil success:^(id responseObject) {
            success(responseObject);
            ZPLog(@"%@",responseObject);
        } failure:^(NSError *error) {
            failure(error);
        }];
    } else {
        [SVProgressHUD showErrorWithStatus:@"請先登錄賬號"];
    }
}

// 获取本期下注查看更多
+ (void)requseMoreMore:(NSDictionary *)MoreMore uccess:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@getlastlotterybuyrecord?token=%@&poolid=%@",URLAPI,MoreMore[@"token"],MoreMore[@"poolid"]] parameters:nil success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 获取历史开奖
+ (void)requestHistoryPrize:(NSDictionary *)HistoryPrize uccess:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@getlotterywinhistory?token=%@&page=%@&pagesize=%@",URLAPI,HistoryPrize[@"token"],HistoryPrize[@"page"],HistoryPrize[@"pagesize"]] parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError * error) {
        failure(error);
    }];
}

// 获取某期开奖信息
+ (void)requestLotterypoolwininfo:(NSDictionary *)HistoryPrize uccess:(void (^)(id obj))success failure:(void (^)(NSError *error))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@getlotterypoolwininfo?token=%@&poolid=%@",URLAPI,HistoryPrize[@"token"],HistoryPrize[@"pollid"]] parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError * error) {
        failure(error);
    }];
}

// 获取本期促销彩信息
+ (void)requestLotterynow:(NSString *)token uccess:(void (^)(id obj))success failure:(void (^)(NSError *error))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@getlotterynow?token=%@",URLAPI,token] parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError * error) {
        failure(error);
    }];
}

// 获取历史下注号码
+ (void)requestHistoricalBet:(NSDictionary *)HistoricalBet uccess:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@getuserlotteryhistory?token=%@&page=%@&pagesize=%@",URLAPI,HistoricalBet[@"token"],HistoricalBet[@"page"],HistoricalBet[@"pagesize"]] parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError * error) {
        failure(error);
    }];
}

// 促销彩下注
+ (void)requestBte:(NSDictionary *)Bte uccess:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@addlotteryorder?token=%@&ballstr=%@&count=%@",URLAPI,Bte[@"token"],Bte[@"ballstr"],Bte[@"count"]] parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 获取下注页面奖金彩券数量开奖时间
+ (void)requestAcquisitionTime:(NSDictionary *)AcquisitionTime uccess:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@getlotterybuyinfo?token=%@",URLAPI,AcquisitionTime[@"token"]] parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError * error) {
        failure(error);
    }];
}

// 邮箱验证
+ (void)requesEmail:(NSDictionary *)Email uccess:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@getemailverify?token=%@&emailverify=%@",URLAPI,Email[@"token"],Email[@"emailverify"]] parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 修改密码
+ (void)requestRestPassword:(NSDictionary *)RestPassword success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@updatepassword?token=%@&opwd=%@&npwd=%@",URLAPI,RestPassword[@"token"],RestPassword[@"opwd"],RestPassword[@"npwd"]] parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 申请成为供货商状态
+ (void)requestSupplier:(NSDictionary *)Suppliers success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@getsupplierstate?token=%@",URLAPI,Suppliers[@"token"]] parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError * error) {
        failure(error);
    }];
}

// 获取组织形状
+ (void)requestCompanyType:(NSDictionary *)CompanyType success:(void (^)(id))success failure:(void (^)(NSError *))failure; {
    NSString * str = [NSString stringWithFormat:@"%@getcompanytype?countrycode=%@",URLAPI,CompanyType[@"countrycode"]];
    NSString * Urlstring = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ZP_NetorkingTools GET:Urlstring parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError * error) {
        failure(error);
    }];
}

// 添加供货商申请
+ (void)requestSupplierRequest:(NSDictionary *)SupplierRequest success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure {
    //     这个接口对起来真特么累
    NSString * str = [NSString stringWithFormat:@"%@addsupplierapply?token=%@&companyname=%@&companycode=%@&poeplecount=%@&capital=%@&companydate=%@&companytype=%@&address=%@&phone=%@&fax=%@&companyuri=%@&contact=%@&contactphone=%@&contactemail=%@&companyproduct=%@&projectinfo=%@",URLAPI,SupplierRequest[@"token"],SupplierRequest[@"companyname"],SupplierRequest[@"companycode"],SupplierRequest[@"poeplecount"],SupplierRequest[@"capital"],SupplierRequest[@"companydate"],SupplierRequest[@"companytype"],SupplierRequest[@"address"],SupplierRequest[@"phone"],SupplierRequest[@"fax"],SupplierRequest[@"companyuri"],SupplierRequest[@"contact"],SupplierRequest[@"contactphone"],SupplierRequest[@"contactemail"],SupplierRequest[@"companyproduct"],SupplierRequest[@"projectinfo"]];
    NSString * urlString = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ZP_NetorkingTools POST:urlString parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 70) 获取退换货记录列表
+ (void)requestGetrefundlist:(NSDictionary *)Getrefundlist success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@getrefundlist?token=%@&page=%@&pagesize=%@",URLAPI,Getrefundlist[@"token"],Getrefundlist[@"page"],Getrefundlist[@"pagesize"]] parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError * error) {
        failure(error);
    }];
}

// 获取退换货详情（订单跳转）
+ (void)requestGetrefundinfoOrder:(NSDictionary *)GetrefundinfoOrder success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@getrefundinfo?token=%@&oid=%@&countrycode=%@",URLAPI,GetrefundinfoOrder[@"token"],GetrefundinfoOrder[@"oid"],GetrefundinfoOrder[@"countrycode"]] parameters:nil success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError * error) {
        failure(error);
    }];
}

// 获取退换货详情（正常）
+ (void)requestGetrefundinfo:(NSDictionary *)Getrefundinfo success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@getrefundinfo?token=%@&refundid=%@&countrycode=%@",URLAPI,Getrefundinfo[@"token"],Getrefundinfo[@"refundid"],Getrefundinfo[@"countrycode"]] parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError * error) {
        failure(error);
    }];
}

//72) 更改退换货状态
+ (void)RequestRefundStatus:(NSDictionary *)RefundStatus success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure {
    NSString * strURl = [NSString stringWithFormat:@"%@updaterefundstate?token=%@&refundid=%@&type=%@&rtimgs=%@",URLAPI,RefundStatus[@"token"],RefundStatus[@"refundid"],RefundStatus[@"type"],RefundStatus[@"rtimgs"]];
    NSString * str = [strURl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ZP_NetorkingTools POST:str parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//73) 修改用户头像
+ (void)RequestUploadavatarimg:(NSDictionary *)RefundStatus Data:(NSMutableArray *)arr success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure {
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@uploadavatarimg?token=%@",URLAPI,RefundStatus[@"token"]] parameters:nil ContentArray:arr success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end

