//
//  CustomCalendarCell.m
//  VPMenstruationDemo
//
//  Created by bbigcd on 2016/12/15.
//  Copyright © 2016年 bbigcd. All rights reserved.
//

#import "CustomCalendarCell.h"
#import "FSCalendarExtensions.h"

@implementation CustomCalendarCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CAShapeLayer *selectionLayer = [[CAShapeLayer alloc] init];
        selectionLayer.fillColor = [UIColor colorWithHue:0.52 saturation:0.70 brightness:0.86 alpha:1.00].CGColor;
        selectionLayer.actions = @{@"hidden":[NSNull null]};
        [self.contentView.layer insertSublayer:selectionLayer below:self.titleLabel.layer];
        self.selectionLayer = selectionLayer;
        
        
        CAShapeLayer *ovulationDayLayer = [[CAShapeLayer alloc] init];
        ovulationDayLayer.fillColor = [UIColor colorWithHue:0.75 saturation:0.80 brightness:0.71 alpha:1.00].CGColor;
        ovulationDayLayer.actions = @{@"hidden":[NSNull null]};
        [self.contentView.layer insertSublayer:ovulationDayLayer below:selectionLayer];
        self.ovulationDayLayer = ovulationDayLayer;
        
        CAShapeLayer *todayLayer = [[CAShapeLayer alloc] init];
        todayLayer.fillColor = [UIColor redColor].CGColor;
        todayLayer.actions = @{@"hidden":[NSNull null]};
        [self.contentView.layer insertSublayer:todayLayer below:ovulationDayLayer];
        self.todayLayer = todayLayer;
        
        
        self.todayLayer.hidden = YES;
        self.shapeLayer.hidden = YES;
        self.ovulationDayLayer.hidden = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.backgroundView.frame = CGRectInset(self.bounds, -1, 0.5);// 调整背景的frame
//    self.selectionLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 10);
    // 重写各个日期的布局
    self.titleLabel.frame = CGRectMake(0, 0, 20, 20);
    self.titleLabel.center = CGPointMake(self.fs_width / 2, 15);
    
//    self.selectionLayer.frame = self.titleLabel.frame;
//    self.selectionLayer.position = CGPointMake(self.fs_width / 2, 15);
    
    self.todayLayer.frame = CGRectMake(0, 0, 30, 30);
//    self.todayLayer.position = CGPointMake(self.fs_width / 2, 15);
    
    CGFloat diameter1 = MIN(self.todayLayer.fs_height, self.todayLayer.fs_width);
//    self.todayLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.contentView.fs_width/2-diameter1/2, self.contentView.fs_height/2-diameter1/2, diameter1, diameter1)].CGPath;
    self.todayLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.contentView.fs_width/2-diameter1/2, self.contentView.fs_height/2-18, diameter1, diameter1)].CGPath;
    
    self.ovulationDayLayer.frame = CGRectMake(0, 0, 20, 20);
    CGFloat diameter2 = MIN(self.ovulationDayLayer.fs_height, self.ovulationDayLayer.fs_width);
    self.ovulationDayLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.contentView.fs_width/2-diameter2/2, self.contentView.fs_height/2-13, diameter2, diameter2)].CGPath;
    
    
    if (self.selectionType == SelectionTypeMiddle) {
        self.selectionLayer.path = [UIBezierPath bezierPathWithRect:self.selectionLayer.bounds].CGPath;
    }
    else if (self.selectionType == SelectionTypeLeftBorder)
    {
        self.selectionLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.selectionLayer.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft cornerRadii:CGSizeMake(self.selectionLayer.fs_width/2, self.selectionLayer.fs_width/2)].CGPath;
    }
    else if (self.selectionType == SelectionTypeRightBorder)
    {
        self.selectionLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.selectionLayer.bounds byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomRight cornerRadii:CGSizeMake(self.selectionLayer.fs_width/2, self.selectionLayer.fs_width/2)].CGPath;
    }
    else if (self.selectionType == SelectionTypeSingle)
    {
        CGFloat diameter = MIN(self.selectionLayer.fs_height, self.selectionLayer.fs_width);
        self.selectionLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.contentView.fs_width/2-diameter/2, self.contentView.fs_height/2-diameter/2, diameter, diameter)].CGPath;
    }
}

- (void)setSelectionType:(SelectionType)selectionType
{
    if (_selectionType != selectionType) {
        _selectionType = selectionType;
        [self setNeedsLayout];
    }
}

@end
