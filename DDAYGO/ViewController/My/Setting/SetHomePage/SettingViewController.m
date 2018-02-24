//
//  SettingViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/22.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "SettingViewController.h"
#import "AddressViewController.h"
#import "AboutDDAYGOController.h"
#import "MyViewController.h"
#import "BindingICUEViewController.h"
#import "DialogBox.h"
#import "ResetPasswordViewController.h"
#import "PrefixHeader.pch"
#import "SelectPhotoManager.h"
#import "LanguageController.h"
#import "BindingEmailController.h"
#import "BindingIntroduce.h"
#import "UINavigationBar+Awesome.h"
#import "MyViewController.h"
#import "ZP_MyTool.h"
#import "ZP_HomePageModel.h"
#import "ZP_NetorkingTools.h"

//ZP_NetorkingTools
@interface SettingViewController ()
@property (nonatomic, strong)SelectPhotoManager * photoManager;
@property (weak, nonatomic) IBOutlet UIImageView * headerImage;
@property (weak, nonatomic) IBOutlet UIButton *genderGail;
@property (weak, nonatomic) IBOutlet UIButton *genderBooy;
@property (nonatomic, strong)NSMutableArray * newsData;
/** 调整是否为ICUE登录*/
@property (weak, nonatomic) IBOutlet UIButton * IuceNumBut;
@property (weak, nonatomic) IBOutlet UIButton * BangDingBut;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * BangDingLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * IcueNumLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * view3Layout;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *view4Layout;
@property (weak, nonatomic) IBOutlet UIView * view1;
@property (weak, nonatomic) IBOutlet UIView * view3;
@property (weak, nonatomic) IBOutlet UIView * DividingLineView; // 分割线
//@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *xgview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *xgLayout;

@property (nonatomic, strong)NSMutableDictionary * dataDic;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self setHead];
    self.title = NSLocalizedString(@"Setting", nil) ;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: ZP_textWite}];
    [self.navigationController.navigationBar setBarTintColor:ZP_NavigationCorlor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self allData];
    //     判断是否为ICUE登录
    if (ZPICUEToken.length > 0) {
        _BangDingLayout.constant = CGFLOAT_MIN;
        _IcueNumLayout.constant = CGFLOAT_MIN;
        //        _view4Layout.constant = CGFLOAT_MIN;
        _xgLayout.constant = CGFLOAT_MIN;
        _xgview.hidden = YES;
        _DividingLineView.hidden = YES;
        _view1.hidden = YES;
        _view3.hidden = YES;
        //        _view4.hidden = YES;
        _view3Layout.constant = 50.0;
    }else {
        _IcueNumLayout.constant = CGFLOAT_MIN;
        _view1.hidden = YES;
        _view3Layout.constant = 153.0;
    }
    
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];
}
//  数据
- (void)allData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    int i = arc4random_uniform(999);  // 随机数
    dic[@"nonce"] = @(i);
    [ZP_MyTool requestSetHomePage:dic success:^(id obj) {
        ZPLog(@"%@",obj);
        ZP_HomePageModel * model = [[ZP_HomePageModel alloc]init];
        model.avatarimg = [NSString stringWithFormat:@"%@%@",ImgAPI,obj[@"avatarimg"]];
        model.nickname = obj[@"nickname"];
        model.realname = obj[@"realname"];
        model.icueaccount = obj[@"icueaccount"];
        if ([model.icueaccount length]) {
            _BangDingBut.userInteractionEnabled = NO;
        }else {
            _BangDingBut.userInteractionEnabled = YES;
        }
        model.email = obj[@"email"];
        model.emailverify = obj[@"emailverify"];
        model.introducer = obj[@"introducer"];
        if ([model.introducer length]) {
            _IuceNumBut.userInteractionEnabled = NO;
        }else {
            _IuceNumBut.userInteractionEnabled = YES;
        }
        self.dataDic[@"nickname"] = obj[@"nickname"];
        self.dataDic[@"realname"] = obj[@"realname"];
        self.dataDic[@"sex"] = obj[@"sex"];
        self.dataDic[@"birthday"] = obj[@"birthday"];
        self.dataDic[@"phone"] = obj[@"phone"];
        self.dataDic[@"address"] = obj[@"address"];
        
        if ([obj[@"sex"] isEqualToString:@"男"]) {
            _genderBooy.selected = YES;
        }else{
            _genderGail.selected = YES;
        }
        
        // 填写数据
        [self fillData:model];
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
//        [SVProgressHUD showInfoWithStatus:@"服務器鏈接失敗"];
    }];
}

- (void)fillData:(ZP_HomePageModel *)model{
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:model.avatarimg] placeholderImage:[UIImage imageNamed:@"HeadrImage"]];
    _AccountNumber.text = model.email; // 账号
    _nicknameLabel.text = model.nickname; // 昵称
    _bindingEmailLabel.text = model.emailverify;  // 邮箱
    _BindingICUELabel.text = model.icueaccount; // ICUE 绑定
    _BindingIntroduce.text = model.introducer; // ICUE 介绍人
}

// 修改头像
- (IBAction)touxiangAction:(id)sender {
    if (!_photoManager) {
        _photoManager = [[SelectPhotoManager alloc]init];
    }
    [_photoManager startSelectPhotoWithImageName:NSLocalizedString(@"Choose photos", nil)];
    __weak typeof(self)mySelf = self;
    //  选取照片成功
    _photoManager.successHandle=^(SelectPhotoManager *manager,UIImage * image){
        image = [mySelf imageWithImage:image scaledToSize:CGSizeMake(150, 150)];
        
        //  保存到本地
        NSMutableArray * imageArray = [NSMutableArray array];
        NSData * data =  UIImageJPEGRepresentation(image, 1);
        [imageArray addObject:data];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"headerImage"];
        //        这个封装可以上传多张图片
        [ZP_MyTool RequestUploadavatarimg:@{@"token":DD_TOKEN} Data:imageArray success:^(id obj) {
            ZPLog(@"%@",obj);
            mySelf.headerImage.image = image;
            [[MyViewController sharedInstanceTool].headImageBut setImage:image forState:UIControlStateNormal]; 
        } failure:^(NSError *error) {
            ZPLog(@"%@",error.description);
            
        }];
    };
    
}

- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

// 账号
- (IBAction)zhanghaoAction:(id)sender {
    NSLog(@"账号");
}

//  修改昵称
- (IBAction)nichengAction:(id)sender {
    
    [[DialogBox getInstance] showDialogBoxWithOperation:DDAModifyNickname FinishBlock:^(id response) {
        self.dataDic[@"nickname"] = (NSString *)response;
        [ZP_MyTool requesModifydata:self.dataDic uccess:^(id obj) {
            ZPLog(@"%@",obj);
            if ([obj[@"result"]isEqualToString:@"ok"]) {
                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            }else
                if ([obj[@"result"]isEqualToString:@"sys_error"]) {
                    [SVProgressHUD showInfoWithStatus:@"修改失敗"];
                }
            NSLog(@"xiugai success");
            self.nicknameLabel.text = (NSString *)response;
            [self allData]; //刷新表格里面的数据
        } failure:^(NSError * error) {
            ZPLog(@"%@",error);
        }];
    }];
}


- (IBAction)genderGail:(UIButton *)sender {
    NSLog(@"%d",sender.selected);
    if (sender.selected) {
        return;
    }else{
        sender.selected = !sender.selected;
        _genderBooy.selected = NO;
        self.dataDic[@"sex"] = @"女";
        [ZP_MyTool requesModifydata:self.dataDic uccess:^(id json) {
            if ([json[@"result"]isEqualToString:@"ok"]) {
                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            }else
                if ([json[@"result"]isEqualToString:@"sys_error"]) {
                    [SVProgressHUD showInfoWithStatus:@"修改失敗"];
                }
            //            NSLog(@"%@",json);
        } failure:^(NSError *error) {
            ZPLog(@"%@",error);
            //            [SVProgressHUD showInfoWithStatus:@"服务器链接失败"];
        }];
    }
}

- (IBAction)genderBooy:(UIButton *)sender {
    //    NSLog(@"%d",sender.selected);
    if (sender.selected) {
        return;
    }else {
        _genderGail.selected = NO;
        sender.selected = !sender.selected;
        self.dataDic[@"sex"] = @"男";
        [ZP_MyTool requesModifydata:self.dataDic uccess:^(id json) {
            if ([json[@"result"]isEqualToString:@"ok"]) {
                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            }else
                if ([json[@"result"]isEqualToString:@"sys_error"]) {
                    [SVProgressHUD showInfoWithStatus:@"修改失敗"];
                }
        } failure:^(NSError *error) {
            //            ZPLog(@"%@",error);
            [SVProgressHUD showInfoWithStatus:MyLocal(@"Server link failed")];
        }];
    }
}

//  收货地址
- (IBAction)shdzAction:(id)sender {
    AddressViewController *viewController = [[AddressViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

//  绑定ICUE
- (IBAction)bdICUEAction:(id)sender {
    //        _BangDingBut.height = NO;
    BindingICUEViewController *viewController = [[BindingICUEViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
}
//  绑定邮箱
- (IBAction)BindingEmail:(id)sender {
    BindingEmailController * Email = [[BindingEmailController alloc]init];
    [self.navigationController pushViewController:Email animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
}
// 绑定推荐人
- (IBAction)bdIntroduce:(id)sender {
    BindingIntroduce * introduce = [[BindingIntroduce alloc]init];
    [self.navigationController pushViewController:introduce animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
}

//  修改密码
- (IBAction)xgmmAction:(id)sender {
    ResetPasswordViewController *viewController = [[ResetPasswordViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
//  语言
- (IBAction)languageAction:(id)sender {
    LanguageController * Language = [[LanguageController alloc]init];
    [self.navigationController pushViewController:Language animated:YES];
    //    [self presentViewController:Language animated:YES completion:nil];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
}
// 关于DDAYGO
- (IBAction)AboutBut:(id)sender {
    AboutDDAYGOController * AboutDDAYGO = [[AboutDDAYGOController alloc]init];
    [self.navigationController pushViewController:AboutDDAYGO animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
}

//  登出
- (IBAction)logoutAction:(id)sender {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"reminding", nil) message: NSLocalizedString(@"Are you sure you want to log out?", nil)preferredStyle:UIAlertControllerStyleActionSheet];
    //  设置popover指向的item
    alert.popoverPresentationController.barButtonItem = self.navigationItem.leftBarButtonItem;
    //  確定按钮
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"ok", nil)  style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        Token = nil;
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"symbol"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"countrycode"];
        ZPICUEToken = nil;
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"icuetoken"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"state"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"headerImage"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"NameLabel"];
        [[SDImageCache sharedImageCache] clearDisk];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.navigationController popToRootViewControllerAnimated:NO];
        //跳转
        if ([[[UIApplication sharedApplication] keyWindow].rootViewController isKindOfClass:[UITabBarController class]]) {
            
            UITabBarController * tbvc  = [[UIApplication sharedApplication] keyWindow].rootViewController;
            [tbvc setSelectedIndex:0];
        }
        NSLog(@"点击了确定按钮");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"cancel",nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"点击了取消按钮");
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (NSMutableDictionary *)dataDic {
    if (!_dataDic) {
        _dataDic = [NSMutableDictionary dictionary];
        _dataDic[@"token"] = Token;
    }
    return _dataDic;
}

@end

