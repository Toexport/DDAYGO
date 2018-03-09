//
//  BillViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/28.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "BillViewController.h"
#import "BillTableViewCell.h"
#import "OrderSearchView.h"
#import "UINavigationBar+Awesome.h"
#import "UIView+Additions.h"
#import "BillDetailViewController.h"
#import "SearchTimeViewController.h"

@interface BillViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) OrderSearchView *orderSearchView;
@property (weak, nonatomic) IBOutlet UIView *categoriesView;
@property (weak, nonatomic) IBOutlet UIView *categoriesBGView;
@property (weak, nonatomic) IBOutlet UIView *categoriesSmailView;
@end

@implementation BillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"賬單";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(search)];
    //    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic_menu_search@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(search)];
    self.navigationItem.rightBarButtonItem = item;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    [self.tableView registerNib:[UINib nibWithNibName:@"BillTableViewCell" bundle:nil] forCellReuseIdentifier:@"BillTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor orangeColor]];
}

- (void)search {
    if (!self.orderSearchView) {
        self.orderSearchView = [[NSBundle mainBundle] loadNibNamed:@"OrderSearchView" owner:self options:nil].lastObject;
        [self.navigationController.view addSubview:self.orderSearchView];
    }
    [self.orderSearchView show];
}

- (IBAction)allCategoriesAction:(UIButton *)sender {
    if (sender.selected) {
        [UIView animateWithDuration:0.3f animations:^{
            self.categoriesBGView.alpha = 0;
            self.categoriesSmailView.originY = -150;
        } completion:^(BOOL finished) {
            self.categoriesView.hidden = YES;
        }];
    } else {
        self.categoriesView.hidden = NO;
        self.categoriesBGView.alpha = 0;
        self.categoriesSmailView.originY = -150;
        [UIView animateWithDuration:0.3f animations:^{
            self.categoriesSmailView.originY = 0;
            self.categoriesBGView.alpha = 0.5;
        } completion:^(BOOL finished) {
            
        }];
    }
    
    sender.selected = !sender.selected;
}

- (IBAction)billTimeAction:(UIButton *)sender {
    SearchTimeViewController *viewController = [[SearchTimeViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark ---tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BillTableViewCell"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    BillDetailViewController *viewController = [[BillDetailViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
