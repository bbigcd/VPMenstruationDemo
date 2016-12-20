//
//  PregnancyViewController.m
//  VPMenstruationDemo
//
//  Created by bbigcd on 2016/12/14.
//  Copyright © 2016年 bbigcd. All rights reserved.
//

#import "PregnancyViewController.h"
#import "PrenancyView.h"

@interface PregnancyViewController ()

@property (nonatomic, strong) UIScrollView *mainScrollView;

@end

@implementation PregnancyViewController

#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height

- (UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:(CGRect){0, 0, Width, Height}];
    }
    return _mainScrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PrenancyView *view = [[PrenancyView alloc] init];
    
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@64);
        make.left.right.equalTo(@0);
        make.height.equalTo(@500);
    }];
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
