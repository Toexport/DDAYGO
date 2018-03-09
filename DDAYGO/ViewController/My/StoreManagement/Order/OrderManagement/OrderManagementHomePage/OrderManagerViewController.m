//
//  OrderManagerViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/26.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "OrderManagerViewController.h"
#import "OrderManagerCollectionViewCell.h"
#import "OrderDetailViewController.h"
#import "ReturnDetailViewController.h"
#import "OrderSearchView.h"
#define ZP_Width [UIScreen mainScreen].bounds .size.width
#define ZP_height [UIScreen mainScreen].bounds .size.height
@interface OrderManagerViewController ()<UIScrollViewDelegate>
@property (nonatomic ,strong) NSArray *array;
@property (nonatomic ,strong) OrderSearchView *orderSearchView;
@end

@implementation OrderManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"訂單管理";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(search)];
    item.image = [UIImage imageWithContentsOfFile:@"nav_menu_search"];
    self.navigationItem.rightBarButtonItem = item;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    [self.collectionView registerNib:[UINib nibWithNibName:@"OrderManagerCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"OrderManagerCollectionViewCell"];
    [self.collectionView1 registerNib:[UINib nibWithNibName:@"OrderManagerCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"OrderManagerCollectionViewCell"];
    [self.collectionView2 registerNib:[UINib nibWithNibName:@"OrderManagerCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"OrderManagerCollectionViewCell"];
    [self.collectionView3 registerNib:[UINib nibWithNibName:@"OrderManagerCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"OrderManagerCollectionViewCell"];
    [self.collectionView4 registerNib:[UINib nibWithNibName:@"OrderManagerCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"OrderManagerCollectionViewCell"];
    [self.dfhBtn addTarget:self action:@selector(getOrderData:) forControlEvents:UIControlEventTouchUpInside];
    [self.dfkBtn addTarget:self action:@selector(getOrderData:) forControlEvents:UIControlEventTouchUpInside];
    [self.dhhBtn addTarget:self action:@selector(getOrderData:) forControlEvents:UIControlEventTouchUpInside];
    [self.dthBtn addTarget:self action:@selector(getOrderData:) forControlEvents:UIControlEventTouchUpInside];
    [self.yfhBtn addTarget:self action:@selector(getOrderData:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn addTarget:self action:@selector(getOrderData:) forControlEvents:UIControlEventTouchUpInside];
    //    self.dfkBtn.selected = YES;
    self.array = @[self.dfhBtn,self.dfhBtn,self.yfhBtn,self.dhhBtn,self.dthBtn];
    self.scrollView.delegate = self;
    [self updateCurrentInterface];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    self.onScrollViewWidth.constant = ZP_Width * 5;
}

- (void)search {
    if (!self.orderSearchView) {
        self.orderSearchView = [[NSBundle mainBundle] loadNibNamed:@"OrderSearchView" owner:self options:nil].lastObject;
        [self.navigationController.view addSubview:self.orderSearchView];
    }
    [self.orderSearchView show];
}

- (void)getOrderData:(UIButton *)sender {
    if (sender.tag != 105) {
        for (UIButton *button in self.array) {
            button.selected = (button == sender);
        }
        [self.scrollView setContentOffset:CGPointMake(ZP_Width * (sender.tag - 100), 0) animated:YES];
    } else {
        if (self.smallView.hidden) {
            self.smallView.hidden = NO;
            [UIView animateWithDuration:0.3f animations:^{
                self.smallView.alpha = 1;
            } completion:^(BOOL finished) {
                
            }];
        } else {
            [UIView animateWithDuration:0.3f animations:^{
                self.smallView.alpha = 0;
            } completion:^(BOOL finished) {
                self.smallView.hidden = YES;
            }];
        }
        NSLog(@"kai");
    }
}

- (void)updateCurrentInterface {
    
}

#pragma mark --- collectionView delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OrderManagerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OrderManagerCollectionViewCell" forIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 270);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 0, 10, 0);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        OrderDetailViewController *viewController = [[OrderDetailViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (indexPath.row == 1) {
        ReturnDetailViewController *viewController = [[ReturnDetailViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

#pragma mark ---scrollview delageate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"relodClassDaTa" object:nil];
    NSInteger tag = scrollView.contentOffset.x/ZP_Width;
    for (UIButton *button in self.array) {
        if (button.tag == tag) {
            button.selected = YES;
        } else {
            button.selected = NO;
        }
    }
    [self updateCurrentInterface];
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
