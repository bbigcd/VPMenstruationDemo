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
#import "FllowersTableHeaderView.h"
#import "DataModel.h"
#import "SetPeriodTableViewCell.h"

@interface RMShowViewController ()<
FSCalendarDataSource,
FSCalendarDelegate,
FSCalendarDelegateAppearance,
UITableViewDelegate,
UITableViewDataSource,
UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *tableHeadView;
@property (nonatomic, strong) UIScrollView *tableHeadScrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) FSCalendar *calendar;
@property (nonatomic, strong) FllowersTableHeaderView *fllowersTableHeaderView;
@property (nonatomic, strong) CalendarBottmLabelView *calendarBottmLabelView;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;
// 公历
@property (nonatomic, strong) NSCalendar *gregorian;

@property (nonatomic, strong) DataModel *model;

@end

@implementation RMShowViewController

#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height

static NSString *const ID = @"SetPeriodTableViewCell";

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Width, Height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[SetPeriodTableViewCell class] forCellReuseIdentifier:ID];
        [self.view addSubview:_tableView];
        
    }
    return _tableView;
}

- (UIView *)tableHeadView{
    if (!_tableHeadView) {
        _tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 340)];
    }
    return _tableHeadView;
}

- (UIScrollView *)tableHeadScrollView{
    if (!_tableHeadScrollView) {
        _tableHeadScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Width, 340)];
        _tableHeadScrollView.contentSize = CGSizeMake(Width * 2, 320);
        _tableHeadScrollView.delegate = self;
        _tableHeadScrollView.showsHorizontalScrollIndicator = NO;
        _tableHeadScrollView.pagingEnabled = YES;
    }
    return _tableHeadScrollView;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:(CGRect){0, 300, Width, 20}];
        _pageControl.numberOfPages = 2;
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = [UIColor darkGrayColor];
        _pageControl.backgroundColor = [UIColor clearColor];
    }
    return _pageControl;
}

- (FllowersTableHeaderView *)fllowersTableHeaderView{
    if (!_fllowersTableHeaderView) {
        _fllowersTableHeaderView = [[FllowersTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, Width, 300)];
        _fllowersTableHeaderView.backgroundColor = [UIColor whiteColor];
    }
    return _fllowersTableHeaderView;
}

// 日历UI设置
- (FSCalendar *)calendar{
    if (!_calendar) {
        _calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(Width, 0, Width, 300)];
        _calendar.dataSource = self;
        _calendar.delegate = self;
        _calendar.scrollEnabled = NO;
        _calendar.allowsMultipleSelection = YES; // 开启多选中
        _calendar.appearance.headerMinimumDissolvedAlpha = 0.0f;
        _calendar.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
        _calendar.appearance.headerTitleColor = [UIColor blackColor];
        // 周的显示字体形式 S M T W T F S
        _calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
        // 非本月日期隐藏
        //    _calendar.placeholderType = FSCalendarPlaceholderTypeNone;
        _calendar.appearance.weekdayTextColor = [UIColor colorWithHue:0.00
                                                           saturation:0.32
                                                           brightness:0.93
                                                                alpha:1.00];
        
        _calendar.backgroundColor = [UIColor clearColor];
        
        
        //    calendar.appearance.eventSelectionColor = [UIColor whiteColor];
        //    calendar.appearance.eventOffset = CGPointMake(0, 0);
        [_calendar registerClass:[CustomCalendarCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return _calendar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [[DataModel alloc] init];
    self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"today"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(rightBarButtonItemClick)];
    
    self.tableView.tableHeaderView = self.tableHeadView;
    [self.tableHeadView addSubview:self.tableHeadScrollView];
    [self.tableHeadView addSubview:self.pageControl];
    
    // 花
    [self.tableHeadScrollView addSubview:self.fllowersTableHeaderView];
    _fllowersTableHeaderView.fllowersImageView.image = [UIImage imageNamed:@"黄体期"];
    _fllowersTableHeaderView.dayLabel.text = @"7";
    _fllowersTableHeaderView.describeLabel.text = @"Day";
    _fllowersTableHeaderView.stateLabel.text = @"Luteal phase";
    // 日历
    [self.tableHeadScrollView addSubview:self.calendar];
    
    // 日历底部标签
    self.calendarBottmLabelView = [[CalendarBottmLabelView alloc] initWithFrame:(CGRect){Width, 320, Width, 20}];
    [self.tableHeadScrollView addSubview:_calendarBottmLabelView];
    
    // 设置上下月份的按钮
    [self setupPreviousButtonAndNextButton];
    
    
    
    [self setupNSArraysDataSource];
    
    [self setupCalendar];
    
    
//    [self.tableView reloadData];
}



// 数据源设置
- (void)setupNSArraysDataSource{
    
    // 日期的格式化方式
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    
}

// 选中设置
- (void)setupCalendar{
    
    // 选中排卵日
    [_calendar selectDate:[_dateFormatter dateFromString:_model.datesOfOvulationDay[0]]];
    
    // 选中月经期
    for (NSString *string in _model.datesOfMenstrualPeriod) {
        [_calendar selectDate:[_dateFormatter dateFromString:string]];
    }
    // 是否可以点击
//    _calendar.allowsSelection = NO;

}

// 上下月份点击
- (void)setupPreviousButtonAndNextButton{
    UIButton *previousButton = [self commonCreateButtonWithFrame:CGRectMake(0, 5, 95, 34)
                                                       imageName:@"icon_prev"
                                                          action:@selector(previousClicked:)];
    
    UIButton *nextButton = [self commonCreateButtonWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)-95, 5, 95, 34)
                                                   imageName:@"icon_next"
                                                      action:@selector(nextClicked:)];
    [self.calendar addSubview:previousButton];
    [self.calendar addSubview:nextButton];
}

