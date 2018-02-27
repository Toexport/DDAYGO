//
//  Supplier1ViewController.m
//  DDAYGO
//
//  Created by Summer on 2017/12/29.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "Supplier1ViewController.h"
#import "PrefixHeader.pch"
#import "SupplierTableViewCell.h"
#import "SupplierViewCell2.h"
#import "PrefixHeader.pch"
#import "ZP_MyTool.h"
@interface Supplier1ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)NSArray * postionArray;
@property (nonatomic, strong)NSArray * array;
@property (nonatomic, strong)NSArray * arrayP;

@property (nonatomic, strong) NSString *seleStr;
@property (nonatomic, strong) NSNumber *seleId;



@property (nonatomic, strong) NSMutableArray *typeNameArray;
@property (nonatomic, strong) NSMutableArray *typeIdArray;

@property (nonatomic, strong) NSMutableDictionary *dataDic;
@property (nonatomic, strong) NSMutableDictionary *PldataDic;


@end

@implementation Supplier1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.TExtLabel.text = self.reason;
    [self initUI];
    [self SupplierllData];
}
- (IBAction)requstAction:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.noStoreView.alpha = 0;
    } completion:^(BOOL finished) {
        self.noStoreView.hidden = YES;
    }];
}

// UI
-(void)initUI {
    self.noStoreView.hidden = YES;
    self.sendingBtn.hidden = YES;
    
    // 显示 重新加载的 ··  self.noStoreView.hidden = no; self.sendingBtn.hidden = no;
    
    
    // 直接显示的  self.noStoreView.hidden = YES;  self.sendingBtn.hidden = YES;
    
    switch (self.stausType) {
        case -1:
        {
            self.noStoreView.hidden = YES;
            self.sendingBtn.hidden = YES;
        }
            break;
            
        case 2:
        {
            self.noStoreView.hidden = NO;
        }
            break;
        case 3:
        {
            
        }
            break;
        case 7:
        case 0:
        {
            self.noStoreView.hidden = NO;
            self.sendingBtn.hidden = NO;
        }
            break;
            
        default:
            break;
    }
    self.title = MyLocal(@"supplier");
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: ZP_textWite}]; 
    [self.navigationController.navigationBar setBarTintColor:ZP_NavigationCorlor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SupplierTableViewCell" bundle:nil] forCellReuseIdentifier:@"SupplierTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SupplierViewCell2" bundle:nil] forCellReuseIdentifier:@"SupplierViewCell2"];
    
    _array = [NSArray arrayWithObjects:MyLocal(@"Company name:"),MyLocal(@"Unified title:"),MyLocal(@"Company number:"),MyLocal(@"Injection capital:"),MyLocal(@"Date of establishment:"),MyLocal(@"Organization form:"),MyLocal(@"Company address:"),MyLocal(@"Company telephone:"),MyLocal(@"Fax (optional):"),MyLocal(@"Company website (optional):"),MyLocal(@"Contacts:"),MyLocal(@"Contact email:"),MyLocal(@"Contact number:"),MyLocal(@"Business project:"),MyLocal(@"Cooperation projects:"), nil];
    //这个数组是放 pl 的放进去·对应的放好
    _arrayP = [NSArray arrayWithObjects:MyLocal(@" "),MyLocal(@" "),MyLocal(@"50 to 100 people"),MyLocal(@" "),MyLocal(@"YYYY - MM -DD"),MyLocal(@" "),MyLocal(@" "),MyLocal(@" "),MyLocal(@" "),MyLocal(@" "),MyLocal(@"Contact/title/extension."),MyLocal(@" "),MyLocal(@" "),MyLocal(@" "),MyLocal(@" "), nil];
    
    _LocationLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"countrycode"];
    
    switch ([[[NSUserDefaults standardUserDefaults] objectForKey:@"countrycode"] integerValue]) {
        case 886:
            _LocationLabel.text = MyLocal(@"Taiwan");
            break;
        case 86:
            _LocationLabel.text = MyLocal(@"China");
            break;
        case 852:
            _LocationLabel.text = MyLocal(@"HongKong");
            break;
        default:
            break;
    }
}
// 提交按钮
- (IBAction)SubmitBut:(id)sender {
    
    NSArray *arr = [self.dataDic allKeys];
    if (arr.count == 14) {
        NSLog(@"填写完成");
    }else{
        [SVProgressHUD showErrorWithStatus:MyLocal(@"Please complete")];
        return;
    }
    
    if (_seleStr.length < 1) {
        [SVProgressHUD showErrorWithStatus:MyLocal(@"Please select the organization form.")];
        return;
    }
    
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //公司名称
        if ([obj integerValue] == 0) {
            NSLog(@"公司名称 = %@",self.dataDic[obj]);
        }
        //统一编号。依次类推   --> (没有5 因为5是组织形态)
        if ([obj integerValue] == 1) {
            NSLog(@"统一编号 = %@",self.dataDic[obj]);
        }
    }];
    
    //组织形态  = _seleStr
    NSLog(@"组织形态 %@",_seleStr);
    //数据都在这个里 self.dataDic;  key 是顺序 从上到下 0 - 13 value 是textfield的值 ·就是需要上传到接口的
    NSLog(@"%@",self.dataDic);
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    dic[@"companyname"] = [self.dataDic objectForKey:@(0)];
    dic[@"companycode"] = [self.dataDic objectForKey:@(1)];
    dic[@"poeplecount"] = [NSString stringWithFormat:@"%@人",[self.dataDic objectForKey:@(2)]];
    dic[@"capital"] = [NSString stringWithFormat:@"%@万",[self.dataDic objectForKey:@(3)]];
    dic[@"companydate"] = [self.dataDic objectForKey:@(4)];
    dic[@"companytype"] = _seleId;
    dic[@"address"] = [self.dataDic objectForKey:@(6)];
    dic[@"phone"] = [self.dataDic objectForKey:@(7)];
    dic[@"fax"] = [self.dataDic objectForKey:@(8)];
    dic[@"companyuri"] = [self.dataDic objectForKey:@(9)];
    dic[@"contact"] = [self.dataDic objectForKey:@(10)];
    dic[@"contactemail"] = [self.dataDic objectForKey:@(11)];
    dic[@"contactphone"] = [self.dataDic objectForKey:@(12)];
    dic[@"companyproduct"] = [self.dataDic objectForKey:@(13)];
    dic[@"projectinfo"] = [self.dataDic objectForKey:@(14)];
    [self AllData:dic];
}

