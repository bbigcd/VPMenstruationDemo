//
//  ViewController.m
//  VPMenstruationDemo
//
//  Created by bbigcd on 2016/12/14.
//  Copyright © 2016年 bbigcd. All rights reserved.
//

#import "ViewController.h"
#import "RMShowViewController.h"
#import "PergnantViewController.h"
#import "PregnancyViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *titleArray;
}

@property (nonatomic, strong) UITableView *tableView;

@end

#define  Width  [UIScreen mainScreen].bounds.size.width
#define  Height [UIScreen mainScreen].bounds.size.height

@implementation ViewController

static NSString *const ID = @"Cell";

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    titleArray = @[@"只记经期/妈咪", @"备孕", @"怀孕"];
    [self.tableView reloadData];
}

#pragma mark - -- UITableViewDataSource --

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.textLabel.text = titleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = nil;
    switch (indexPath.row) {
        case 0:
            vc = [[RMShowViewController alloc] init];
            break;
        case 1:
            vc = [[PergnantViewController alloc] init];
            break;
        case 2:
            vc = [[PregnancyViewController alloc] init];
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
