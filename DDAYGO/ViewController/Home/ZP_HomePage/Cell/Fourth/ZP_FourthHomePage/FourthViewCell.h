//
//  FourthViewCell.h
//  DDAYGO
//
//  Created by Login on 2017/9/12.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FourthViewCell : UITableViewCell
@property (nonatomic, copy) void(^FourthBlock)(NSInteger tag);
@property (nonatomic, strong) NSArray * arrDara;
@property (nonatomic, strong) UILabel * Titlelabel; //标题
@property (nonatomic, strong) UIImageView * imageView1; // 图片1
@property (nonatomic, strong) UIImageView * imageView2; // 图片2
- (void)InformationWithDic:(NSDictionary *)dic;

@end
