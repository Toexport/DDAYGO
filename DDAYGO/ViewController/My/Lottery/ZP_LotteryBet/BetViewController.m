//
//  BetViewController.m
//  DDAYGO
//
//  Created by Summer on 2017/11/28.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "BetViewController.h"
#import "PrefixHeader.pch"
#import "tableHeadView1.h"
#import "ZP_MyTool.h"
#import "BetTableViewCellTwo.h"
#import "BetTableViewMyCell.h"
#import "BetTableViewMyCell2.h"
#import "ZP_BetHeaderModel.h"
@interface BetViewController ()<UITableViewDelegate,UITableViewDataSource> {
    UIButton * _chooseCityBtn;
}
@property (weak, nonatomic) IBOutlet IQTableView * tableView;
//@property (nonatomic ,strong) BetHeaderView *whiteBallHeaderView;
//@property (nonatomic ,strong) BetHeaderView *redBallHeaderView;
@property (nonatomic,strong) tableHeadView1   *tableHeadView1;

@property (nonatomic, strong) UILabel *label3;
@property (nonatomic, strong) BetTableViewCellTwo *cell1;
//* 数据**/
@property (nonatomic, strong) NSMutableArray *Selearray;
@property (nonatomic,strong) NSMutableArray   *array1;
@property (nonatomic,strong) NSMutableArray   *arrayT;

@property (nonatomic, strong) NSMutableArray *dicArray;

@property (nonatomic, strong)   ZP_BetHeaderModel * model;

@end

@implementation BetViewController

- (NSMutableArray *)dicArray
{
    if (!_dicArray) {
        _dicArray = [NSMutableArray array];
    }
    return _dicArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self AcquisitionTime];
    [self initUI];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(adjustStatusBar:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
//     iphoneX
    if ([[UIApplication sharedApplication]statusBarFrame].size.height > 20) {
        _TableviewLayoutConstraint.constant = 30;
        
    }
}

- (void)initUI {
    self.title =MyLocal(@"Lottery to fill out");
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"BetTableViewMyCell" bundle:nil] forCellReuseIdentifier:@"BetTableViewMyCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BetTableViewCellTwo" bundle:nil] forCellReuseIdentifier:@"BetTableViewCellTwo"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BetTableViewMyCell2" bundle:nil] forCellReuseIdentifier:@"BetTableViewMyCell2"];

    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
//     添加一个按钮
    CGRect frame = _chooseCityBtn.frame;
    frame.size.width = 50;
    frame.size.height = 35;
    _chooseCityBtn.frame = frame;
    _chooseCityBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_chooseCityBtn setTitle:MyLocal(@"random") forState:UIControlStateNormal];
    CGFloat imageWidth = _chooseCityBtn.imageView.bounds.size.width;
    CGFloat labelWidth = _chooseCityBtn.titleLabel.bounds.size.width;
    _chooseCityBtn.frame =CGRectMake(0, 0, 40.0f, 25.0f);
    _chooseCityBtn.titleLabel.font = ZP_TooBarFont;
    _chooseCityBtn.layer.cornerRadius = 3;
    _chooseCityBtn.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth   , 0, -labelWidth);
    _chooseCityBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
    [_chooseCityBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    _chooseCityBtn.backgroundColor = [UIColor whiteColor];
    [_chooseCityBtn addTarget:self action:@selector(Instruction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc]initWithCustomView:_chooseCityBtn]];
    
}

- (void)viewDidAppear:(BOOL)animated {
    self.tableView.frame =CGRectMake(0, 0, ZP_Width, ZP_height-TabbarHeight -NavBarHeight);
    
}
// 获取时间，彩金劵数量
- (void)AcquisitionTime {
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"token"] = Token;
    [ZP_MyTool requestAcquisitionTime:dict uccess:^(id obj) {
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
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"reminding", nil) message:NSLocalizedString(@"account exists",nil) preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:MyLocal(@"Cancel") style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                ZPLog(@"取消");
            }];
            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"ok",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
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
       _model = [ZP_BetHeaderModel mj_objectWithKeyValues:obj];
        
        [self.tableView reloadData];
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
}


// 隨機
- (void)Instruction {
    self.array1 = [NSMutableArray array];
    for (int i = 0; i< 5; i++) {
        int arc = 0;
        while (arc < 1) {
            arc = arc4random_uniform(70);
            for (NSNumber *number in self.array1) {
                if (number.intValue == arc) {
                    arc = 0;
                }
            }
        }
        [self.array1 addObject:[NSNumber numberWithInt:arc]];
    }
    //    self.tableHeadView1.BallLabel.text  = [NSString stringWithFormat:@"%ld",self.array1.count];
    int a = arc4random_uniform(27);
    self.arrayT = [NSMutableArray array];
    [self.arrayT addObject:[NSNumber numberWithInt:a+ 100]];
    //    _label3.text  = [NSString stringWithFormat:@"%ld",self.arrayT.count];
    self.Selearray = [NSMutableArray arrayWithArray:self.array1];
    [self.Selearray addObject:[NSNumber numberWithInt:a+100]];
    [self.tableView reloadData];
    
}

