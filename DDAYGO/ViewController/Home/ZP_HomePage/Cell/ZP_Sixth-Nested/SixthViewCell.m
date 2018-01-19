//
//  SixthViewCell.m
//  DDAYGO
//
//  Created by Login on 2017/9/13.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "SixthViewCell.h"
#import "PrefixHeader.pch"
#import "NestedCollectionViewCell.h"
//#import "ZP_HomeTool.h"
#import "ZP_HttpConst.h"
#import "ZP_SixthModel.h"
@interface SixthViewCell () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *bottomCV;
@property (nonatomic, strong) NSArray * array;
//@property (nonatomic, strong) NSMutableArray * newsData;

@end
@implementation SixthViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:@"Fifthcell"];
    if (self) {
        
        [self addSubVIEWs];
        [self initUI];
    }
    return self;
}

- (void)addSubVIEWs {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc ]init];
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionView * bottomCV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 35, ZP_Width, ZP_Width / 3 * 2) collectionViewLayout:layout];
    bottomCV.backgroundColor = [UIColor whiteColor];
    bottomCV.scrollEnabled = NO;
    bottomCV.delegate = self;
    bottomCV.dataSource = self;
    [self addSubview:bottomCV];
    self.bottomCV = bottomCV;
    [bottomCV registerClass:[NestedCollectionViewCell class] forCellWithReuseIdentifier:@"Nestedcell"];
}


- (void)initUI {
    
//  标题
    UILabel * titleLabel = [UILabel new];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setTextColor:ZP_Graybackground];
    titleLabel.textColor = ZP_textblack;
    titleLabel.text = NSLocalizedString(@"erchandise", nil);
    titleLabel.font = ZP_TooBarFont;
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.equalTo(self).offset(7);
    }];
    
//  更多
    UIButton * moreBut = [UIButton new];
    [moreBut setTitle:NSLocalizedString(@"More erchandise", nil) forState:UIControlStateNormal];
    moreBut.titleLabel.font = ZP_titleFont;
    [moreBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    moreBut.backgroundColor = [UIColor orangeColor];
    moreBut.layer.cornerRadius = 5.0;// 按钮圆角弧度
    [self.contentView addSubview:moreBut];
    [moreBut addTarget:self action:@selector(moreBut:) forControlEvents:UIControlEventTouchUpInside];
    [moreBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self).offset(7);
        make.width.mas_offset(60);
        make.height.mas_offset(15);
    }];
    
//  分割线
    UIView * view1 = [UIView new];
    view1.backgroundColor = ZP_Graybackground;
    [self.contentView addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(33);
        make.left.equalTo(self).offset(0);
        make.width.mas_equalTo(ZP_Width);
        make.height.mas_equalTo(1);
    }];
    
}

// 更多精选
- (void)moreBut:(UIButton *)sender {
    
    NSLog(@"更多...");
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.ArrData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NestedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Nestedcell" forIndexPath:indexPath];
    ZP_SixthModel * model = self.ArrData[indexPath.row];
    [cell cellWithdic:model];
    return cell;
}
//  cell 点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.ThirdBlock) {
        ZP_SixthModel *model = self.ArrData[indexPath.row];
        self.ThirdBlock([model.productid longValue]);
    }
    NSLog(@"选中%ld",(long)indexPath.item);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.ArrData.count < 1) {
        return CGSizeMake(CGFLOAT_MIN, CGFLOAT_MIN);
    }
    return CGSizeMake(ZP_Width/3-1, ZP_Width / 3);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    return CGSizeMake(CGFLOAT_MIN, CGFLOAT_MIN);;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(CGFLOAT_MIN, CGFLOAT_MIN);
}

@end
