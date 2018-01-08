//
//  LanguageController.m
//  DDAYGO
//
//  Created by Summer on 2017/11/6.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "LanguageController.h"
#import "MainViewController.h"
#import "SettingViewController.h"
#import "PrefixHeader.pch"
#import "NSBundle+Language.h"

@interface LanguageController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray * TitleArray;
//@property (nonatomic, strong) UITableView * tableview;
@end

@implementation LanguageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationBar];
    [self initUI];
}
// UI
- (void)initUI {
    self.title = NSLocalizedString(@"Language", nil);
    [self.tableview registerNib:[UINib nibWithNibName:@"LanguangTableViewCell" bundle:nil] forCellReuseIdentifier:@"LanguangTableViewCell"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    //   [self.tableview registerClass:[LanguangTableViewCell class] forCellReuseIdentifier:@"LanguangTableViewCell"];
    //    self.tableview setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine;
    //    self.tableview.separatorStyle = UITableViewCellSelectionStyleNone;  // 隱藏tableviewcell所有的線條
    self.tableview.tableFooterView = [[UIView alloc]init]; // 隱藏tableviewcell多余的線條
    self.TitleArray = [NSArray arrayWithObjects:@"English",@"简体中文",@"繁體中文", nil];
}

// Nav按钮
- (void)addNavigationBar {
    __weak LanguageController  * Language = self;
    [self addNavigationBarItemWithType:LLNavigationBarItemTypeRightFirst handler:^(UIButton *button) {
        [button setTitle:NSLocalizedString(@"完成", nil) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:Language action:@selector(CompleteBut:) forControlEvents:UIControlEventTouchUpInside];
    }];
}

// 完成按钮
- (void)CompleteBut:(UIButton *)sender {

    int a = 0;
    for (int i = 0; i < self.TitleArray.count; i ++ ) {
        UITableViewCell * cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (cell.accessoryType  == 3) {
            a = i+1;
        }
    }
    if (a == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择"];
        return;
    }

    switch (a) {
        case 1:
            [self changeLanguageTo:@"en"];
            break;
        case 2:
            [self changeLanguageTo:@"zh-Hans"];
            break;
        case 3:
             [self changeLanguageTo:@"zh-Hant"];
            break;
            
        default:
            break;
    }
 
}
//- (IBAction)zhongwen:(id)sender {
//    [self changeLanguageTo:@"zh-Hans"];
//}
//- (IBAction)yinwen:(id)sender {
//    [self changeLanguageTo:@"en"];
//
//}
//- (IBAction)fantizhongwen:(id)sender {
//    [self changeLanguageTo:@"zh-Hant"];
//}

- (void)changeLanguageTo:(NSString *)language {
//  设置语言
    [NSBundle setLanguage:language];

//  然后将设置好的语言存储好，下次进来直接加载
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:@"Language"];
    [[NSUserDefaults standardUserDefaults] synchronize];

//  我们要把系统windown的rootViewController替换掉
    MainViewController * tabBar = [[MainViewController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBar;
//  跳转到设置页
    tabBar.selectedIndex = 4;

//    [self.navigationController popViewControllerAnimated:YES];
}

//适当的位置移除通知
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.TitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellid = @"ssss";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.textLabel.text = self.TitleArray[indexPath.row];
    cell.textLabel.font = ZP_TooBarFont;
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 点击cell时，让某行cell的选中状态消失
//    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
//
//}
//

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSIndexPath *oldIndex = [tableView indexPathForSelectedRow];
    
    [tableView cellForRowAtIndexPath:oldIndex].accessoryType = UITableViewCellAccessoryNone;
    
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    
    return indexPath;
    
}

@end
