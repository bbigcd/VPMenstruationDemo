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
@property (weak, nonatomic) CAShapeLayer *selectionLayer;

// 选中日期的位置
@property (assign, nonatomic) SelectionType selectionType;

@end
