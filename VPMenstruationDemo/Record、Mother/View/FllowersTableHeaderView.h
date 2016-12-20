//
//  FllowersTableHeaderView.h
//  VPMenstruationDemo
//
//  Created by bbigcd on 2016/12/16.
//  Copyright © 2016年 bbigcd. All rights reserved.
//

#import <UIKit/UIKit.h>

// 状态花
@interface FllowersTableHeaderView : UIView
@property (nonatomic, strong) UIImageView *fllowersImageView;
@property (nonatomic, strong) UILabel *describeLabel;
@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@end

// 日历底部图例
@class StateImageViewAndLabelView;
@interface CalendarBottmLabelView : UIView
@property (nonatomic, strong) StateImageViewAndLabelView *view1;
@property (nonatomic, strong) StateImageViewAndLabelView *view2;
@property (nonatomic, strong) StateImageViewAndLabelView *view3;
@property (nonatomic, strong) StateImageViewAndLabelView *view4;
@end

// 日历底部图例子view
@interface StateImageViewAndLabelView : UIView
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *imageView;
@end

// tableView的头部
@interface HeaderInSectionView : UIView
@property (nonatomic, strong) UILabel *calendarLabel;
@property (nonatomic, strong) UILabel *stateLabel;

@end


