//
//  RMShowViewController.m
//  VPMenstruationDemo
//
//  Created by bbigcd on 2016/12/14.
//  Copyright © 2016年 bbigcd. All rights reserved.
//

#import "RMShowViewController.h"
#import "FSCalendar.h"
#import "CustomCalendarCell.h"
#import "FSCalendarExtensions.h"

@interface RMShowViewController ()<FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance>

@property (nonatomic, weak) FSCalendar *calendar;
@property (nonatomic, weak) UIButton *previousButton;
@property (nonatomic, weak) UIButton *nextButton;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

// 公历
@property (nonatomic, strong) NSCalendar *gregorian;

@property (nonatomic, copy) NSArray *datesWithEvent;// 单事件
@property (nonatomic, copy) NSArray *datesWithMultipleEvents;// 多重事件

@property (nonatomic, copy) NSArray *datesOfMenstrualPeriod;// 月经期
@property (nonatomic, copy) NSArray *datesOfForecastPeriod;// 预产下一月经期
@property (nonatomic, copy) NSArray *datesOfOvulation;// 排卵期
@property (nonatomic, copy) NSArray *datesOfOvulationDay;// 排卵日

@property (nonatomic, copy) NSArray *datesOfNextForecastPeriod;

@end

@implementation RMShowViewController

- (void)loadView{
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.view = view;
    
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 64, view.frame.size.width, 300)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.allowsMultipleSelection = YES; // 开启多选中
   
    calendar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:calendar];
    self.calendar = calendar;
    
