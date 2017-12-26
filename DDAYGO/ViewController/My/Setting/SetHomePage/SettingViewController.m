//
//  SettingViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/22.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "SettingViewController.h"
#import "AddressViewController.h"
#import "HomeViewController.h"
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
@interface SettingViewController ()
@property (nonatomic, strong)SelectPhotoManager * photoManager;
@property (weak, nonatomic) IBOutlet UIImageView * headerImage;
@property (weak, nonatomic) IBOutlet UIButton *genderGail;
@property (weak, nonatomic) IBOutlet UIButton *genderBooy;
@property (nonatomic, strong)NSMutableArray * newsData;
/** 调整是否为ICUE登录*/
@property (weak, nonatomic) IBOutlet UIButton *IuceNumBut;
@property (weak, nonatomic) IBOutlet UIButton *BangDingBut;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * BangDingLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * IcueNumLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * view3Layout;
@property (weak, nonatomic) IBOutlet UIView * view1;
@property (weak, nonatomic) IBOutlet UIView * view3;
@property (weak, nonatomic) IBOutlet UIView * DividingLineView; // 分割线

@property (nonatomic, strong)NSMutableDictionary * dataDic;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setHead];
    [self allData];
    self.title = NSLocalizedString(@"Setting", nil) ;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_WhiteColor}];   // 更改导航栏字体颜色
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //     判断是否为ICUE登录
    if (ZPICUEToken.length > 0) {
        _BangDingLayout.constant = CGFLOAT_MIN;
        _IcueNumLayout.constant = CGFLOAT_MIN;
        _DividingLineView.hidden = YES;
        _view1.hidden = YES;
        _view3.hidden = YES;
        _view3Layout.constant = 100.0;
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
        model.avatarimg = [NSString stringWithFormat:@"http://www.ddaygo.com%@",obj[@"avatarimg"]];
        model.nickname = obj[@"nickname"];
        model.realname = obj[@"realname"];
        model.icueaccount = obj[@"icueaccount"];
        model.email = obj[@"email"];
        model.emailverify = obj[@"emailverify"];
        model.introducer = obj[@"introducer"];
        
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
        [SVProgressHUD showInfoWithStatus:@"服务器链接失败"];
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

- (IBAction)touxiangAction:(id)sender {
    if (!_photoManager) {
        _photoManager = [[SelectPhotoManager alloc]init];
    }
    [_photoManager startSelectPhotoWithImageName:NSLocalizedString(@"Choose photos", nil)];
    __weak typeof(self)mySelf = self;
 //  选取照片成功
    _photoManager.successHandle=^(SelectPhotoManager *manager,UIImage * image){
        
        mySelf.headerImage.image = image;
 //  保存到本地
        NSData *data = UIImagePNGRepresentation(image);
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"headerImage"];
    };
    
}

- (void)setHead {
    _headerImage.userInteractionEnabled = YES;
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    //    [_headerImage addGestureRecognizer:tap];
    //  这里是从本地取的，如果是上线项目一定要从服务器取头像地址加载
    UIImage * img = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"headerImage"]];
    if (img) {
        _headerImage.image = img;
    }
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
                        [SVProgressHUD showInfoWithStatus:@"修改失败"];
                    }
                NSLog(@"xiugai success");
                self.nicknameLabel.text = (NSString *)response;
            } failure:^(NSError * error) {
                ZPLog(@"%@",error);
//                [SVProgressHUD showInfoWithStatus:@"服务器链接失败"];
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
                    [SVProgressHUD showInfoWithStatus:@"修改失败"];
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
                    [SVProgressHUD showInfoWithStatus:@"修改失败"];
                }
        } failure:^(NSError *error) {
//            ZPLog(@"%@",error);
            [SVProgressHUD showInfoWithStatus:@"服务器链接失败"];
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
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
}

//  登出
- (IBAction)logoutAction:(id)sender {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"reminding", nil) message: NSLocalizedString(@"Are you sure you want to log out?", nil)preferredStyle:UIAlertControllerStyleActionSheet];
    //  设置popover指向的item
    alert.popoverPresentationController.barButtonItem = self.navigationItem.leftBarButtonItem;
    //  添加按钮
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"ok", nil)  style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        Token = nil;
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"symbol"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"countrycode"];
        ZPICUEToken = nil;
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"icuetoken"];
        [self.navigationController popViewControllerAnimated:YES];
//        HomeViewController * Home = [[HomeViewController alloc]init];
//        [self.navigationController pushViewController:Home animated:YES];
        NSLog(@"点击了确定按钮");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"cancel",nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"点击了取消按钮");
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

// 网路请求
//-(viod)updata{
//
//    UIApplication *application = [UIApplication sharedApplication];
//
//    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
//    manager.requestSerializer.timeoutInterval = 5;
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/javascript",@"text/html", @"application/json",nil];
//
//    NSArray*arrar=[THE_IMG_PATH componentsSeparatedByString:@"/"];
//    NSString*imageName=[arrar objectAtIndex:arrar.count-1];
//    NSMutableDictionary*dic=@{@"image":_imageString,@"imagePath":imageName};
//
//    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//
//        if(sucess){
//
//            sucess(responseObject);
//            NSLog(@"responseObject=%@",responseObject);
//        }
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"LYYB----AFNetWoring.errno=%@",error);
//        fails(error);
//    }];
//}

- (NSMutableDictionary *)dataDic {
    if (!_dataDic) {
        _dataDic = [NSMutableDictionary dictionary];
        _dataDic[@"token"] = Token;
    }
    return _dataDic;
}

@end

