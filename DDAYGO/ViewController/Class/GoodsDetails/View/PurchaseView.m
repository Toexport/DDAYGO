//
//  PurchaseView.m
//  DDAYGO
//
//  Copyright © 2017年 Summer. All rights reserved.
//
#import "PurchaseView.h"
#import "PrefixHeader.pch"
#import "ZP_ClassViewTool.h"
#import "ConfirmViewController.h"
#define screen_Width [UIScreen mainScreen].bounds.size.width
#define screen_Height [UIScreen mainScreen].bounds.size.height
@implementation PurchaseView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:self.backgroundView];
    self.userInteractionEnabled = YES;
    self.backgroundView.userInteractionEnabled = YES;
    self.backgroundView.backgroundColor = [UIColor blackColor];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    self.backgroundView.userInteractionEnabled = YES;
    [self.backgroundView addGestureRecognizer:tap];
//    self.standardTypeList = @[NSLocalizedString(@"", nil),NSLocalizedString(@"購買數量", nil)];
// 商品价格
    self.chooseView = [[ChooseView alloc] initWithFrame:CGRectMake(0, screen_Height, screen_Width, screen_Height)];
    self.chooseView.headImage.image = [UIImage imageNamed:@"bingli"];
    self.chooseView.LB_stock.text = [NSString stringWithFormat:NSLocalizedString(@"Inventory:%@a", nil),@100];
    self.chooseView.LB_detail.text = nil;
    [self addSubview:self.chooseView];
    //    [self initChooseView];
    self.hidden = YES;
}

- (void)show:(FinishBlock)finishBlock {
    self.finishBlock = finishBlock;
    [self chooseViewClick];
}

-(void)initChooseView{
    CGFloat maxY = 0;
    CGFloat height = 0;
    for (int i = 0; i < self.standardValueList.count; i ++) {
        self.chooseRank = [[ChooseRank alloc] initWithTitle:self.standardList[i] titleArr:self.standardValueList[i] andFrame:CGRectMake(0, maxY, screen_Width, 40)];
        maxY = CGRectGetMaxY(self.chooseRank.frame);
        height += self.chooseRank.height;
        self.chooseRank.tag = 8000+i;
        self.chooseRank.delegate = self;
        
        [self.chooseView.mainscrollview addSubview:self.chooseRank];
    }
    self.chooseView.mainscrollview.contentSize = CGSizeMake(0, height);
    
    maxY = maxY - 30;
    for (int i = 0; i < self.standardValueTypeList.count; i ++) {
        self.chooseRank = [[ChooseRank alloc] initWithTitle:self.standardTypeList[i] titleArr:self.standardValueTypeList[i] andFrame:CGRectMake(0, maxY, screen_Width, 40)];
        maxY = CGRectGetMaxY(self.chooseRank.frame);
        height += self.chooseRank.height;
        self.chooseRank.tag = 9000+i;
        self.chooseRank.delegate = self;
        [self.chooseView.mainscrollview addSubview:self.chooseRank];
    }
    self.chooseView.mainscrollview.contentSize = CGSizeMake(0, height);
    
    //  加入购物车按钮
    [self.chooseView.addBtn addTarget:self action:@selector(addGoodsCartBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //  立即购买
    [self.chooseView.buyBtn addTarget:self action:@selector(immedPayBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //  取消按钮
    [self.chooseView.cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    //  点击黑色透明视图choseView会消失
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.chooseView.alphaView addGestureRecognizer:tap];
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(20, height-30, 100, 20)];
    backView.layer.borderWidth = 1;
    backView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    [self.chooseView.mainscrollview addSubview:backView];
    
    _backView = backView;
    //  减少
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 20, 20);
    [button setImage:[UIImage imageNamed:@"ic_shopping_less"] forState:UIControlStateNormal];
    button.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    button.layer.borderWidth = 1;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:button];
    _button = button;
    
    //  个数
    UILabel * numLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 20)];
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.textColor = [UIColor blackColor];
    numLabel.text = @"1";
    numLabel.font = ZP_TooBarFont;
    [backView addSubview:numLabel];
    _numLabel = numLabel;
    //  添加
    UIButton * addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(80, 0, 20, 20);
    [addButton setImage:[UIImage imageNamed:@"ic_shopping_add"] forState:UIControlStateNormal];
    addButton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    addButton.layer.borderWidth = 1;
    [addButton addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:addButton];
    _addButton = addButton;
}

