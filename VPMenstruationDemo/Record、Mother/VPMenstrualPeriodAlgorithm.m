//
//  VPMenstrualPeriodAlgorithm.m
//  VPMenstruationDemo
//
//  Created by bbigcd on 2016/12/20.
//  Copyright © 2016年 bbigcd. All rights reserved.
//

#import "VPMenstrualPeriodAlgorithm.h"

@implementation VPMenstrualPeriodAlgorithm

// 用来计算多少个经期
static NSInteger const MenstrualCycleTimes = 180;

// 经期
+ (NSArray<NSDate *> *)vp_GetMenstrualPeriodWithDate:(NSDate *)date CycleDay:(NSInteger)cycleDay PeriodLength:(NSInteger)periodLength
{
    NSMutableArray *array = [NSMutableArray array];
    if (cycleDay == 0 || periodLength == 0 || date == nil) {
        return nil;
    }
    // 公历
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    // 当前月经期
    for (NSInteger j = 0; j < MenstrualCycleTimes; j ++)
    {
        for (NSInteger i = 0; i < periodLength; i ++)
        {
            NSInteger nextPeriod = j * cycleDay;
            NSDate *nextDate = [gregorian dateByAddingUnit:NSCalendarUnitDay
                                                     value:i + nextPeriod
                                                    toDate:date
                                                   options:0];
            if (![array containsObject:nextDate])
            {
                [array addObject:nextDate];
            }
        }
    }
    
    return [array copy];
}


// 排卵日
+ (NSArray<NSDate *> *)vp_GetOvulationDayWithDate:(NSDate *)date CycleDay:(NSInteger)cycleDay PeriodLength:(NSInteger)periodLength
{
    NSMutableArray *array = [NSMutableArray array];
    // 公历
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    for (NSInteger j = 1; j <= MenstrualCycleTimes; j ++)
    {
        NSInteger nextPeriod = j * cycleDay;
        
        NSDate *nextDate = [gregorian dateByAddingUnit:NSCalendarUnitDay
                                                 value:nextPeriod
                                                toDate:date
                                               options:0];
        NSDate *ovulationDay = [gregorian dateByAddingUnit:NSCalendarUnitDay
                                                     value:- 14
                                                    toDate:nextDate
                                                   options:0];
        if (![array containsObject:ovulationDay])
        {
            [array addObject:ovulationDay];
        }
    }
    
    return [array copy];
}

// 排卵期
+ (NSArray<NSDate *> *)vp_GetOvulationWithDate:(NSDate *)date CycleDay:(NSInteger)cycleDay PeriodLength:(NSInteger)periodLength
{
    NSMutableArray *array = [NSMutableArray array];
    NSArray *ovulationDayArray = [VPMenstrualPeriodAlgorithm vp_GetOvulationDayWithDate:date CycleDay:cycleDay PeriodLength:periodLength];
    
    if (cycleDay == 0 || periodLength == 0 ||
        date == nil || ovulationDayArray.count == 0)
    {
        return nil;
    }
    
    // 公历
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    for (NSInteger j = 0; j < ovulationDayArray.count; j ++)
    {
        NSDate *ovulationDay = ovulationDayArray[j];
        // 前5后4+当天
        for (NSInteger i = -5; i < 5; i ++)
        {
            NSDate *nextDate = [gregorian dateByAddingUnit:NSCalendarUnitDay
                                                     value:i
                                                    toDate:ovulationDay
                                                   options:0];
            if (![array containsObject:nextDate])
            {
                [array addObject:nextDate];
            }
        }
    }
    
    return [array copy];
}



@end
