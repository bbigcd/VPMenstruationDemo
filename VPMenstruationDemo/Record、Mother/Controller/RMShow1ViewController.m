//
//  RMShow1ViewController.m
//  VPMenstruationDemo
//
//  Created by bbigcd on 2016/12/21.
//  Copyright © 2016年 bbigcd. All rights reserved.
//

#import "RMShow1ViewController.h"
#import "RMTableHeadView.h"
#import "CustomCalendarCell.h"
#import "FSCalendar.h"
#import "FllowersTableHeaderView.h"
#import "DataModel.h"
#import "VPMenstrualPeriodAlgorithm.h"
#import "SetPeriodTableViewCell.h"
#import "FlowAndPainTableViewCell.h"
#import "CDUIPageControl.h"

@interface RMShow1ViewController ()<
FSCalendarDataSource,
FSCalendarDelegate,
FSCalendarDelegateAppearance,
UITableViewDelegate,
UITableViewDataSource,
UIScrollViewDelegate>
{
    NSArray *rmAarry;
    NSArray *ovulationArr;
    NSArray *ovulationDayArr;
    
}
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) RMTableHeadView *rmtableHeadView;
@property (nonatomic, strong) HeaderInSectionView *headerInSectionView;

@property (nonatomic, strong) NSCalendar *gregorian;

@property (nonatomic, strong) DataModel *model;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSDateFormatter *dateFormatterForHead;

@end

@implementation RMShow1ViewController

#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height

static NSString *const SetPeriodTableViewCellID = @"SetPeriodTableViewCell";
static NSString *const FlowAndPainTableViewCellID = @"FlowAndPainTableViewCell";
static NSString *const FSCalendarCellID = @"FSCalendarCellID";

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Width, Height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.rowHeight = 40.0f;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerNib:[UINib nibWithNibName:@"SetPeriodTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:SetPeriodTableViewCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"FlowAndPainTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:FlowAndPainTableViewCellID];
        [self.view addSubview:_tableView];
        
    }
    return _tableView;
}

- (RMTableHeadView *)rmtableHeadView{
    if (!_rmtableHeadView) {
        _rmtableHeadView = [[RMTableHeadView alloc] init];
        [self.view addSubview:_rmtableHeadView];
        [_rmtableHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@64);
            make.left.right.equalTo(@0);
            make.height.equalTo(@340);//
        }];
    }
    return _rmtableHeadView;
}

- (HeaderInSectionView *)headerInSectionView{
    if (!_headerInSectionView) {
        _headerInSectionView = [[HeaderInSectionView alloc] initWithFrame:(CGRect){0, 0, Width, 75}];
        _headerInSectionView.calendarLabel.text = [_dateFormatterForHead stringFromDate:[NSDate date]];
        _headerInSectionView.stateLabel.text = @"During menstruation";
    }
    return _headerInSectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"today"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(rightBarButtonItemClick)];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.rmtableHeadView.calendar.delegate = self;
    [_rmtableHeadView.calendar registerClass:[CustomCalendarCell class] forCellReuseIdentifier:FSCalendarCellID];
    self.model = [[DataModel alloc] init];
    _rmtableHeadView.fllowersTableHeaderView.fllowersImageView.image = [UIImage imageNamed:@"黄体期"];
    _rmtableHeadView.fllowersTableHeaderView.dayLabel.text = @"7";
    _rmtableHeadView.fllowersTableHeaderView.describeLabel.text = @"Day";
    _rmtableHeadView.fllowersTableHeaderView.stateLabel.text = @"Luteal phase";
    
    _rmtableHeadView.calendarBottmLabelView.view1.label.text = _model.titleLabelForBottomStateGuide[0];
    _rmtableHeadView.calendarBottmLabelView.view2.label.text = _model.titleLabelForBottomStateGuide[1];
    _rmtableHeadView.calendarBottmLabelView.view3.label.text = _model.titleLabelForBottomStateGuide[2];
    _rmtableHeadView.calendarBottmLabelView.view4.label.text = _model.titleLabelForBottomStateGuide[3];
    
    self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

    // 设置上下月份的按钮
    [self setupPreviousButtonAndNextButton];
    
    
    
    [self setupNSArraysDataSource];
    
    [self setupCalendar];
    
    rmAarry = [VPMenstrualPeriodAlgorithm vp_GetMenstrualPeriodWithDate:[NSDate date] CycleDay:25 PeriodLength:6];
    ovulationArr = [VPMenstrualPeriodAlgorithm vp_GetOvulationWithDate:[NSDate date] CycleDay:25 PeriodLength:6];
    ovulationDayArr = [VPMenstrualPeriodAlgorithm vp_GetOvulationDayWithDate:[NSDate date] CycleDay:25 PeriodLength:6];
    
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 数据源设置
- (void)setupNSArraysDataSource{
    
    // 日期的格式化方式
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    self.dateFormatterForHead = [[NSDateFormatter alloc] init];
    self.dateFormatterForHead.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
    self.dateFormatterForHead.dateFormat = @"EEEE, d MMMM";
}

