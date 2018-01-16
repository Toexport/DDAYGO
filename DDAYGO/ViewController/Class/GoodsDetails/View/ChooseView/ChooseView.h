//
//  ChooseView.h
//  LvjFarm
//
//  Created by 张仁昊 on 16/4/14.
//  Copyright © 2016年 _____ZXHY_____. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseView : UIView


@property(nonatomic,strong)UIView * alphaView;//   半透明视图
@property(nonatomic,strong)UIView * whiteView;//   装载商品信息的视图

@property(nonatomic,strong)UIImageView * headImage;//   商品图片

@property(nonatomic,strong)UILabel * LB_price;//   商品价格
@property (nonatomic, strong)UIImageView * CPImageview; // CP图片
@property (nonatomic, strong)UILabel * LB_CPLabel;  // CP编号
@property(nonatomic,strong)UILabel * LB_stock;//   商品库存
@property(nonatomic,strong)UILabel * LB_detail;//   用户所选择商品的尺码和颜色
@property(nonatomic,strong)UILabel * LB_line;//   分界线
@property(nonatomic,strong)UILabel * LB_showSales;//   已售件数


@property(nonatomic,copy)NSString * price;
@property(nonatomic,copy)NSString * stock;
@property(nonatomic,copy)NSString * detail;
@property(nonatomic,copy)NSString * showSales;

@property(nonatomic,strong)UIScrollView * mainscrollview;//   有的商品尺码和颜色分类特别多 所以用UIScrollView 分类过多显示不全的时候可滑动查看


@property(nonatomic,strong)UIButton * cancelBtn;
@property(nonatomic,strong)UIButton * buyBtn;//   立即购买按钮
@property(nonatomic,strong)UIButton * addBtn;//   加入购物车按钮
@property(nonatomic,strong)UIButton * stockBtn;//   库存不足按钮

@property(nonatomic,assign) int typeCount;

@property(nonatomic,strong)UIButton * selectBtn;


-(instancetype)initWithFrame:(CGRect)frame;


@end



