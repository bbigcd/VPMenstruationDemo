//
//  RMTableHeadView.m
//  VPMenstruationDemo
//
//  Created by bbigcd on 2016/12/19.
//  Copyright © 2016年 bbigcd. All rights reserved.
//

#import "RMTableHeadView.h"
#import "FllowersTableHeaderView.h"
#import "CDUIPageControl.h"
#import "FSCalendar.h"

@implementation RMTableHeadView

#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}


- (void)setupViews{
    [self addSubview:self.tableHeadScrollView];
    [self addSubview:self.pageControl];
    [_tableHeadScrollView addSubview:self.container];
    [_tableHeadScrollView addSubview:self.calendar];
    [_tableHeadScrollView addSubview:self.fllowersTableHeaderView];
    [_tableHeadScrollView addSubview:self.calendarBottmLabelView];
    [self viewLayout];
}

- (void)viewLayout{
    [_tableHeadScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@(-20));
        make.height.equalTo(@20);
    }];
    
    //用_container将scrollView撑开
    [_container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_tableHeadScrollView);
    }];

    
    //tableHeadScrollView中的控件
    // 1. 花
    [_fllowersTableHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(Width);
        make.height.equalTo(@300);
    }];
    
    // 2. 日历
    [_calendar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(Width);
        make.height.equalTo(@300);
        make.top.equalTo(_fllowersTableHeaderView.mas_top);
        make.left.equalTo(_fllowersTableHeaderView.mas_right);
    }];
    
    // 3. 日历底部标识
    [_calendarBottmLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_calendar.mas_left);
        make.right.equalTo(_calendar.mas_right);
        make.bottom.equalTo(self);
        make.height.equalTo(@20);
    }];
    
    [_container mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fllowersTableHeaderView.mas_top);
        make.left.equalTo(_fllowersTableHeaderView.mas_left);
        make.bottom.equalTo(_calendar.mas_bottom);
        make.right.equalTo(_calendar.mas_right);
    }];
}


- (UIView *)container{
    if (!_container) {
        _container = [[UIView alloc] init];
        _container.backgroundColor = [UIColor whiteColor];
    }
    return _container;
}


// 嵌套的ScrollView
- (UIScrollView *)tableHeadScrollView{
    if (!_tableHeadScrollView) {
        _tableHeadScrollView = [[UIScrollView alloc] init];
        _tableHeadScrollView.showsHorizontalScrollIndicator = NO;
        _tableHeadScrollView.pagingEnabled = YES;
    }
    return _tableHeadScrollView;
}

// 状态花
- (FllowersTableHeaderView *)fllowersTableHeaderView{
    if (!_fllowersTableHeaderView) {
        _fllowersTableHeaderView = [[FllowersTableHeaderView alloc] init];
        _fllowersTableHeaderView.backgroundColor = [UIColor whiteColor];
    }
    return _fllowersTableHeaderView;
}

// 日历UI设置
- (FSCalendar *)calendar{
    if (!_calendar) {
        _calendar = [[FSCalendar alloc] init];
        _calendar.scrollEnabled = NO;
//        _calendar.allowsMultipleSelection = YES; // 开启多选中
        _calendar.appearance.headerMinimumDissolvedAlpha = 0.0f;
        _calendar.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
        _calendar.appearance.headerTitleColor = [UIColor blackColor];
        // 周的显示字体形式 S M T W T F S
        _calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
        // 非本月日期隐藏
        _calendar.placeholderType = FSCalendarPlaceholderTypeFillHeadTail;
        _calendar.appearance.weekdayTextColor = [UIColor colorWithHue:0.00
                                                           saturation:0.32
                                                           brightness:0.93
                                                                alpha:1.00];
        
        _calendar.backgroundColor = [UIColor clearColor];
//        _calendar.appearance.todayColor = [UIColor colorWithRed:0.26 green:0.80 blue:0.86 alpha:1.00];
//
//
//        calendar.appearance.eventSelectionColor = [UIColor whiteColor];
//        calendar.appearance.eventOffset = CGPointMake(0, 0);
    }
    return _calendar;
}

- (CalendarBottmLabelView *)calendarBottmLabelView{
    if (!_calendarBottmLabelView) {
        _calendarBottmLabelView = [[CalendarBottmLabelView alloc] init];
        _calendarBottmLabelView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    }
    return _calendarBottmLabelView;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[CDUIPageControl alloc] init];//WithFrame:(CGRect){0, 300, Width, 20}
        [_pageControl setupCurrentImageName:@"swift_light" indicatorImageName:@"swfit_dark"];
        _pageControl.numberOfPages = 2;
        _pageControl.backgroundColor = [UIColor clearColor];
    }
    return _pageControl;
}


@end
