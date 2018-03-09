//
//  Pop-upViewCell.m
//  DDAYGO
//
//  Created by Login on 2017/9/19.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "Pop-upViewCell.h"

@implementation Pop_upViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

+ (instancetype) cellAllocWithTableView:(UITableView *)tableView {
    Pop_upViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[[self class] alloc] initWithStyle:0 reuseIdentifier:NSStringFromClass([self class])];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