// 选中设置
- (void)setupCalendar{
    
    // 选中排卵日
    //    [_calendar selectDate:[_dateFormatter dateFromString:_model.datesOfOvulationDay[0]]];
    
    // 选中月经期
    //    for (NSString *string in _model.datesOfMenstrualPeriod) {
    //        [_calendar selectDate:[_dateFormatter dateFromString:string]];
    //    }
    // 是否可以点击
    //    _calendar.allowsSelection = NO;
    
}

// 上下月份点击
- (void)setupPreviousButtonAndNextButton{
    UIButton *previousButton = [self commonCreateButtonWithFrame:CGRectMake(40, 5, 55, 34)
                                                       imageName:@"left-arrow"
                                                          action:@selector(previousClicked:)];
    
    UIButton *nextButton = [self commonCreateButtonWithFrame:CGRectMake(Width - 95, 5, 55, 34)
                                                   imageName:@"right-arrow"
                                                      action:@selector(nextClicked:)];
    [_rmtableHeadView.calendar addSubview:previousButton];
    [_rmtableHeadView.calendar addSubview:nextButton];
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
    [_rmtableHeadView.calendar setCurrentPage:[NSDate date] animated:YES];
}

// 上个月
- (void)previousClicked:(id)sender{
    NSDate *currentMonth = _rmtableHeadView.calendar.currentPage;
    NSDate *previousMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:-1 toDate:currentMonth options:0];
    [_rmtableHeadView.calendar setCurrentPage:previousMonth animated:YES];
}

// 下个月
- (void)nextClicked:(id)sender{
    NSDate *currentMonth = _rmtableHeadView.calendar.currentPage;
    NSDate *nextMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:currentMonth options:0];
    [_rmtableHeadView.calendar setCurrentPage:nextMonth animated:YES];
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
    _headerInSectionView.calendarLabel.text = [_dateFormatterForHead stringFromDate:date];
    [self configureVisibleCells];
}

- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did deselect date %@",[self.dateFormatter stringFromDate:date]);
    [self configureVisibleCells];
}

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated{
    //    NSLog(@"%@", NSStringFromCGSize(bounds.size));
    calendar.frame = (CGRect){calendar.frame.origin, bounds.size};
    [self.view layoutIfNeeded];
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


// 选中日期的背景色
- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillSelectionColorForDate:(NSDate *)date{
    return [UIColor colorWithRed:0.26 green:0.80 blue:0.86 alpha:1.00];
}

// 日期  文字的颜色
- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleDefaultColorForDate:(NSDate *)date{
    
    NSString *dateString = [self.dateFormatter stringFromDate:date];
    // 下一月经期显示颜色
    
    //    if ([_model.datesOfForecastPeriod containsObject:dateString] ||
    //        [_model.datesOfNextForecastPeriod containsObject:dateString] ||
    //        [_model.datesOfLastForecastPeriod containsObject:dateString]) {
    //        return [UIColor redColor];
    //    }
    
    if ([rmAarry containsObject:dateString]) {
        return [UIColor redColor];
    }
    
    
    // 排卵期显示颜色
    
    //    if ([_model.datesOfOvulation containsObject:dateString]) {
    //        if ([_model.datesOfOvulationDay containsObject:dateString]) {
    //            return [UIColor whiteColor];
    //        }
    //        return [UIColor colorWithHue:0.75 saturation:0.80 brightness:0.71 alpha:1.00];
    //    }
    
    
    
    if ([ovulationArr containsObject:dateString]) {
        if ([ovulationDayArr containsObject:dateString]) {
            return [UIColor whiteColor];
        }
        return [UIColor colorWithHue:0.75 saturation:0.80 brightness:0.71 alpha:1.00];
    }
    
    return nil;
}


- (FSCalendarCell *)calendar:(FSCalendar *)calendar cellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    CustomCalendarCell *cell = [calendar dequeueReusableCellWithIdentifier:FSCalendarCellID forDate:date atMonthPosition:monthPosition];
    return cell;
}

