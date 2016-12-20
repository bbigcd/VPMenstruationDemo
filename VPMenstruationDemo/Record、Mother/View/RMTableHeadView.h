//
//  RMTableHeadView.h
//  VPMenstruationDemo
//
//  Created by bbigcd on 2016/12/19.
//  Copyright © 2016年 bbigcd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FllowersTableHeaderView,FSCalendar,CDUIPageControl,CalendarBottmLabelView;
@interface RMTableHeadView : UIView

@property (nonatomic, strong) UIScrollView *tableHeadScrollView;
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) FllowersTableHeaderView *fllowersTableHeaderView;
@property (nonatomic, strong) FSCalendar *calendar;
@property (nonatomic, strong) CDUIPageControl *pageControl;
@property (nonatomic, strong) CalendarBottmLabelView *calendarBottmLabelView;

@end