// 数据
- (void)AllData:(NSMutableDictionary *)dic {
    [ZP_MyTool requestSupplierRequest:dic success:^(id obj) {
        if ([obj[@"result"]isEqualToString:@"ok"]) {
            [SVProgressHUD showSuccessWithStatus:MyLocal(@"Successful application pending approval.")];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else
            if ([obj[@"result"]isEqualToString:@"token_err"]) {
                [SVProgressHUD showInfoWithStatus:MyLocal(@"token is invalid")];
            }else
                if ([obj[@"result"]isEqualToString:@"companyname_null_err"]) {
                    [SVProgressHUD showInfoWithStatus:MyLocal(@"company name is empty.")];
                }else
                    if ([obj[@"result"]isEqualToString:@"companycode_null_err"]) {
                        [SVProgressHUD showInfoWithStatus:MyLocal(@"Please enter a uniform number.")];
                    }else
                        if ([obj[@"result"]isEqualToString:@"poeplecount_null_err"]) {
                            [SVProgressHUD showInfoWithStatus:MyLocal(@"Please enter the company number.")];
                        }else
                            if ([obj[@"result"]isEqualToString:@"capital_null_err"]) {
                                [SVProgressHUD showInfoWithStatus:MyLocal(@"Please enter registered capital.")];
                            }else
                                if ([obj[@"result"]isEqualToString:@"companydate_null_err"]) {
                                    [SVProgressHUD showInfoWithStatus:MyLocal(@"Please enter the date of creation.")];
                                }else
                                    if ([obj[@"result"]isEqualToString:@"companydate_formart_err"]) {
                                        [SVProgressHUD showInfoWithStatus:MyLocal(@"Creation date format error, must be in English - to divide.")];
                                    }else
                                        if ([obj[@"result"]isEqualToString:@"address_null_err"]) {
                                            [SVProgressHUD showInfoWithStatus:MyLocal(@"Please enter the company address.")];
                                        }else
                                            if ([obj[@"result"]isEqualToString:@"phone_null_err"]) {
                                                [SVProgressHUD showInfoWithStatus:MyLocal(@"Please enter your company phone.")];
                                            }else
                                                if ([obj[@"result"]isEqualToString:@"contact_null_err"]) {
                                                    [SVProgressHUD showInfoWithStatus:MyLocal(@"Please enter emergency contact.")];
                                                }else
                                                    if ([obj[@"result"]isEqualToString:@"contactphone_null_err"]) {
                                                        [SVProgressHUD showInfoWithStatus:MyLocal(@"Please enter your contact Phone.")];
                                                    }else
                                                        if ([obj[@"result"]isEqualToString:@"contactemail_null_err"]) {
                                                            [SVProgressHUD showInfoWithStatus:MyLocal(@"Please enter your contact email.")];
                                                        }else
                                                            if ([obj[@"result"]isEqualToString:@"contactemail_format_err"]) {
                                                                [SVProgressHUD showInfoWithStatus:MyLocal(@"Incorrect email format.")];
                                                            }else
                                                                if ([obj[@"result"]isEqualToString:@"companyproduct_null_err"]) {
                                                                    [SVProgressHUD showInfoWithStatus:MyLocal(@"Please enter project management.")];
                                                                }else
                                                                    if ([obj[@"result"]isEqualToString:@"projectinfo_null_err"]) {
                                                                        [SVProgressHUD showInfoWithStatus:MyLocal(@"Please enter the cooperation project.")];
                                                                    }else
                                                                        if ([obj[@"result"]isEqualToString:@"sup_err"]) {
                                                                            [SVProgressHUD showInfoWithStatus:MyLocal(@"is already a supplier or is applying for a supplier.")];
                                                                        }else
                                                                            if ([obj[@"result"]isEqualToString:@"agt_err"]) {
                                                                                [SVProgressHUD showInfoWithStatus:MyLocal(@"agent cannot apply for the supplier.")];
                                                                            }else
                                                                                if ([obj[@"result"]isEqualToString:@"cname_er"]) {
                                                                                    [SVProgressHUD showInfoWithStatus:MyLocal(@"company name already exists")];
                                                                                }else
                                                                                    if ([obj[@"result"]isEqualToString:@"ccode_err"]) {
                                                                                        [SVProgressHUD showInfoWithStatus:MyLocal(@"uniform number already exists")];
                                                                                    }else
                                                                                        if ([obj[@"result"]isEqualToString:@"sys_err"]) {
                                                                                            [SVProgressHUD showInfoWithStatus:MyLocal(@"Add failure")];
                                                                                        }else
                                                                                            //*************************************Token被挤掉***************************************************//
                                                                                            if ([obj[@"result"]isEqualToString:@"token_not_exist"]) {
                                                                                                Token = nil;
                                                                                                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
                                                                                                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"symbol"];
                                                                                                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"countrycode"];
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
                                                                                                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:MyLocal(@"Cancel",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
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
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (5 == indexPath.row) {
        SupplierViewCell2 * cell2 = [tableView dequeueReusableCellWithIdentifier:@"SupplierViewCell2"];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;  //取消Cell点击变灰效果、
        
        if (_seleStr.length > 0) {
            cell2.TissueMorphologyLabel.text = _seleStr;
        }else{
            cell2.TissueMorphologyLabel.text = MyLocal(@"Please select the organization form.");
            
        }
        //        [cell2.SelectBut addTarget:self action:@selector(actBut:) forControlEvents:UIControlEventTouchUpInside];
        return cell2;
    }else {
        SupplierTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SupplierTableViewCell"];
        
        cell.titleLabel.text = self.array[indexPath.row];
        cell.savaData = ^(NSString *title) {
            NSLog(@"title %@",title);
            [self.dataDic setObject:title forKey:@(indexPath.row)];
        };
        NSArray *arr = [self.dataDic allKeys];
        if ( [arr containsObject:@(indexPath.row)]) {
            cell.textField.text =  [self.dataDic objectForKey:@(indexPath.row)];
        }else{
            cell.textField.text = nil;
        }
        cell.textField.placeholder = _arrayP[indexPath.row];
        cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
        cell.textField.keyboardType = UIKeyboardTypeDefault;
        
        if (indexPath.row == 1) {
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        }
        if (indexPath.row == 2) {
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        }
        if (indexPath.row == 3) {
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            
        }
        if (indexPath.row == 4) {
            cell.textField.keyboardType = UIKeyboardTypeASCIICapable;
            
        }
        if (indexPath.row == 7) {
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            
        }
        if (indexPath.row == 8) {
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            
        }
        if (indexPath.row == 9) {
            cell.textField.keyboardType = UIKeyboardTypeASCIICapable;
        }
        
        if (indexPath.row == 10) {
            
        }
        if (indexPath.row == 11) {
            cell.textField.keyboardType = UIKeyboardTypeASCIICapable;
        }
        if (indexPath.row == 12) {
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        }
        return cell;
    }
}

// 获取组织形态列表
- (void)SupplierllData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"countrycode"] = @"886";
    [ZP_MyTool requestCompanyType:dic success:^(id obj) {
        ZPLog(@"%@",obj);
        NSArray *ar = obj;
        [ar enumerateObjectsUsingBlock:^(id  _Nonnull objj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.typeIdArray addObject:objj[@"typeid"]];
            [self.typeNameArray addObject:objj[@"typename"]];
        }];
        
    } failure:^(NSError * error) {
        
        ZPLog(@"%@",error);
    }];
    
}

