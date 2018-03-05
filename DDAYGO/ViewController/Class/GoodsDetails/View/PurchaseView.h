//
//  PurchaseView.h
//  DDAYGO
//
//  Copyright © 2017年 Summer. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ChooseView.h"
#import "ChooseRank.h"
#import "ZP_GoodDetailsModel.h"

@interface PurchaseView : UIView<ChooseRankDelegate>

typedef void (^FinishBlock)(id response);
typedef void (^FinishBtnBlock)(id response);

@property(nonatomic,strong)UIView * backgroundView;

@property(nonatomic,strong)NSArray * standardList;
@property(nonatomic,strong)NSArray * standardValueList;

@property(nonatomic,strong)NSArray * standardTypeList;
@property(nonatomic,strong)NSArray * standardValueTypeList;

@property(nonatomic,strong)ChooseView * chooseView;
@property(nonatomic,strong)ChooseRank * chooseRank;

@property(nonatomic,strong)NSMutableArray * rankArray;
@property(nonatomic,strong)NSMutableArray * rankArray2;

@property (nonatomic, strong) UIButton * button;
@property (nonatomic, strong) UILabel * numLabel;
@property (nonatomic, strong) UIButton * addButton;
@property (nonatomic, strong) UIView * backView;

@property (nonatomic, copy) NSString* selectKind;
@property (nonatomic, copy) NSString* selectKind2;

@property (nonatomic, strong) NSNumber* colorId;
@property (nonatomic, strong) NSNumber* sizeId;
@property (nonatomic, strong) NSNumber* stockid;


@property (nonatomic, strong) ZP_GoodDetailsModel * model;
@property (nonatomic, strong) NSArray *modelArr;
@property (nonatomic, strong) NSArray *modeltypeArr;

@property (nonatomic , copy) FinishBtnBlock finishBtnBlock;
@property (nonatomic , copy) FinishBlock finishBlock;

- (void)show:(FinishBlock)finishBlock;

@end