- (void)calendar:(FSCalendar *)calendar willDisplayCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition: (FSCalendarMonthPosition)monthPosition
{
    [self configureCell:cell forDate:date atMonthPosition:monthPosition];
}

#pragma mark - - Private methods -

- (void)configureVisibleCells
{
    [self.rmtableHeadView.calendar.visibleCells enumerateObjectsUsingBlock:^(__kindof FSCalendarCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDate *date = [_rmtableHeadView.calendar dateForCell:cell];
        FSCalendarMonthPosition position = [_rmtableHeadView.calendar monthPositionForCell:cell];
        [self configureCell:cell forDate:date atMonthPosition:position];
    }];
}

- (void)configureCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSString *dateString = [self.dateFormatter stringFromDate:date];
    //    NSLog(@"%@", NSStringFromCGSize(cell.frame.size));
    CustomCalendarCell *diyCell = (CustomCalendarCell *)cell;
    
    diyCell.eventIndicator.hidden = NO;
    
    diyCell.shapeLayer.hidden = NO;
    
    // 配置选中状态
    SelectionType selectionType = SelectionTypeNone;
    // 当前日期在选中日期里
    if ([_rmtableHeadView.calendar.selectedDates containsObject:date])
    {
        // 当前日期的前一天和后一天
        NSDate *previousDate = [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:-1 toDate:date options:0];
        NSDate *nextDate = [self.gregorian dateByAddingUnit:NSCalendarUnitDay value:1 toDate:date options:0];
        
        // 当前日期和前一天、后一天也在选中日期里面 当前日期的选中类型为 SelectionTypeMiddle
        if ([_rmtableHeadView.calendar.selectedDates containsObject:previousDate]
            && [_rmtableHeadView.calendar.selectedDates containsObject:nextDate]) {
            selectionType = SelectionTypeMiddle;
        }
        // 当前日期和前一天
        else if ([_rmtableHeadView.calendar.selectedDates containsObject:previousDate])
        {
            selectionType = SelectionTypeRightBorder;
        }
        // 当前日期和后一天
        else if ([_rmtableHeadView.calendar.selectedDates containsObject:nextDate])
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
    //    diyCell.selectionLayer.hidden = NO;
    diyCell.todayLayer.hidden = YES;
    diyCell.ovulationDayLayer.hidden = YES;
    
    // 今天 显示Layer
    if ([[_dateFormatter stringFromDate:[NSDate date]] isEqualToString:dateString])
    {
        //        diyCell.todayLayer.hidden = NO;
    }
    
    // 排卵日 显示Layer
    //    if ([_model.datesOfOvulationDay containsObject:dateString])
    //    {
    //        diyCell.ovulationDayLayer.hidden = NO;
    //    }
    if ([ovulationDayArr containsObject:dateString]) {
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
    return _model.iconImageArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 75.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.headerInSectionView;
}

// cell间距
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 3 || indexPath.row == 4)
    {
        FlowAndPainTableViewCell *FCell = [tableView dequeueReusableCellWithIdentifier:FlowAndPainTableViewCellID forIndexPath:indexPath];
        FCell.selectionStyle = UITableViewCellSelectionStyleNone;
        FCell.iconImageView.image = [UIImage imageNamed:_model.iconImageArray[indexPath.row]];
        FCell.titleLabel.text = _model.titleLabelTextArray[indexPath.row];
        if (indexPath.row == 3) {
            [FCell setBtnsNormalImage:@"flow" selectedImage:@"flow_click"];
        }else{
            [FCell setBtnsNormalImage:@"pain" selectedImage:@"pain-_click"];
        }
        return FCell;
    }
    else
    {
        SetPeriodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SetPeriodTableViewCellID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.iconImageView.image = [UIImage imageNamed:_model.iconImageArray[indexPath.row]];
        cell.titleLabel.text = _model.titleLabelTextArray[indexPath.row];
        if (indexPath.row == 5) {
//            cell.switchAction.hidden = YES;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - -- UIScrollViewDelegate --

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger oneOrTwo;
    if ((scrollView.contentOffset.x / Width) <= 0) {
        oneOrTwo = 0;
    }else{
        oneOrTwo = 1;
    }
    _rmtableHeadView.pageControl.currentPage = oneOrTwo;
}


@end
