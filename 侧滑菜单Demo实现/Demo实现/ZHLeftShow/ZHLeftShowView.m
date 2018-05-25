//
//  ZHLeftShowView.m
//  Demo实现
//
//  Created by xyj on 2018/5/8.
//  Copyright © 2018年 xyj. All rights reserved.
//
/*
 点击
 1. 在主窗口上添加一个View
 2. 给View添加手势: 左滑/点击手势
 3. 监听手势点击退删除该View/左滑控制该View的透明度,直到为0
 3. 在该View上添加一个控制器的View
 */
#define ZHSCREENW [UIScreen mainScreen].bounds.size.width
#define ZHSCREENH [UIScreen mainScreen].bounds.size.height
#define SHOWWidth ZHSCREENW*0.75
#import "ZHLeftShowView.h"
#import "ZHLeftViewController.h"

@interface ZHLeftShowView()<UIGestureRecognizerDelegate>
@property (nonatomic,strong) ZHLeftViewController *leftVC;
@end

@implementation ZHLeftShowView

-(void)xxxxxxxx{
    [self removeFromSuperview];
}
+(instancetype)leftShowView{
    return [[self alloc] init];
}
-(instancetype)init{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

-(void)setup{
    
    //1.初始化背景View
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    self.frame = CGRectMake(0, 0, ZHSCREENW, ZHSCREENH);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.hidden = YES;
    self.userInteractionEnabled = YES;
    //2.控制器
    ZHLeftViewController *leftVC = [ZHLeftViewController leftVC];
    //将事件传递出去
    __weak typeof(self) weakSelf = self;
    leftVC.ClickCellIndex = ^(NSIndexPath *indexpath) {
        if ([weakSelf.delegate respondsToSelector:@selector(leftShowView:didSelectIndexpath:)]) {
            [weakSelf dismiss];
            [weakSelf.delegate leftShowView:weakSelf didSelectIndexpath:indexpath];
        }
    };
    _leftVC = leftVC;
    //3. 添加View
    leftVC.view.frame = CGRectMake(-SHOWWidth, 0, SHOWWidth, ZHSCREENH);
    [self addSubview:leftVC.view];
    //4. 给bgView添加点击/左滑手势
    //添加点击手势
    UITapGestureRecognizer *tapGR = [[ UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    tapGR.delegate = self;
    [self addGestureRecognizer:tapGR];
   //添加拖动动手势
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(viewPan:)];
    [self addGestureRecognizer:panGR];
}

//显示
-(void)show{
    self.hidden = NO;
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.35 animations:^{
        weakSelf.leftVC.view.frame = CGRectMake(0, 0, SHOWWidth, ZHSCREENH);
    }];
}

//消失
-(void)dismiss{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.35 animations:^{
        weakSelf.leftVC.view.frame = CGRectMake(-SHOWWidth, 0, SHOWWidth, ZHSCREENH);
        weakSelf.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    } completion:^(BOOL finished) {
        weakSelf.hidden = YES;
    }];
}

//监听触摸过程
-(void)viewPan:(UIPanGestureRecognizer *)pan{
    //1.拿到触摸起始点
    CGFloat xxxxv = 0;
    //2. 及时移动的点x为负左移,反之
    CGPoint endPoint = [pan translationInView:self];
//    NSLog(@"========%@",NSStringFromCGPoint(endPoint));
    if (self.leftVC.view.frame.origin.x+endPoint.x <= 0 && self.leftVC.view.frame.origin.x+endPoint.x >= -SHOWWidth) {
        //2.1 修改view的位置
        [self translatView:endPoint.x];
        //2.2 拿到至零前的移动点
        xxxxv = self.leftVC.view.frame.origin.x;
        //关键!!!!!，不设为零会不断递增，视图会突然不见
        [pan setTranslation:CGPointZero inView:self];
    }else{
        if (self.leftVC.view.frame.origin.x+endPoint.x > 0) {
            self.leftVC.view.transform = CGAffineTransformIdentity;
            self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
        }
    }
    //3. 拿到比例,设置透明度的改变
    CGFloat scale =1 - fabs(self.leftVC.view.frame.origin.x)/SHOWWidth;
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4*scale];
    //4. 触摸结束时消失
    if (pan.state == UIGestureRecognizerStateEnded && endPoint.x<=0) {
        if (xxxxv >= 0.2*(-SHOWWidth)) {
            if (xxxxv <0) {
                self.leftVC.view.transform = CGAffineTransformIdentity;
                self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
            }
        }else{
           [self dismiss];
        }
    }
}
//修改展示View的位置
-(void)translatView:(CGFloat)xxx{
    //拿到当前的frame
    self.leftVC.view.transform = CGAffineTransformTranslate(self.leftVC.view.transform, xxx, 0);
}

#pragma mark - UIGestureRecognizerDelegate
//设置点击的范围
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    //获取当前的触摸点
    CGPoint curp = [touch locationInView:self];
    if (curp.x <= SHOWWidth) {
        return NO;
    }else{
        return YES;
    }
}
@end
