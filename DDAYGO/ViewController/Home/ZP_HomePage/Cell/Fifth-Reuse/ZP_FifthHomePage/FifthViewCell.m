//
//  FifthViewCell.m
//  DDAYGO
//
//  Created by Login on 2017/9/12.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "FifthViewCell.h"
#import "PrefixHeader.pch"
#import "ReuseCollectionViewCell.h"
#import "UINavigationBar+Awesome.h"
#import "ZP_HomeTool.h"
#import "ZP_FifthModel.h"

@interface FifthViewCell () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionView * bottomCV;
@property (nonatomic, strong) NSArray * array;
//@property (nonatomic, strong)NSMutableArray * newsData;

@end
@implementation FifthViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:@"ceaaa"];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)setArrData:(NSArray *)arrData {
    _arrData = arrData;
    [self.bottomCV reloadData];
}

- (void)addSubViews {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc ]init];
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;  //横向滚动 默认上下
    _bottomCV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, ZP_Width / 4 + 35) collectionViewLayout:layout];
//    _bottomCV.backgroundColor = [UIColor yellowColor];
    _bottomCV.backgroundColor = [UIColor whiteColor];
    _bottomCV.delegate = self;
    _bottomCV.dataSource = self;
    [self addSubview:_bottomCV];
    self.bottomCV = _bottomCV;
    [_bottomCV registerClass:[ReuseCollectionViewCell class] forCellWithReuseIdentifier:@"Cells"];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ReuseCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cells" forIndexPath:indexPath];
    ZP_FifthModel * model = self.arrData[indexPath.row ];
    [cell cellWithdic:model];
    return cell;
} 

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",indexPath.row);
    if (self.ThirdBlock) {
        ZP_FifthModel * model = self.arrData[indexPath.row];
        self.ThirdBlock([model.producid longValue]);
        
    }
    NSLog(@"选中%ld",(long)indexPath.item);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(ZP_Width/4-1, ZP_Width / 4 + 35);
}


@end
