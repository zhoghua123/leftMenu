//
//  ZHLeftViewController.h
//  Demo实现
//
//  Created by xyj on 2018/5/8.
//  Copyright © 2018年 xyj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHLeftViewController : UITableViewController
+(instancetype)leftVC;
@property (nonatomic,copy) void(^ClickCellIndex)(NSIndexPath * indexpath);
@end
