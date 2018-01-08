//
//  LanguageController.m
//  DDAYGO
//
//  Created by Summer on 2017/11/6.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "LanguageController.h"
#import "MainViewController.h"
#import "PrefixHeader.pch"
#import "NSBundle+Language.h"
#import "LanguangTableViewCell.h"
@interface LanguageController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray * TitleArray;
@property (nonatomic, strong) UITableView * tableview;
@end

@implementation LanguageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
// UI
- (void)initUI {
    self.title = NSLocalizedString(@"Language", nil);
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, ZP_height)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[LanguangTableViewCell class] forCellReuseIdentifier:@"LanguangTableViewCell"];
    self.TitleArray = [NSArray arrayWithObjects:@"English",@"简体中文",@"繁體中文", nil];
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
//- (void)changeLanguageTo:(NSString *)language {
////  设置语言
//    [NSBundle setLanguage:language];
//
////  然后将设置好的语言存储好，下次进来直接加载
//    [[NSUserDefaults standardUserDefaults] setObject:language forKey:@"Language"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//
////  我们要把系统windown的rootViewController替换掉
//    MainViewController * tab = [[MainViewController alloc] init];
//    [UIApplication sharedApplication].keyWindow.rootViewController = tab;
////  跳转到设置页
//    tab.selectedIndex = 4;
////    [self.navigationController popViewControllerAnimated:YES];
//}
////适当的位置移除通知
//- (void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.TitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LanguangTableViewCell * cell = [[LanguangTableViewCell alloc]init];
    cell.textLabel.text = self.TitleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZPLog(@"%ld",indexPath.row);
    
}
@end
