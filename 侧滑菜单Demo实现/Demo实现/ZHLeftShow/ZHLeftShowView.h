//
//  ZHLeftShowView.h
//  Demo实现
//
//  Created by xyj on 2018/5/8.
//  Copyright © 2018年 xyj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHLeftShowView;
@protocol ZHLeftShowViewDelegate <NSObject>
@optional
-(void)leftShowView:(ZHLeftShowView *)leftShowVie didSelectIndexpath:(NSIndexPath *)indexpath;
@end

@interface ZHLeftShowView : UIView
//快速创建
+(instancetype)leftShowView;
//显示
-(void)show;
//消失
-(void)dismiss;
//代理方法
@property (nonatomic,weak) id<ZHLeftShowViewDelegate> delegate;
//销毁
-(void)xxxxxxxx;
@end
