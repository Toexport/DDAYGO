//
//  SelectView.m
//  DDAYGO
//
//  Created by Summer on 2018/1/12.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import "SelectView.h"
#import "PrefixHeader.pch"
#import "SelectModel.h"
#import "SelectViewCell.h"
#import "UIImageView+WebCache.h"
#define kATTR_VIEW_HEIGHT (kHeight-215)

///******* 屏幕尺寸 *******/
#define     kWidth      [UIScreen mainScreen].bounds.size.width - 30
#define     kHeight     [UIScreen mainScreen].bounds.size.height - 50

@interface SelectView () <UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) UIView * contentView;
@property (nonatomic, strong) UIButton * Creditcardbut;
@property (nonatomic, strong) UIButton * ICUEbut;
@property (nonatomic, strong) UIView * view;


@end
@implementation SelectView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

#pragma mark - setupViews
/**
 *  设置视图的基本内容
 */
- (void)setupViews {
    //  添加手势，点击背景视图消失
    UIView * bounceView = [UIView new];
    bounceView.backgroundColor = [UIColor whiteColor];
    bounceView.layer.cornerRadius = 5.0;// View圆角弧度
    [self addSubview:bounceView];
    self.contentView = bounceView;
    [bounceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(200);
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.width.mas_offset(ZP_Width);
    }];
    //  取消按钮
    UIButton * Cancelbut = [UIButton buttonWithType:UIButtonTypeCustom];
    [Cancelbut setImage:[UIImage imageNamed:@"ic_payment_cancel"] forState:UIControlStateNormal];
    [Cancelbut addTarget:self action:@selector(cancelbut:) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tapBackGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
    tapBackGesture.delegate = self;
    [self addGestureRecognizer:tapBackGesture];
    [bounceView addSubview:Cancelbut];
    [Cancelbut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bounceView).offset(10);
        make.top.equalTo(bounceView).offset(10);
    }];
    //  标题
    UILabel * titleLabel = [UILabel new];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textColor = ZP_textblack;
    titleLabel.text = NSLocalizedString(@"选择原因", nil);
    titleLabel.numberOfLines = 0;
    titleLabel.font = ZP_addBtnTextdetaFont;
    [bounceView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(215); // 上面
        make.left.equalTo(self).offset(ZP_Width / 2  - 30); // 左边
        //        make.width.mas_offset(80);
        //        make.height.mas_offset(20);
    }];
    
    for (int z = 0; z <= 3; z ++) {
        for (int i = 0; i <=2; i ++) {
            for (int x = z; x <=1; x ++) {
                self.view = [[UIView alloc]initWithFrame:CGRectMake(i * ZP_Width, z *  50+ 50 + x * 150, ZP_Width , 1)];
                [self.view setBackgroundColor:ZP_DeepBlue];
                [bounceView addSubview:self.view];
            }
        }
    }
    //  信用卡支付
    UILabel * CreditcardLabel = [UILabel new];
    CreditcardLabel.textColor = [UIColor blackColor];
    CreditcardLabel.textColor = ZP_textblack;
    CreditcardLabel.text = NSLocalizedString(@" 不想要了", nil);
    CreditcardLabel.font = ZP_addBtnTextdetaFont;
    [bounceView addSubview:CreditcardLabel];
    [CreditcardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bounceView).offset(8);
        make.top.equalTo(bounceView).offset(60);
    }];
    
    //  信用卡选择按钮
    UIButton * Creditcardbut = [UIButton new];
    [Creditcardbut setImage:[UIImage imageNamed:@"icon_payment_selected_pressed"] forState:UIControlStateNormal];
    [Creditcardbut setImage:[UIImage imageNamed:@"icon_payment_selected_normal"] forState:UIControlStateSelected];
    [Creditcardbut addTarget:self action:@selector(creditcardbut:) forControlEvents:UIControlEventTouchUpInside];
    Creditcardbut.layer.masksToBounds = YES;
    Creditcardbut.layer.cornerRadius = Creditcardbut.frame.size.height / 2;
    Creditcardbut.layer.borderColor = [UIColor clearColor].CGColor;
    Creditcardbut.layer.borderWidth = 1;
    [Creditcardbut setTitleColor:ZP_TypefaceColor forState:UIControlStateNormal];
    [bounceView addSubview:Creditcardbut];
    _Creditcardbut = Creditcardbut;
    [Creditcardbut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bounceView).offset(-15);
        make.top.equalTo(bounceView).offset(60);
    }];
    
    //  ICUE支付
    UILabel * ICUELabel = [UILabel new];
    ICUELabel.textColor = [UIColor blackColor];
    ICUELabel.textColor = ZP_textblack;
    ICUELabel.text = NSLocalizedString(@"ICUE支付", nil);
    ICUELabel.font = ZP_addBtnTextdetaFont;
    [bounceView addSubview:ICUELabel];
    [ICUELabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bounceView).offset(8);
        make.top.equalTo(CreditcardLabel).offset(30);
    }];
    
    //  ICUE选择按钮
    UIButton * ICUEbut = [UIButton new];
    [ICUEbut setImage:[UIImage imageNamed:@"icon_payment_selected_normal"] forState:UIControlStateNormal];
    [ICUEbut setImage:[UIImage imageNamed:@"icon_payment_selected_pressed"] forState:UIControlStateSelected];
    [ICUEbut addTarget:self action:@selector(iCUEbut:) forControlEvents:UIControlEventTouchUpInside];
    ICUEbut.layer.masksToBounds = YES;
    ICUEbut.layer.cornerRadius = ICUEbut.frame.size.height / 2;
    ICUEbut.layer.borderColor = [UIColor clearColor].CGColor;
    ICUEbut.layer.borderWidth = 1;
    [ICUEbut setTitleColor:ZP_TypefaceColor forState:UIControlStateNormal];
    _ICUEbut = ICUEbut;
    [bounceView addSubview:ICUEbut];
    [ICUEbut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bounceView).offset(-15);
        make.top.equalTo(ICUELabel).offset(0);
    }];
    
    //  关闭按钮
    UIButton * Paybut = [UIButton new];
    Paybut.titleLabel.font = ZP_TooBarFont;
    Paybut.layer.borderColor = [UIColor clearColor].CGColor;
    Paybut.backgroundColor = ZP_PayColor;
    Paybut.layer.cornerRadius = 5.0;// 圆角弧度
    [Paybut setTitle:NSLocalizedString(@"关闭", nil) forState:UIControlStateNormal];
    [Paybut addTarget:self action:@selector(paybut:) forControlEvents:UIControlEventTouchUpInside];
    [bounceView addSubview:Paybut];
    [Paybut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self).offset(-25);
        make.height.mas_offset(40);
    }];
}
#pragma mark - 按钮选择
//  信用卡选择按钮
- (void)creditcardbut:(UIButton *)sender {
    sender.selected = !sender.selected;
    _Creditcardbut.selected = NO;
    if (_Creditcardbut == sender) {
        _ICUEbut.selected = NO;
    }
    NSLog(@"选中信用卡");
}

