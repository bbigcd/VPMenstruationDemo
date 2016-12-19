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
@interface PergnantViewController ()
<
FSCalendarDataSource,
FSCalendarDelegate,
FSCalendarDelegateAppearance
>

@property (nonatomic, strong) RMTableHeadView *rmtableHeadView;

@end

@implementation PergnantViewController

- (RMTableHeadView *)rmtableHeadView{
    if (!_rmtableHeadView) {
        _rmtableHeadView = [[RMTableHeadView alloc] init];
        [self.view addSubview:_rmtableHeadView];
        [_rmtableHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(@0);
            make.height.equalTo(@340);
        }];
    }
    return _rmtableHeadView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.rmtableHeadView.calendar.delegate = self;
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