- (UIButton *)commonCreateButtonWithFrame:(CGRect)frame
                                imageName:(NSString *)imageName
                                   action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.backgroundColor = [UIColor whiteColor];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
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

// 日期  文字的颜色
- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleDefaultColorForDate:(NSDate *)date{

    NSString *dateString = [self.dateFormatter stringFromDate:date];
    // 下一月经期显示颜色
    if ([_model.datesOfForecastPeriod containsObject:dateString] ||
        [_model.datesOfNextForecastPeriod containsObject:dateString] ||
        [_model.datesOfLastForecastPeriod containsObject:dateString]) {
        return [UIColor redColor];
    }
    // 排卵期显示颜色
    if ([_model.datesOfOvulation containsObject:dateString]) {
        return [UIColor colorWithHue:0.75 saturation:0.80 brightness:0.71 alpha:1.00];
    }
    return nil;
}


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
    [self.calendar.visibleCells enumerateObjectsUsingBlock:^(__kindof FSCalendarCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDate *date = [self.calendar dateForCell:cell];
        FSCalendarMonthPosition position = [self.calendar monthPositionForCell:cell];
        [self configureCell:cell forDate:date atMonthPosition:position];
    }];
}

- (void)configureCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSString *dateString = [self.dateFormatter stringFromDate:date];
    
    CustomCalendarCell *diyCell = (CustomCalendarCell *)cell;

    diyCell.eventIndicator.hidden = NO;
    
    // 配置选中状态
    SelectionType selectionType = SelectionTypeNone;
    // 当前日期在选中日期里
    if ([self.calendar.selectedDates containsObject:date])
    {
        // 当前日期的前一天和后一天
        NSDate *previousDate = [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:-1 toDate:date options:0];
        NSDate *nextDate = [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:1 toDate:date options:0];
        
        // 当前日期和前一天、后一天也在选中日期里面 当前日期的选中类型为 SelectionTypeMiddle
        if ([self.calendar.selectedDates containsObject:previousDate]
            && [self.calendar.selectedDates containsObject:nextDate]) {
            selectionType = SelectionTypeMiddle;
        }
        // 当前日期和前一天
        else if ([self.calendar.selectedDates containsObject:previousDate])
        {
            selectionType = SelectionTypeRightBorder;
        }
        // 当前日期和后一天
        else if ([self.calendar.selectedDates containsObject:nextDate])
        {
            selectionType = SelectionTypeLeftBorder;
        }
        // 只有当前日期
        else
        {
            selectionType = SelectionTypeSingle;
        }
    }
    else // 当前日期不在选中日期中
    {
        selectionType = SelectionTypeNone;
    }
    
    // 默认今天和排卵日Layer隐藏 选中的Layer显示
    diyCell.selectionLayer.hidden = NO;
    diyCell.todayLayer.hidden = YES;
    diyCell.ovulationDayLayer.hidden = YES;
    
    // 今天 显示Layer
    if ([[_dateFormatter stringFromDate:[NSDate date]] isEqualToString:dateString])
    {
        diyCell.todayLayer.hidden = NO;
    }
    
    // 排卵日 显示Layer
    if ([_model.datesOfOvulationDay containsObject:dateString])
    {
        diyCell.ovulationDayLayer.hidden = NO;
    }
    
    // 非选中 选中的layer 隐藏
    if (selectionType == SelectionTypeNone)
    {
        diyCell.selectionLayer.hidden = YES;
        return;
    }
    
    
    diyCell.selectionType = selectionType;
    

}

#pragma mark - -- UITableViewDelegate --


#pragma mark - -- UITableViewDataSource --

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 75.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HeaderInSectionView *view = [[HeaderInSectionView alloc] initWithFrame:(CGRect){0, 0, Width, 75}];
    view.calendarLabel.text = @"Wedsday, 9 Octeober";
    view.stateLabel.text = @"During menstruation";
    return view;
}

// cell间距
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SetPeriodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - -- UIScrollViewDelegate --

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    _pageControl.currentPage = scrollView.contentOffset.x / Width;
}

@end