- (void)buttonClick:(UIButton *)sender {
//    if (_numLabel.text.integerValue) {
//        _numLabel.text = [NSString stringWithFormat:@"%ld",_numLabel.text.integerValue - 1];
//    }
    if ([_numLabel.text integerValue] <= 1) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"purchase quantity cannot be less than 1", nil)];
        _numLabel.text = @"1";
        return;
    }else {
        _numLabel.text = [NSString stringWithFormat:@"%ld",[_numLabel.text integerValue]-1];
//        self.btnClickBlock(_numLabel.text);
    }
}

- (void)addClick:(UIButton *)sender {
    if (_model.productamount.integerValue <= [_numLabel.text integerValue]) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"purchase quantity should not be greater than the inventory", nil)];
        return;
    }else {
        _numLabel.text = [NSString stringWithFormat:@"%ld",[_numLabel.text integerValue]+1];
//        self.btnClickBlock(_numLabel.text);
    }
}
        
#pragma mark - - - -立即购买
- (void)immedPayBtnClick{
    if (_model.productamount.integerValue <= 0) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Insufficient inventory", nil)];
        return;
    }else {
    NSLog(@"im go pay");
    if ( _modelArr.count > 0) {
        int a = 0;
        for (int i=0; i < _standardList.count; i++) {
            ChooseRank * view = [self viewWithTag:8000+i];
            for (UIButton * obj in  view.btnView.subviews) {
                if(obj.selected){
                    a++;
                }else{
                }
            }
        }
        if (a > 0) {
            NSLog(@"规格有选中");
//            [SVProgressHUD showErrorWithStatus:@"规格没有选中"];
        }else{
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"specification no selected", nil)];
            NSLog(@"规格没有选中");
            
            return;
        }
        
    }
    
    NSLog(@"%ld",_standardTypeList.count);
    if (_modeltypeArr.count > 0) {
        int b = 0;
        for (int i=0; i < _standardTypeList.count; i++) {
            ChooseRank *view = [self viewWithTag:9000+i];
            for (UIButton *obj in  view.btnView.subviews) {
                if(obj.selected){
                    b++;
                }else{
                }
            }
            
        }
        if (b > 0) {
            NSLog(@"尺寸有选中");
//            [SVProgressHUD showErrorWithStatus:@"规格没有选中"];
        }else{
            //提示语
            NSLog(@"尺寸没有选中");
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"size No selection", nil)];
            return;
        }
        
    }
    if (_numLabel.text.intValue > 0 ) {
        ConfirmViewController * Confirm = [[ConfirmViewController alloc]init];
        Confirm.stockidsString = [NSString stringWithFormat:@"%d_%@",self.stockid.intValue,_numLabel.text];
        if (self.finishBtnBlock) {
            self.finishBtnBlock(Confirm);
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:@"Confirm" object:nil];
    }else {
        NSLog(@"没有选择数量");
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"number NO choices", nil)];
    }
}
}
#pragma mark - - - - 加入购物车
-(void)addGoodsCartBtnClick {
    NSLog(@"add cart");
    if (_model.productamount.integerValue <= 0) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Insufficient inventory", nil)];
        return;
    }else {
    if ( _modelArr.count > 0) {
        int a = 0;
        for (int i=0; i < _standardList.count; i++) {
            ChooseRank *view = [self viewWithTag:8000+i];
            for (UIButton *obj in  view.btnView.subviews) {
                if(obj.selected){
                    a++;
                }else{
                }
            }
        }
        if (a > 0) {
            NSLog(@"规格有选中");
        }else{
            NSLog(@"规格没有选中");
            
            return;
        }
    }
    
    NSLog(@"%ld",_standardTypeList.count);
    if (_modeltypeArr.count > 0) {
        int b = 0;
        for (int i=0; i < _standardTypeList.count; i++) {
            ChooseRank *view = [self viewWithTag:9000+i];
            for (UIButton *obj in  view.btnView.subviews) {
                if(obj.selected){
                    b++;
                }else{
                }
            }
            
        }
        if (b > 0) {
            NSLog(@"尺寸有选中");
        }else{
            //提示语
            NSLog(@"尺寸没有选中");
            return;
        }
        
    }
    if (_numLabel.text.intValue > 0 ) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"amount"] = self.numLabel.text;
        dic[@"stockid"] = self.stockid;
        dic[@"token"] = Token;
        [ZP_ClassViewTool requAddToCart:dic success:^(id obj) {
            if ([obj[@"result"] isEqualToString:@"ok"]) {
                [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Add success", nil)];
            } else {
                [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Add failure", nil)];
            }
        } failure:^(NSError *error) {
            
        }];
        [self dismiss];}
    else{
        NSLog(@"没有选择数量");
    }
}
}
#pragma mark --立即购买
-(void)chooseViewClick{
    //    NSLog(@"--------");
    self.hidden = NO;
    self.backgroundView.alpha = 0;
    self.chooseView.alpha = 1;
    self.chooseView.frame =CGRectMake(0, screen_Height, screen_Width, screen_Height);
    [UIView animateWithDuration:.3f animations:^{
        self.backgroundView.alpha = 0.5;
        self.chooseView.frame =CGRectMake(0, 0, screen_Width, screen_Height);
    } completion:^(BOOL finished) {
    }];
}

