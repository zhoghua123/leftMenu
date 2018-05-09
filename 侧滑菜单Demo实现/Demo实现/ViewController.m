//
//  ViewController.m
//  Demo实现
//
//  Created by xyj on 2018/5/8.
//  Copyright © 2018年 xyj. All rights reserved.
//

#import "ZHLeftShowView.h"
#import "ViewController.h"

@interface ViewController ()<ZHLeftShowViewDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
  
}

- (IBAction)clickLeft:(id)sender {
    ZHLeftShowView *leftView = [ZHLeftShowView leftShowView];
    leftView.delegate = self;
    [leftView show];
}
-(void)leftShowView:(ZHLeftShowView *)leftShowVie didSelectIndexpath:(NSIndexPath *)indexpath{
    NSLog(@"------点击了");
}



@end
