//
//  Pop-upTableViewDelegate.m
//  DDAYGO
//
//  Created by Login on 2017/9/19.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "Pop-upTableViewDelegate.h"

@interface Pop_upTableViewDelegate ()

@property (nonatomic, copy) TableViewDidSelectRowAtIndexPath tableViewDidSelectRowAtIndexPath;

@end

@implementation Pop_upTableViewDelegate

- (instancetype) init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (instancetype)initWithDidSelectRowAtIndexPath:(TableViewDidSelectRowAtIndexPath)tableViewDidSelectRowAtIndexPath {
    self = [super init];
    if (self) {
        self.tableViewDidSelectRowAtIndexPath = [tableViewDidSelectRowAtIndexPath copy];
    }
    return self;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.tableViewDidSelectRowAtIndexPath) {
        self.tableViewDidSelectRowAtIndexPath(indexPath.row);
    }
}

@end