/**
 *  点击半透明部分或者取消按钮，弹出视图消失
 */
-(void)dismiss {
    [UIView animateWithDuration:.3f animations:^{
        self.backgroundView.alpha = 0;
        self.chooseView.frame =CGRectMake(0, screen_Height, screen_Width, screen_Height);
    } completion:^(BOOL finished) {
        self.hidden = YES;
        if (self.finishBlock) {
            if(self.selectKind && self.numLabel.text.integerValue && self.selectKind2){
                
                self.finishBlock([NSString stringWithFormat:@"  %@",[self.selectKind stringByAppendingFormat:@"+%@+%@件",self.selectKind2,self.numLabel.text]]);
            }
            else if (self.selectKind && self.numLabel.text.integerValue) {
                self.finishBlock([NSString stringWithFormat:@"  %@",[self.selectKind stringByAppendingFormat:@"+%@件",self.numLabel.text]]);
            }
            else {
                self.finishBlock(NSLocalizedString(@"Select category/specification", nil));
            }
            
        }
    }];
    
}

-(NSMutableArray *)rankArray {
    
    if (_rankArray == nil) {
        
        _rankArray = [[NSMutableArray alloc] init];
    }
    return _rankArray;
}

-(NSMutableArray *)rankArray2 {
    
    if (_rankArray2 == nil) {
        
        _rankArray2 = [[NSMutableArray alloc] init];
    }
    return _rankArray2;
}

-(void)selectBtnTitle:(NSString *)title andBtn:(UIButton *)btn{
    ZPLog(@"%ld",btn.tag);
    ZPLog(@"%@ - %@",title,btn.titleLabel.text);
    [self.rankArray removeAllObjects];
    [self.rankArray2 removeAllObjects];
    
    for (int i=0; i < _standardList.count; i++) {
        ChooseRank *view = [self viewWithTag:8000+i];
        
        for (UIButton *obj in  view.btnView.subviews) {
            if(obj.selected) {
                
                for (NSArray *arr in self.standardValueList) {
                    for (NSString *title in arr) {
                        
                        if ([view.selectBtn.titleLabel.text isEqualToString:title]) {
                            
                            [self.rankArray addObject:view.selectBtn.titleLabel.text];
                            
                            [_modelArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                ZP_GoodDetailsModel *model = obj;
                                if ([model.cnname isEqualToString:title]) {
                                    self.selectKind = title;
                                    self.colorId = model.cnid;
                                    [self.chooseView.headImage sd_setImageWithURL:[NSURL URLWithString:model.cnimg] placeholderImage:[UIImage imageNamed:@"bingli"]];
                                }
                            }];
                        }
                    }
                }
            }
        }
    }
    for (int i=0; i < _standardTypeList.count; i++) {
        ChooseRank *view = [self viewWithTag:9000+i];
        
        for (UIButton *obj in  view.btnView.subviews) {
            if(obj.selected) {
                
                for (NSArray *arr in self.standardValueTypeList) {
                    for (NSString *title in arr) {
                        
                        if ([view.selectBtn.titleLabel.text isEqualToString:title]) {
                            
                            [self.rankArray2 addObject:view.selectBtn.titleLabel.text];
                            
                            [_modeltypeArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                ZP_GoodDetailsModel * model = obj;
                                if ([model.cnname isEqualToString:title]) {
                                    self.selectKind2 = title;
                                    self.sizeId = model.cnid;
                                }
                            }];
                        }
                    }
                }
            }
        }
    }
    
    [self getdata];
}

