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
@property (nonatomic,weak) ZHLeftShowView *leftView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    ZHLeftShowView *leftView = [ZHLeftShowView leftShowView];
    leftView.delegate = self;
    self.leftView = leftView;
}

- (IBAction)clickLeft:(id)sender {
  
    [_leftView show];
}
-(void)leftShowView:(ZHLeftShowView *)leftShowVie didSelectIndexpath:(NSIndexPath *)indexpath{
    NSLog(@"------点击了");
}



@end