//    calendar.appearance.eventSelectionColor = [UIColor whiteColor];
//    calendar.appearance.eventOffset = CGPointMake(0, 0);
    [calendar registerClass:[CustomCalendarCell class] forCellReuseIdentifier:@"cell"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Today" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    UIButton *previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
    previousButton.frame = CGRectMake(0, 64+5, 95, 34);
    previousButton.backgroundColor = [UIColor whiteColor];
    previousButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [previousButton setImage:[UIImage imageNamed:@"icon_prev"] forState:UIControlStateNormal];
    [previousButton addTarget:self action:@selector(previousClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:previousButton];
    self.previousButton = previousButton;
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(CGRectGetWidth(self.view.frame)-95, 64+5, 95, 34);
    nextButton.backgroundColor = [UIColor whiteColor];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [nextButton setImage:[UIImage imageNamed:@"icon_next"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    self.nextButton = nextButton;
    
    [self setupNSArraysDataSource];
    
    [self setupCalendar];
}

// 设置
- (void)setupCalendar{
    
    // 选中排卵日
    [_calendar selectDate:[_dateFormatter dateFromString:_datesOfOvulationDay[0]]];
    
    // 选中月经期
    for (NSString *string in _datesOfMenstrualPeriod) {
        [_calendar selectDate:[_dateFormatter dateFromString:string]];
    }
    
    // 周的显示字体形式 S M T W T F S
    _calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
    
    // 非本月日期隐藏
//    _calendar.placeholderType = FSCalendarPlaceholderTypeNone;
    
    // 是否可以点击
//    _calendar.allowsSelection = NO;
    
    // 是否可以滑动
    _calendar.scrollEnabled = NO;
    
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
    
    // 选中日期背景色
//    _calendar.appearance.selectionColor = [UIColor colorWithHue:0.75
//                                                     saturation:0.80
//                                                     brightness:0.71
//                                                          alpha:1.00];
    
    
}

// 数据源设置
- (void)setupNSArraysDataSource{
    
    // 日期的格式化方式
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    // 事件数据源
    self.datesWithEvent = @[@"2016-12-23"];
    
    self.datesWithMultipleEvents = @[@"2016-12-09"];
    
    // 各个阶段数据
    self.datesOfMenstrualPeriod = @[@"2016-12-08",
                                    @"2016-12-09",
                                    @"2016-12-10",
                                    @"2016-12-11",
                                    @"2016-12-12",
                                    @"2016-12-13",
                                    @"2016-12-14"];
    
    self.datesOfForecastPeriod = @[@"2016-12-23",
                                   @"2016-12-24",
                                   @"2016-12-25",
                                   @"2016-12-26",
                                   @"2016-12-27",
                                   @"2016-12-28",
                                   @"2016-12-29",
                                   @"2016-12-30"];
    
    self.datesOfOvulation = @[@"2016-11-29",
                              @"2016-11-30",
                              @"2016-12-01",
                              @"2016-12-02"];
    
    self.datesOfOvulationDay = @[@"2016-12-01"];
    
    self.datesOfNextForecastPeriod = @[@"2017-01-07",
                                       @"2017-01-08",
                                       @"2017-01-09",
                                       @"2017-01-10",
                                       @"2017-01-11",
                                       @"2017-01-12",
                                       @"2017-01-13",
                                       @"2017-01-14"];
}

#pragma mark - -- 设置颜色 --
- (void)setupCellBGColorForCell:(CustomCalendarCell *)diyCell Date:(NSDate *)date{
    NSString *dateString = [self.dateFormatter stringFromDate:date];
    // 月经期显示颜色
    if ([_datesOfMenstrualPeriod containsObject:dateString]) {
//        diyCell.selectionLayer.fillColor = [UIColor colorWithHue:0.98 saturation:0.19 brightness:0.99 alpha:1.00].CGColor;
        diyCell.selectionLayer.fillColor = nil;
//        diyCell.titleLabel.backgroundColor = [UIColor colorWithHue:0.98 saturation:0.19 brightness:0.99 alpha:1.00];
        diyCell.titleLabel.textColor = [UIColor colorWithHue:0.98 saturation:0.19 brightness:0.99 alpha:1.00];
    }
    
    // 当天的颜色
    if ([[_dateFormatter stringFromDate:[NSDate date]] isEqualToString:dateString]) {
        diyCell.selectionLayer.fillColor = [UIColor colorWithHue:0.52 saturation:0.70 brightness:0.86 alpha:1.00].CGColor;
        diyCell.titleLabel.textColor = [UIColor colorWithHue:0.52 saturation:0.70 brightness:0.86 alpha:1.00];
    }
    
    // 排卵日
    if ([_datesOfOvulationDay containsObject:dateString]) {
        diyCell.selectionLayer.fillColor = nil;
//        diyCell.backgroundColor = [UIColor colorWithHue:0.52 saturation:0.70 brightness:0.86 alpha:1.00];
//        CGFloat radius = MIN(diyCell.fs_height, diyCell.fs_width);
//        diyCell.layer.cornerRadius = radius / 2;
        
//        diyCell.titleLabel.backgroundColor = [UIColor colorWithHue:0.75 saturation:0.80 brightness:0.71 alpha:1.00];
//        diyCell.titleLabel.frame = CGRectMake(0, 0, 20, 20);
//        diyCell.titleLabel.center = CGPointMake(diyCell.fs_width / 2, 15);
//        diyCell.titleLabel.layer.cornerRadius = 10;
//        diyCell.titleLabel.layer.masksToBounds = YES;
        diyCell.titleLabel.textColor = [UIColor colorWithHue:0.75 saturation:0.80 brightness:0.71 alpha:1.00];
//        diyCell.titleLabel.textColor = [UIColor whiteColor];
    }

}


#pragma mark - - Target actions -

// 跳转到今天
- (void)rightBarButtonItemClick{
    [self.calendar setCurrentPage:[NSDate date] animated:YES];
}

// 上个月
- (void)previousClicked:(id)sender{
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *previousMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:-1 toDate:currentMonth options:0];
    [self.calendar setCurrentPage:previousMonth animated:YES];
}

// 下个月
- (void)nextClicked:(id)sender{
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *nextMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:currentMonth options:0];
    [self.calendar setCurrentPage:nextMonth animated:YES];
}


#pragma mark - -- FSCalendarDataSource --

// 某个日期的事件数量
- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date{
    return 0;
}

#pragma mark - -- FSCalendarDelegate --

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did select date %@",[self.dateFormatter stringFromDate:date]);
    [self configureVisibleCells];
}

- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did deselect date %@",[self.dateFormatter stringFromDate:date]);
    [self configureVisibleCells];
}

#pragma mark - -- FSCalendarDelegateAppearance --
// 单事件的底部颜色
- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventColorForDate:(NSDate *)date{
    return nil;
}