- (void)getdata {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (self.colorId) {
        dic[@"colorid"] = self.colorId;
    }else{
        dic[@"colorid"] = @" ";
    }
    
    if (self.sizeId) {
        dic[@"normid"] = self.sizeId;
    }else{
        dic[@"normid"] = @" ";
    }
    
    [ZP_ClassViewTool requColorOrSize:dic success:^(id json) {
        
        NSNumber *value = [json objectForKey:@"stockid"];
        if ((NSNull *)value == [NSNull null]) {
            NSLog(@"没有");
        }else{
            NSLog(@"stockid = %@",value);
            self.stockid = value;
        }
        ZPLog(@"go-%@",json);
    } failure:^(NSError *error) {
        
    }];
}

- (void)setModel:(ZP_GoodDetailsModel *)model {
    _model = model;
    self.chooseView.LB_price.text = model.productprice;
    self.chooseView.LB_CPLabel.text = model.TrademarkLabel;
    self.chooseView.LB_stock.text = [NSString stringWithFormat:@"Inventory:%@a",model.productamount];
    [self.chooseView.headImage sd_setImageWithURL:[NSURL URLWithString:model.defaultimg] placeholderImage:[UIImage imageNamed:@"bingli"]];
    NSLog(@"_____%@",model.productid);
    self.stockid = [NSNumber numberWithInt:[model.productid intValue]];
    //    _ShopNameLabel.text = model.productname;
    //    _ShopMoneyLabel.text = model.productprice;
    //    _quantityLable.text = model.quantity;
    //    _peramountLable.text = model.peramount;
    //    _productidLable.text = model.productid;
}

- (void)setModelArr:(NSArray *)modelArr {
    _modelArr = modelArr;
    NSMutableArray  *arr = [NSMutableArray array];
    for (int i = 0; i < modelArr.count; i ++) {
        ZP_GoodDetailsModel *model = modelArr[i];
        [arr addObject:model.cnname];
        if (0 == i) {
            self.colorId = model.cnid;
        }
        NSLog(@"_%@",model.productid);
    }
    
    if (arr.count == 0) {
        self.standardValueList = nil;
        self.standardTypeList = @[@"",NSLocalizedString(@"Purchase quantity", nil)];
    } else {
        self.standardValueList = @[arr,@[]];
        self.standardTypeList = @[NSLocalizedString(@"Product specifications", nil),NSLocalizedString(@"Purchase quantity", nil)];
    }
    if (self.standardTypeList.count == 0 && self.standardList.count == 0) {
        
    } else {
        [self initChooseView];
    }
}

- (void)setModeltypeArr:(NSArray *)modeltypeArr {
    _modeltypeArr = modeltypeArr;
    NSMutableArray  *arr = [NSMutableArray array];
    for (int i = 0; i < modeltypeArr.count; i ++) {
        ZP_GoodDetailsModel *model = modeltypeArr[i];
        NSLog(@"__%@",model.productid);
        [arr addObject:model.cnname];
        if (0 == i) {
            self.sizeId = model.cnid;
        }
    }
    
    self.standardValueTypeList = @[arr,@[]];
    if (arr.count == 0) {
        self.standardList = @[@"",@""];
    } else {
        self.standardList = @[NSLocalizedString(@"Commodity type", nil),NSLocalizedString(@"", nil)];
    }
    //    [self initChooseView];
}
@end

