//
//  BetViewController.m
//  DDAYGO
//
//  Created by Summer on 2017/11/28.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "BetViewController.h"
#import "PrefixHeader.pch"
#import "BetViewcell.h"
#import "BetSeleTableViewCell.h"
@interface BetViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//* 数据**/
@property (nonatomic, strong) NSMutableArray *Selearray;
@end

@implementation BetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self initTableHeadView];
}

- (void)initUI {
    self.title = @"促销彩下注";
    [self.tableView registerNib:[UINib nibWithNibName:@"BetViewcell" bundle:nil] forCellReuseIdentifier:@"BetViewcell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BetSeleTableViewCell" bundle:nil] forCellReuseIdentifier:@"BetSeleTableViewCell"];
    
    //    self.whiteBallHeaderView = [[NSBundle mainBundle] loadNibNamed:@"BetHeaderView" owner:self options:nil].lastObject;
    //    self.redBallHeaderView   = [[NSBundle mainBundle] loadNibNamed:@"BetHeaderView" owner:self options:nil].lastObject;
    UIToolbar * tools = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 0, 15)];
    // 解决出现的那条线
    tools.clipsToBounds = YES;
    // 解决tools背景颜色的问题
    [tools setBackgroundImage:[UIImage new]forToolbarPosition:UIBarPositionAny                      barMetrics:UIBarMetricsDefault];
    [tools setShadowImage:[UIImage new]
       forToolbarPosition:UIToolbarPositionAny];
    //  添加button
    NSMutableArray * buttons = [[NSMutableArray alloc]initWithCapacity:1];
    UIBarButtonItem * Instruction = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(Instruction)];
    Instruction.tintColor=[UIColor whiteColor];
    [buttons addObject:Instruction];
    [tools setItems:buttons animated:NO];
    UIBarButtonItem * btn =[[UIBarButtonItem alloc]initWithCustomView:tools];
    self.navigationItem.rightBarButtonItem = btn;
}

- (void)initTableHeadView {
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, 40)];
    self.tableView.tableHeaderView = myView; // 表头跟着cell一起滚动
    [myView setBackgroundColor:ZP_Graybackground];
    //     标题1
    ZP_GeneralLabel * TitleLabel1 = [ZP_GeneralLabel initWithtextLabel:_TitleLabel1.text textColor:ZP_textblack font:ZP_TrademarkFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
    TitleLabel1.text = @"距2014137期截止:";
    [myView addSubview:TitleLabel1];
    _TitleLabel1 = TitleLabel1;
    [TitleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myView).offset(55);
        make.top.equalTo(myView).offset(5);
        //        make.width.mas_equalTo(90);
        make.height.mas_equalTo(15);
    }];
    
    //     标题2
    ZP_GeneralLabel * TitleLabel2 = [ZP_GeneralLabel initWithtextLabel:_TitleLabel2.text textColor:ZP_textblack font:ZP_TrademarkFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
    TitleLabel2.text = @"奖池:";
    [myView addSubview:TitleLabel2];
    _TitleLabel2 = TitleLabel2;
    [TitleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myView).offset(80);
        make.top.equalTo(myView).offset(20);
        //        make.width.mas_equalTo(90);
        make.height.mas_equalTo(15);
    }];
    
    //    时间
    ZP_GeneralLabel * TimeLabel = [ZP_GeneralLabel initWithtextLabel:_TimeLabel.text textColor:[UIColor redColor] font:ZP_TrademarkFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
    TimeLabel.text = @"16天22小时45分";
    [myView addSubview:TimeLabel];
    _TimeLabel = TimeLabel;
    [TimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TitleLabel1).offset(90);
        make.top.equalTo(TitleLabel1).offset(0);
        make.height.mas_offset(15);
    }];
    //  金额
    ZP_GeneralLabel * AmountLabel = [ZP_GeneralLabel initWithtextLabel:_AmountLabel.text textColor:[UIColor redColor] font:ZP_TrademarkFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
    AmountLabel.text = @"￥165,973,926";
    [myView addSubview:AmountLabel];
    _AmountLabel = AmountLabel;
    [AmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TitleLabel2).offset(25);
        make.top.equalTo(TitleLabel2).offset(0);
        make.height.mas_offset(15);
    }];
    
    //    元
    ZP_GeneralLabel * YuanLabel = [ZP_GeneralLabel initWithtextLabel:_YuanLabel.text textColor:ZP_textblack font:ZP_TrademarkFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
    YuanLabel.text = @"彩金點數";
    [myView addSubview:YuanLabel];
    [YuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(AmountLabel).offset(75);
        make.top.equalTo(AmountLabel).offset(0);
        make.height.mas_offset(15);
    }];
}