//  ICUE 按钮选择
- (void)iCUEbut:(UIButton *)sender {
    _ICUEbut.selected = YES;
    if (_ICUEbut == sender) {
        _Creditcardbut.selected = YES;
    }
    NSLog(@"选中IUCE");
}

#pragma mark - 点击支付按钮
- (void)paybut:(UIButton *)sender {
//    if (_Creditcardbut.selected == 0) {
//        PayPassController * paypass = [[PayPassController alloc] init];
//        if (self.confirmPayBlock) {
//            self.confirmPayBlock(paypass);
//        }
//
//        NSLog(@"111");
//    }else if (_ICUEbut.selected == 1) {
//
//        PayFailController * PayFail = [[PayFailController alloc] init];
//        if (self.PayFailBlock) {
//            self.PayFailBlock(PayFail);
//        }
//
//        NSLog(@"222");
//    }
    
}
#pragma mark - 点击事件
- (void)cancelbut:(UIButton * )sup {
    
    __weak typeof(self) _weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        _weakSelf.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [_weakSelf removeFromSuperview];
    }];
}

#pragma mark - UIGestureRecognizerDelegate
//  确定点击范围
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isDescendantOfView:self.contentView]) {
        return NO;
    }
    return YES;
}

#pragma mark - public
/**
 *  显示属性选择视图
 *
 *  @param view 要在哪个视图中显示
 */
- (void)showInView:(UIView *)view {
    [view addSubview:self];
    __weak typeof(self) _weakSelf = self;
    self.contentView.frame = CGRectMake(15, kHeight, kWidth, kATTR_VIEW_HEIGHT);;
    
    [UIView animateWithDuration:0.3 animations:^{
        _weakSelf.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _weakSelf.contentView.frame = CGRectMake(15, kHeight - kATTR_VIEW_HEIGHT, kWidth, kATTR_VIEW_HEIGHT);
    }];
}

/**
 *  属性视图的消失
 */
- (void)removeView {
    __weak typeof(self) _weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        _weakSelf.backgroundColor = [UIColor clearColor];
        _weakSelf.contentView.frame = CGRectMake(15, kHeight, kWidth, kATTR_VIEW_HEIGHT);
    } completion:^(BOOL finished) {
        [_weakSelf removeFromSuperview];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectModel * model = _dataArray[indexPath.row];
    SelectViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SelectViewCell"];
    cell.SelectLabel.text = model.reasonstr;
    [cell.SelectBut addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)btnClick:(UIButton *)btn {
    if (!btn.selected) {
        btn.selected = !btn.selected;
        if (btn.selected) {
            for (int i = 0; i < self.dataArray.count; i ++) {
                SelectViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                if (i == btn.tag) {}
                else{cell.SelectBut.selected = NO;}
            }
        }
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 165, ZP_Width, self.contentView.frame.size.height - 165 - 60) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"SelectViewCell" bundle:nil] forCellReuseIdentifier:@"SelectViewCell"];
    }
    return _tableView;
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [_tableView reloadData];
    
    NSLog(@"%ld",(unsigned long)self.dataArray.count);
}
@end
