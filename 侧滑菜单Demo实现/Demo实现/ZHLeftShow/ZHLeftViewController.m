//
//  ZHLeftViewController.m
//  Demo实现
//
//  Created by xyj on 2018/5/8.
//  Copyright © 2018年 xyj. All rights reserved.
//

#import "ZHLeftViewController.h"

@interface ZHLeftViewController ()

@end

@implementation ZHLeftViewController

+(instancetype)leftVC{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"ZHLeftViewController" bundle:nil];
    return [sb instantiateInitialViewController];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
}
//实现点击的代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.ClickCellIndex(indexPath);
}

@end