- (void)actBut:(UIButton *)but {
    
    JXPopoverView * popoverView = [JXPopoverView popoverView];
    NSMutableArray * titleArray = [NSMutableArray array];
    for (int i = 0; i < self.typeNameArray.count; i ++) {
        JXPopoverAction * action1 = [JXPopoverAction actionWithTitle:self.typeNameArray[i] handler:^(JXPopoverAction *action) {
            
            NSLog(@"dian ji l %@",self.typeNameArray[i]);
            
            _seleStr = self.typeNameArray[i];
            _seleId = self.typeIdArray[i];
            NSIndexPath *index = [NSIndexPath indexPathForRow:5 inSection:0];
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index, nil] withRowAnimation:UITableViewRowAnimationNone];
            
        }];
        [titleArray addObject:action1];
    }
    
    [popoverView showToView:but withActions:titleArray];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 5) {
        SupplierViewCell2 * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
        JXPopoverView *popoverView = [JXPopoverView popoverView];
        NSMutableArray *titleArray = [NSMutableArray array];
        for (int i = 0; i < self.typeNameArray.count; i ++) {
            JXPopoverAction * action1 = [JXPopoverAction actionWithTitle:self.typeNameArray[i] handler:^(JXPopoverAction *action) {
                
                NSLog(@"dian ji l %@",self.typeNameArray[i]);
                _seleStr = self.typeNameArray[i];
                _seleId = self.typeIdArray[i];
                NSIndexPath *index = [NSIndexPath indexPathForRow:5 inSection:0];
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index, nil] withRowAnimation:UITableViewRowAnimationNone];
            }];
            [titleArray addObject:action1];
        }
        
        [popoverView showToView:cell.SelectBut withActions:titleArray];
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}


- (NSMutableArray *)typeIdArray {
    if (!_typeIdArray) {
        _typeIdArray = [NSMutableArray array];
    }
    return _typeIdArray;
}
- (NSMutableArray *)typeNameArray {
    if (!_typeNameArray) {
        _typeNameArray = [NSMutableArray array];
    }
    return _typeNameArray;
}

- (NSMutableDictionary *)dataDic {
    if (!_dataDic) {
        _dataDic = [NSMutableDictionary dictionary];
    }
    return _dataDic;
}

- (NSMutableDictionary *)PldataDic {
    if (!_PldataDic) {
        _PldataDic = [NSMutableDictionary dictionary];
    }
    return _PldataDic;
}

@end
