//
//  RMShowViewController.m
//  VPMenstruationDemo
//
//  Created by bbigcd on 2016/12/14.
//  Copyright © 2016年 bbigcd. All rights reserved.
//

#import "RMShowViewController.h"
#import "FSCalendar.h"

@interface RMShowViewController ()<FSCalendarDataSource, FSCalendarDelegate>

@property (weak, nonatomic) FSCalendar *calendar;

@end

@implementation RMShowViewController

- (void)loadView{
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.view = view;
    
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 64, view.frame.size.width, 300)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:calendar];
    self.calendar = calendar;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Today" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    [self setupCalendar];
}

// 设置
- (void)setupCalendar{
    // 周的显示字体形式 S M T W T F S
    _calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
    // 非本月日期隐藏
    _calendar.placeholderType = FSCalendarPlaceholderTypeNone;
    
    // 头的颜色
    _calendar.appearance.headerTitleColor = [UIColor blackColor];
    // 周的字体颜色
    _calendar.appearance.weekdayTextColor = [UIColor colorWithHue:0.00
                                                       saturation:0.32
                                                       brightness:0.93
                                                            alpha:1.00];
    // 上下月标签透明度
    _calendar.appearance.headerMinimumDissolvedAlpha = 0.0f;
    // 当天背景色
    _calendar.appearance.todayColor = [UIColor colorWithHue:0.52
                                                 saturation:0.70
                                                 brightness:0.86
                                                      alpha:1.00];
    // 设置语言
    _calendar.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
}

- (void)rightBarButtonItemClick{
    
}


@end
