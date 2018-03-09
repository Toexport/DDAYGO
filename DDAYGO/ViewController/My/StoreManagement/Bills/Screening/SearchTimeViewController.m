//
//  SearchTimeViewController.m
//  DDAYGO
//
//  Created by Login on 2017/9/29.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "SearchTimeViewController.h"

@interface SearchTimeViewController ()
///<UIPickerViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation SearchTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"選擇時間";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(search)];
    self.navigationItem.rightBarButtonItem = item;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
}

- (void)search {
    NSDate *theDate =self.datePickerView.date;
    NSLog(@"the date picked is :%@",[theDate descriptionWithLocale:[NSLocale currentLocale]]);
    NSDateFormatter *dateformatter =[[NSDateFormatter alloc]init];
    dateformatter.dateFormat =@"YYYY-MM";
    self.timeLabel.text = [dateformatter stringFromDate:theDate];
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
