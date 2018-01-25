//
//  FootprintViewController.m
//  DDAYGO
//
//   Created by Login on 2017/9/7.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "FootprintViewController.h"
#import "UINavigationBar+Awesome.h"
#import "FootprintCollectionViewCell.h"
#import "PrefixHeader.pch"
#import "ZP_MyTool.h"
@interface FootprintViewController ()

@property (nonatomic, strong)NSMutableArray * newsData;
@end

@implementation FootprintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"footprint", nil);
    [self allData];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_textWite}];   // 更改导航栏字体颜色
    [self.collectionView registerNib:[UINib nibWithNibName:@"FootprintCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"FootprintCollectionViewCell"];
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//    self.collectionView.alwaysBounceVertical = YES;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
// 获取数据
- (void)allData {
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    int i = arc4random_uniform(999);  // 随机数
    dic[@"nonce"] = @(i);
    [ZP_MyTool requtsFootprint:dic success:^(id obj) {
        ZPLog(@"%@",obj);
        NSDictionary * dic = obj;
        NSArray *arr = [ZP_FootprintModel arrayWithArray:dic[@"historyslist"]];
        [arr enumerateObjectsUsingBlock:^(ZP_FootprintModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            [model.historyArray enumerateObjectsUsingBlock:^(ZP_FootprintModel1 *model1, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.newsData addObject:model1];
            }];
        }];
        
        [self.collectionView reloadData];
    } failure:^(NSError * error) {
        ZPLog(@"error");
    }];
}

//  删除按钮
- (void)deleBtn:(UIButton *)btn{
    if (self.newsData.count == 0) {
        return;
    }
    
    ZP_FootprintModel1 *model = self.newsData[btn.tag];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"token"] = Token;
    dic[@"historyid"] = model.historyid;
    [ZP_MyTool requtsDeleFootprint:dic success:^(id obj) {
        NSLog(@"dele %@",obj);
        [self.newsData removeObjectAtIndex:btn.tag];
        if ([obj[@"result"]isEqualToString:@"ok"]) {
            [SVProgressHUD showSuccessWithStatus:@"刪除成功"];
        }else {
            if ([obj[@"result"]isEqualToString:@"failure"]) {
                [SVProgressHUD showInfoWithStatus:@"刪除失敗"];
            }
        }
        [self.collectionView reloadData];
    } failure:^(NSError * error) {
        NSLog(@"dele %@",error);
    }];
}
#pragma mark --- collectionView delegate


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.newsData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZP_FootprintModel1 *model = self.newsData[indexPath.row];
    FootprintCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FootprintCollectionViewCell" forIndexPath:indexPath];
    cell.deleBtn.tag = indexPath.row;
    [cell.deleBtn addTarget:self action:@selector(deleBtn:) forControlEvents:UIControlEventTouchUpInside];
//    ZP_FootprintModel1 *model1 = model.historyArray[0];
    [cell FootprintCollection:model];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width=(self.view.frame.size.width-55)/3;
    return CGSizeMake(width, width *137 / 110);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 15, 10, 15);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

- (NSMutableArray *)newsData {
    
    if (!_newsData) {
        _newsData = [NSMutableArray array];
    }
    return _newsData;
}

@end