// 表头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        self.tableHeadView1 = [[[NSBundle mainBundle] loadNibNamed:@"tableHeadView1" owner:nil options:nil] firstObject];
         self.tableHeadView1.BallLabel.text  = [NSString stringWithFormat:@"%ld",self.array1.count];
        [self.tableHeadView1  tableHeadView1:_model];
        return self.tableHeadView1;
    }
    if (section == 1) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, 44)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(16, view.frame.origin.y + 20, 65, 25)];
        label.text =MyLocal(@"Red ball: one,");
        label.font = [UIFont systemFontOfSize:13];
        [view addSubview:label];
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(80, view.frame.origin.y + 20, 30, 25)];
        label2.text = MyLocal(@"selected");
        label2.font = [UIFont systemFontOfSize:13];
        [view addSubview:label2];
        _label3 = [[UILabel alloc]initWithFrame:CGRectMake(110, view.frame.origin.y + 20, 10, 25)];
        _label3.text  = [NSString stringWithFormat:@"%ld",self.arrayT.count];
        [_label3 setTextColor:[UIColor redColor]];
        _label3.font = [UIFont systemFontOfSize:13];
        [view addSubview:_label3];
        UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(120, view.frame.origin.y + 20, 15, 25)];
        label4.text = MyLocal(@"a");
        label4.font = [UIFont systemFontOfSize:13];
        [view addSubview:label4];
        return view;
    }else{
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, 30)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(16, 15, 200, 30)];
        label.text = MyLocal(@"Selected number");
        label.font = [UIFont systemFontOfSize:13];
        [view addSubview:label];
        return view;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 69 / 8 * [UIScreen mainScreen].bounds.size.width/8 + 40;
    }
    if (indexPath.section == 1) {
        return 26 / 8 * [UIScreen mainScreen].bounds.size.width/8 + 40;
        
    }else{
        
        return 45;
    }
}