// 下注
- (void)Instruction {
    
    ZPLog(@"下注");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BetViewcell * cell = [tableView dequeueReusableCellWithIdentifier:@"BetViewcell"];
    if (indexPath.row == 0) {
        [cell updateCount:59 WithIndex:indexPath.row];
        cell.howLabel.text = [NSString stringWithFormat:@"0"];
        __weak typeof(cell) weakCell = cell;
        cell.arrayBlock = ^(NSArray *arr1, NSArray *arr2) {
            NSLog(@"ar1 %@ ar2 %@",arr1,arr2);
            weakCell.howLabel.text = [NSString stringWithFormat:@"%ld",arr1.count];
            
            if (self.Selearray.count > 0) {
                for (NSNumber *Nstr in self.Selearray) {
                    if ([Nstr integerValue] > 99) {
                        self.Selearray = [NSMutableArray arrayWithArray:arr1];
                        [self.Selearray addObject:Nstr];
                        break;
                    }else{
                        self.Selearray = [NSMutableArray arrayWithArray:arr1];
                    }
                }
            }else{
                self.Selearray = [NSMutableArray arrayWithArray:arr1];
            }
            
            NSLog(@"-%@",self.Selearray);
            
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:0];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            
        };
        return cell;
    }if (indexPath.row ==1) {
        [cell updateCount:26 WithIndex:indexPath.row];
        cell.redlabel.text = [NSString stringWithFormat:@"红球1个,已选"];
        cell.howLabel.text = [NSString stringWithFormat:@"0"];
        cell.l1.hidden = YES;
        cell.l2.hidden = YES;
        cell.l3.hidden = YES;
        cell.l4.hidden = YES;
        __weak typeof(cell) weakCell = cell;
        cell.arrayBlock = ^(NSArray *arr1, NSArray *arr2) {
            
            if (arr2.count == 0) {
                [self.Selearray removeLastObject];
            }else{
                if (self.Selearray.count > 0) {
                    for (NSNumber *Nstr in self.Selearray) {
                        if ([Nstr integerValue] < 99) {
                            [self.Selearray addObject:arr2[0]];
                            break;
                        }else{
                            self.Selearray = [NSMutableArray arrayWithArray:arr1];
                        }
                    }
                }else{
                    self.Selearray = [NSMutableArray arrayWithArray:arr2];
                }
            }
            weakCell.howLabel.text = [NSString stringWithFormat:@"%ld",(unsigned long)arr2.count];
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:0];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            NSLog(@"-%@",self.Selearray);
        };
        return cell;
    }else{
        BetSeleTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"BetSeleTableViewCell"];
        [cell1 updateCount:self.Selearray];
        [cell1.deleBut addTarget:self action:@selector(dele:) forControlEvents:UIControlEventTouchUpInside];
        return cell1;
    }
    //    http://www.ddaygo.com/api/Test/addlotteryorder?token=03dfa90ff0efbda8cc6a7412690a3c0f&ballstr=2,12,16,22,55,8,1_3,13,16,22,55,9,2&count=3
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 59 / 8 * [UIScreen mainScreen].bounds.size.width/8 + 60;
    }
    if (indexPath.row == 1) {
        return 26 / 8 * [UIScreen mainScreen].bounds.size.width/8 + 80;
    }else{
        return 65;
    }
    
}

- (void)dele:(UIButton *)but
{
    if (self.Selearray.count > 0) {
        [self.Selearray removeLastObject];
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }else{
        NSLog(@"没有选定 ");
    }
    
}

- (NSMutableArray *)Selearray
{
    if (!_Selearray) {
        _Selearray = [NSMutableArray array];
    }
    return _Selearray;
}
@end
