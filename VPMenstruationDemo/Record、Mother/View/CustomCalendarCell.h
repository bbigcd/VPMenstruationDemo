//
//  CustomCalendarCell.h
//  VPMenstruationDemo
//
//  Created by bbigcd on 2016/12/15.
//  Copyright © 2016年 bbigcd. All rights reserved.
//

#import "FSCalendarCell.h"

// 选中枚举
typedef NS_ENUM(NSUInteger, SelectionType) {
    SelectionTypeNone,
    SelectionTypeSingle,
    SelectionTypeLeftBorder,
    SelectionTypeMiddle,
    SelectionTypeRightBorder
};

@interface CustomCalendarCell : FSCalendarCell

// 选中的layer
@property (nonatomic, weak) CAShapeLayer *selectionLayer;

// 当天的layer
@property (nonatomic, weak) CAShapeLayer *todayLayer;
// 排卵日layer
@property (nonatomic, weak) CAShapeLayer *ovulationDayLayer;

// 选中日期的位置
@property (nonatomic, assign) SelectionType selectionType;

@end