//  设置表头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 85.0f;
    }else{
        return 44.0f;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dicArray.count > 0) {
        return 3;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //这个+1
    if (section == 2) {
        return self.dicArray.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
     return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        BetTableViewMyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BetTableViewMyCell"];
//        NSLog(@"you go");
        cell.butArray = self.array1;
        [cell upDataButtonWith:68];
        cell.arrayBlock = ^(NSMutableArray *arr1) {
           self.tableHeadView1.BallLabel.text = [NSString stringWithFormat:@"%ld",arr1.count];
            if (self.Selearray.count > 0) {
                for (NSNumber *Nstr in self.Selearray) {
                    if ([Nstr integerValue] > 99) {
                        self.Selearray = [NSMutableArray arrayWithArray:arr1];
                        [self.Selearray addObject:Nstr];
                        break;
                    }else{
                        self.Selearray = [NSMutableArray arrayWithArray:arr1];
                    }
                }
            }else{
                self.Selearray = [NSMutableArray arrayWithArray:arr1];
            }
            if (_dicArray.count >0) {
                NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
                [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            
        };
        return cell;
    }else
     if(indexPath.section == 1) {
        NSLog(@"who go");
        BetTableViewMyCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"BetTableViewMyCell2"];
        NSLog(@"you go");
         cell.butArray = self.arrayT;
        [cell upDataButtonWith:25];
        cell.arrayBlock = ^(NSMutableArray *arr2) {
            _label3.text = [NSString stringWithFormat:@"%ld",arr2.count];
            _arrayT = arr2;
            if (arr2.count == 0) {
                [self.Selearray removeLastObject];
            }else{
                if (self.Selearray.count > 0) {
                    for (NSNumber *Nstr in self.Selearray) {
                        if ([Nstr integerValue] < 99) {
                            [self.Selearray addObject:arr2[0]];
                            break;
                        }else{
                            self.Selearray = [NSMutableArray arrayWithArray:arr2];
                        }
                    }
                }else{
                    self.Selearray = [NSMutableArray arrayWithArray:arr2];
                }
            }
            if (_dicArray.count > 0) {
                NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
                [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            
        };
        return cell;
     }else{
          _cell1 = [tableView dequeueReusableCellWithIdentifier:@"BetTableViewCellTwo" forIndexPath:indexPath];
         if (self.dicArray.count > 0) {
             

             if (indexPath.row == self.dicArray.count) {
                 [_cell1 updateCount:self.Selearray];
             }else{
                 NSMutableArray  *arr = [NSMutableArray arrayWithArray:self.dicArray[indexPath.row]];
                 _cell1.shuliangLabel.text = arr[6];
                 [arr removeObjectAtIndex:6];
                 [_cell1 updateCount:arr];
             }
         }else{
                 [_cell1 updateCount:self.Selearray];
         }
         _cell1.deleBut.tag = indexPath.row;
         _cell1.jiaBut.tag = indexPath.row;
         _cell1.jianBut.tag = indexPath.row;
         [_cell1.deleBut addTarget:self action:@selector(dele:) forControlEvents:UIControlEventTouchUpInside];
         [_cell1.jiaBut addTarget:self action:@selector(jia:) forControlEvents:UIControlEventTouchUpInside];
         [_cell1.jianBut addTarget:self action:@selector(jian:) forControlEvents:UIControlEventTouchUpInside];
        return _cell1;
    }

}
//  加
- (void)jia:(UIButton *)but {
    NSArray *arr = self.dicArray[but.tag];
    NSString *str = arr[6];

    if ([str integerValue] == 20) {
        [SVProgressHUD showInfoWithStatus:MyLocal(@"Maximum not greater than 20 notes.")];
        NSLog(@"20");
        return;
    }
    [self.dicArray[but.tag] removeObjectAtIndex:6];
    NSString *jStr = [NSString stringWithFormat:@"%d",[str integerValue] + 1];
    [self.dicArray[but.tag] addObject:jStr];
    NSIndexPath * index = [NSIndexPath indexPathForRow:but.tag inSection:2];
    [self.tableView reloadMoveToBottom];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index, nil] withRowAnimation:UITableViewRowAnimationNone];
 
}
// 减
- (void)jian:(UIButton *)but {
    NSArray *arr = self.dicArray[but.tag];
    NSString *str = arr[6];
    if ([str integerValue] == 1) {
        [SVProgressHUD showInfoWithStatus:MyLocal(@"Minimum not less than 1 note.")];
        NSLog(@"1");
        return;
    }
    [self.dicArray[but.tag] removeObjectAtIndex:6];
    
    NSString * jStr = [NSString stringWithFormat:@"%d",[str integerValue] - 1];
    [self.dicArray[but.tag] addObject:jStr];

    NSIndexPath * index = [NSIndexPath indexPathForRow:but.tag inSection:2];
    [self.tableView reloadMoveToBottom];
}

//  删除
- (void)dele:(UIButton *)but {
    if (self.dicArray.count > 0 ) {
        if (but.tag == self.dicArray.count) {
            if (self.Selearray.count > 0) {
                [self.Selearray removeLastObject];
                NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
//                [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                
                [self.tableView reloadMoveToBottom];
            }else{
                NSLog(@"没有选定 ");
                [SVProgressHUD showInfoWithStatus:MyLocal(@"There is no selected")];
            }
        }else{
            [self.dicArray removeObjectAtIndex:but.tag];
            NSIndexSet * indexSet=[[NSIndexSet alloc]initWithIndex:2];
            if (self.dicArray.count > 0) {
//                [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
            }else{
                [self.tableView reloadData];
            }
        }
    }
    
}


// 確定
- (IBAction)suijiBut:(id)sender {
    NSLog(@"everyall %@  all %@  bai %@  hong zhe%@",self.Selearray,self.dicArray,self.array1,self.arrayT);
    
    if (self.array1.count < 5) {
        //        tishi
        [SVProgressHUD showInfoWithStatus:MyLocal(@"Please select five white balls.")];
        return;
    }
    if (self.arrayT.count < 1) {
        //tishi
        [SVProgressHUD showInfoWithStatus:MyLocal(@"Please select a red ball.")];
        return;
    }
    if (self.Selearray.count< 6) {
        //
        [SVProgressHUD showInfoWithStatus:MyLocal(@"Please select five white balls and one red ball.")];
        return;
    }
    
#pragma make -- 提示框
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"reminding", nil) message:NSLocalizedString(@"Are you sure you select the group number?",nil) preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        ZPLog(@"取消");
    }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"ok",nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        //        响应事件
        if (self.Selearray.count == 6) {
            [self.Selearray addObject:@"1"];
            [self.dicArray addObject:self.Selearray];
            
            self.array1 = nil;
            self.arrayT = nil;
            self.Selearray = nil;
            [self.tableView reloadData];
        }
    }];
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

// 下注
- (IBAction)sureBut:(id)sender {
    [self AllData];
}

// 下注
- (void)AllData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"]  = Token;
    dic[@"count"] = _dicArray;
    dic[@"count"] = @"3";
    [ZP_MyTool requestBte:dic uccess:^(id obj) {
        ZPLog(@"%@",obj);
        if ([obj[@"result"]isEqualToString:@"time_err"]) {
            [SVProgressHUD showInfoWithStatus:MyLocal(@"You are not able to submit your pie.")];
        }else
            if ([obj[@"result"]isEqualToString:@"count_err"]) {
                [SVProgressHUD showInfoWithStatus:MyLocal(@"You are not able to submit your pie.")];
            }
        ZPLog(@"%@",obj);
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
}
- (NSMutableArray *)Selearray {
    if (!_Selearray) {
        _Selearray = [NSMutableArray array];
    }
    return _Selearray;
}

- (NSMutableArray *)array1 {
    if (!_array1) {
        _array1 = [NSMutableArray array];
    }
    return _array1;
}

- (NSMutableArray *)arrayT {
    if (!_arrayT) {
        _arrayT = [NSMutableArray array];
    }
    return _arrayT;
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

