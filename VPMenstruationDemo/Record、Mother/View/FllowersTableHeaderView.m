//
//  FllowersTableHeaderView.m
//  VPMenstruationDemo
//
//  Created by bbigcd on 2016/12/16.
//  Copyright © 2016年 bbigcd. All rights reserved.
//

#import "FllowersTableHeaderView.h"

@implementation FllowersTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    [self addSubview:self.fllowersImageView];
    [self addSubview:self.dayLabel];// 布局基于这个
    [self addSubview:self.describeLabel];
    [self addSubview:self.stateLabel];
    [self viewLayout];
}

- (void)viewLayout{
    _fllowersImageView.frame = CGRectMake(0, 0, 240, 240);
    _fllowersImageView.center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    // 这里用autolayout布局简直能飞起
    _dayLabel.frame = CGRectMake(0, 0, 80, 60);
    _dayLabel.center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));

    _describeLabel.frame = CGRectMake(0, 0, CGRectGetWidth(_fllowersImageView.frame), 40);
    _describeLabel.center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 45);
    
    _stateLabel.frame = CGRectMake(0, 0, CGRectGetWidth(_fllowersImageView.frame), 40);
    _stateLabel.center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 45);
}


#pragma mark - -- lazy loda --

- (UIImageView *)fllowersImageView{
    if (!_fllowersImageView) {
        _fllowersImageView = [[UIImageView alloc] init];
    }
    return _fllowersImageView;
}


- (UILabel *)describeLabel{
    if (!_describeLabel) {
        _describeLabel = [[UILabel alloc] init];
        _describeLabel.font = [UIFont fontWithName:@"DINCond-Medium" size:27];
        _describeLabel.textAlignment = NSTextAlignmentCenter;
        _describeLabel.textColor = [UIColor whiteColor];
    }
    return _describeLabel;
}

- (UILabel *)dayLabel{
    if (!_dayLabel) {
        _dayLabel = [[UILabel alloc] init];
        _dayLabel.font = [UIFont fontWithName:@"DINCond-Medium" size:45];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
        _dayLabel.textColor = [UIColor whiteColor];
    }
    return _dayLabel;
}

- (UILabel *)stateLabel{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.font = [UIFont fontWithName:@"DINCond-Medium" size:27];
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        _stateLabel.textColor = [UIColor whiteColor];
    }
    return _stateLabel;
}

@end



@implementation CalendarBottmLabelView

static NSInteger const LabelFontSize = 10;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    [self addSubview:self.label1];
    [self addSubview:self.label2];
    [self addSubview:self.label3];
    [self addSubview:self.label4];
    [self viewLayout];
}

- (void)viewLayout{
    CGFloat width = CGRectGetWidth(self.frame) / 4;
    CGFloat height = CGRectGetHeight(self.frame);
    _label1.frame = CGRectMake(width * 0, 0, width, height);
    _label2.frame = CGRectMake(width * 1, 0, width, height);
    _label3.frame = CGRectMake(width * 2, 0, width, height);
    _label4.frame = CGRectMake(width * 3, 0, width, height);
}

- (UILabel *)label1{
    if (!_label1) {
        _label1 = [[UILabel alloc] init];
        _label1.font = [UIFont systemFontOfSize:LabelFontSize];
        _label1.textAlignment = NSTextAlignmentCenter;
        _label1.text = @"Menstrual period";
        _label1.adjustsFontSizeToFitWidth = YES;
        _label1.textColor = [UIColor colorWithRed:0.99 green:0.80 blue:0.82 alpha:1.00];
    }
    return _label1;
}

- (UILabel *)label2{
    if (!_label2) {
        _label2 = [[UILabel alloc] init];
        _label2.font = [UIFont systemFontOfSize:LabelFontSize];
        _label2.textAlignment = NSTextAlignmentCenter;
        _label2.text = @"Forecast period";
        _label2.adjustsFontSizeToFitWidth = YES;
        _label2.textColor = [UIColor redColor];
    }
    return _label2;
}

- (UILabel *)label3{
    if (!_label3) {
        _label3 = [[UILabel alloc] init];
        _label3.font = [UIFont systemFontOfSize:LabelFontSize];
        _label3.textAlignment = NSTextAlignmentCenter;
        _label3.text = @"Ovulation";
        _label3.adjustsFontSizeToFitWidth = YES;
        _label3.textColor = [UIColor colorWithRed:0.51 green:0.30 blue:0.76 alpha:1.00];
    }
    return _label3;
}

- (UILabel *)label4{
    if (!_label4) {
        _label4 = [[UILabel alloc] init];
        _label4.font = [UIFont systemFontOfSize:LabelFontSize];
        _label4.textAlignment = NSTextAlignmentCenter;
        _label4.text = @"Ovulation day";
        _label4.adjustsFontSizeToFitWidth = YES;
        _label4.textColor = [UIColor colorWithRed:0.43 green:0.15 blue:0.71 alpha:1.00];
    }
    return _label4;
}

@end


@implementation HeaderInSectionView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    [self addSubview:self.calendarLabel];
    [self addSubview:self.stateLabel];
    
    [self viewLayout];
}

- (void)viewLayout{
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame) / 2;
    _calendarLabel.frame = CGRectMake(10, 10, width - 10, height - 10);
    _stateLabel.frame = CGRectMake(10, height, width - 10, height - 10);
}


- (UILabel *)calendarLabel{
    if (!_calendarLabel) {
        _calendarLabel = [[UILabel alloc] init];
        _calendarLabel.font = [UIFont systemFontOfSize:17];
        _calendarLabel.textAlignment = NSTextAlignmentLeft;
        _calendarLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _calendarLabel;
}

- (UILabel *)stateLabel{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.font = [UIFont systemFontOfSize:15];
        _stateLabel.textAlignment = NSTextAlignmentLeft;
        _stateLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _stateLabel;
}

@end


