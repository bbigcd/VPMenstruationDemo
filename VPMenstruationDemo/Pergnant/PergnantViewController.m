//
//  PergnantViewController.m
//  VPMenstruationDemo
//
//  Created by bbigcd on 2016/12/14.
//  Copyright © 2016年 bbigcd. All rights reserved.
//

#import "PergnantViewController.h"
#import "RMTableHeadView.h"
#import "FSCalendar.h"
#import "FllowersTableHeaderView.h"
#import "DataModel.h"

@interface PergnantViewController ()
<
FSCalendarDataSource,
FSCalendarDelegate,
FSCalendarDelegateAppearance
>

@property (nonatomic, strong) RMTableHeadView *rmtableHeadView;
@property (nonatomic, strong) NSCalendar *gregorian;

@property (nonatomic, strong) DataModel *model;

@end

@implementation PergnantViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.rmtableHeadView.calendar.delegate = self;
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
    [self setupPreviousButtonAndNextButton];
}

- (void)setupPreviousButtonAndNextButton{
    UIButton *previousButton = [self commonCreateButtonWithFrame:CGRectMake(0, 5, 95, 34)
                                                       imageName:@"icon_prev"
                                                          action:@selector(previousClicked:)];
    
    UIButton *nextButton = [self commonCreateButtonWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)-95, 5, 95, 34)
                                                   imageName:@"icon_next"
                                                      action:@selector(nextClicked:)];
//    _rmtableHeadView.calendar.calendarHeaderView
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


- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated{
//    NSLog(@"%@", NSStringFromCGSize(bounds.size));
//    calendar.frame = (CGRect){calendar.frame.origin, bounds.size};
//    NSInteger height = bounds.size.height;
//    [_rmtableHeadView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@64);
//        make.left.right.equalTo(@0);
//        make.height.equalTo(@(height + 20));//
//    }];
    
//    [_rmtableHeadView.calendar mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@64);
//        make.left.right.equalTo(@0);
//        make.height.equalTo(@(height));//
//    }];

//    [_rmtableHeadView.fllowersTableHeaderView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@64);
//        make.left.right.equalTo(@0);
//        make.height.equalTo(@(height));//
//    }];
    
    [self.view layoutIfNeeded];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