// 多重事件底部的颜色
- (NSArray *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventDefaultColorsForDate:(NSDate *)date{
    return nil;
}

// 日期的文字的颜色，可以在这里设置各个不同生理区间的颜色
- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleDefaultColorForDate:(NSDate *)date{
//    NSLog(@"%@", date);
    NSString *dateString = [self.dateFormatter stringFromDate:date];
    // 月经期显示颜色
//    if ([_datesOfMenstrualPeriod containsObject:dateString]) {
//        return [UIColor magentaColor];
//    }
    // 下一月经期显示颜色
    if ([_datesOfForecastPeriod containsObject:dateString] ||
        [_datesOfNextForecastPeriod containsObject:dateString]) {
        return [UIColor redColor];
    }
    // 排卵期显示颜色
    if ([_datesOfOvulation containsObject:dateString]) {
        return [UIColor colorWithHue:0.75 saturation:0.80 brightness:0.71 alpha:1.00];
    }
    return nil;
}

// 选中的填充背景色 主要是设置月经期
//- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillSelectionColorForDate:(NSDate *)date{
//    NSString *dateString = [self.dateFormatter stringFromDate:date];
//    // 月经期显示颜色
////    if ([_datesOfMenstrualPeriod containsObject:dateString]) {
////        return [UIColor colorWithHue:0.98 saturation:0.19 brightness:0.99 alpha:1.00];
////    }
//    if ([[_dateFormatter stringFromDate:[NSDate date]] isEqualToString:dateString]) {
//        return [UIColor yellowColor];
//    }
//    return [UIColor blueColor];
//}


- (FSCalendarCell *)calendar:(FSCalendar *)calendar cellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    CustomCalendarCell *cell = [calendar dequeueReusableCellWithIdentifier:@"cell" forDate:date atMonthPosition:monthPosition];
    return cell;
}

- (void)calendar:(FSCalendar *)calendar willDisplayCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition: (FSCalendarMonthPosition)monthPosition
{
    [self configureCell:cell forDate:date atMonthPosition:monthPosition];
}

#pragma mark - - Private methods -

- (void)configureVisibleCells
{
    [self.calendar.visibleCells enumerateObjectsUsingBlock:^(__kindof FSCalendarCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDate *date = [self.calendar dateForCell:obj];
        FSCalendarMonthPosition position = [self.calendar monthPositionForCell:obj];
        [self configureCell:obj forDate:date atMonthPosition:position];
    }];
}

- (void)configureCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    CustomCalendarCell *diyCell = (CustomCalendarCell *)cell;
    
    [self setupCellBGColorForCell:diyCell Date:date];
    
    // Configure selection layer
    if (monthPosition == FSCalendarMonthPositionCurrent || self.calendar.scope == FSCalendarScopeWeek)
    {
        diyCell.eventIndicator.hidden = NO;
        
        SelectionType selectionType = SelectionTypeNone;
        if ([self.calendar.selectedDates containsObject:date])
        {
            NSDate *previousDate = [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:-1 toDate:date options:0];
            NSDate *nextDate = [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:1 toDate:date options:0];
            
            if ([self.calendar.selectedDates containsObject:date]) {
                if ([self.calendar.selectedDates containsObject:previousDate]
                    && [self.calendar.selectedDates containsObject:nextDate]) {
                    selectionType = SelectionTypeMiddle;
                }
                else if ([self.calendar.selectedDates containsObject:previousDate]
                         && [self.calendar.selectedDates containsObject:date])
                {
                    selectionType = SelectionTypeRightBorder;
                }
                else if ([self.calendar.selectedDates containsObject:nextDate])
                {
                    selectionType = SelectionTypeLeftBorder;
                }
                else
                {
                    selectionType = SelectionTypeSingle;
                }
            }
        }
        else
        {
            selectionType = SelectionTypeNone;
        }
        
        if (selectionType == SelectionTypeNone) {
            diyCell.selectionLayer.hidden = YES;
            return;
        }
        
        diyCell.selectionLayer.hidden = NO;
        diyCell.selectionType = selectionType;
        
        
    }
    else if (monthPosition == FSCalendarMonthPositionNext
             || monthPosition == FSCalendarMonthPositionPrevious)
    {
        diyCell.selectionLayer.hidden = YES;
        diyCell.eventIndicator.hidden = YES; // Hide default event indicator
        if ([self.calendar.selectedDates containsObject:date])
        {
            // Prevent placeholders from changing text color
            diyCell.titleLabel.textColor = self.calendar.appearance.titlePlaceholderColor;
        }
    }
}




@end
