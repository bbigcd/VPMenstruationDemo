//
//  VPCustomSwitch.h
//  VPSwitchTest
//
//  Created by 张冲 on 16/12/20.
//  Copyright © 2016年 veepoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VPCustomSwitch : UIButton

@property (nonatomic, strong) UIImageView *cicleView;//小圆圈的视图默认白色

@property (nonatomic, assign) BOOL on;//默认关

@property (nonatomic, strong) NSString *onImageName;//开启图片的名字
@property (nonatomic, strong) NSString *offImageName;//关闭图片的名字

@property (nonatomic, strong) UIColor *onColor;//开启底色
@property (nonatomic, strong) UIColor *offColor;//关闭底色


/**
 initFrame之后调用

 @param onImageName 开启的底图
 @param offImageName 关闭的底图
 @param target 执行的目标
 @param action 执行的方法
 */
- (void)setSwiftOnImageName:(NSString *)onImageName offImageName:(NSString *)offImageName withTarget:(id)target action:(SEL)action;

/**
 initFrame之后调用 我们用这个
 
 @param onColor 开启的底色
 @param offColor 关闭的底色
 @param target 执行的目标
 @param action 执行的方法
 */
- (void)setSwiftOnColor:(UIColor *)onColor offColor:(UIColor *)offColor withTarget:(id)target action:(SEL)action;

@end
