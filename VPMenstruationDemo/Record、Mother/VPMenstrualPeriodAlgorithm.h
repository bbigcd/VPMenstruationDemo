//
//  VPMenstrualPeriodAlgorithm.h
//  VPMenstruationDemo
//
//  Created by bbigcd on 2016/12/20.
//  Copyright © 2016年 bbigcd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VPMenstrualPeriodAlgorithm : NSObject

/**
 获取预测经期算法

 @param date 选中的经期开始日
 @param cycleDay 经期间隔天数
 @param periodLength 经期持续天数
 @return 各个预测经期
 */
+ (NSArray<NSDate *> *)vp_GetMenstrualPeriodWithDate:(NSDate *)date CycleDay:(NSInteger)cycleDay PeriodLength:(NSInteger)periodLength;

/**
 获取预测排卵日算法
 
 @param date 选中的经期开始日
 @param cycleDay 经期间隔天数
 @param periodLength 经期持续天数
 @return 各个排卵日
 */
+ (NSArray<NSDate *> *)vp_GetOvulationDayWithDate:(NSDate *)date CycleDay:(NSInteger)cycleDay PeriodLength:(NSInteger)periodLength;

/**
 获取预测排卵期算法
 选中的经期开始日->调用vp_GetOvulationDayWithDate算出排卵日
 排卵日前5后4+排卵日为排卵期
 
 @param date 选中的经期开始日
 @param cycleDay 经期间隔天数
 @param periodLength 经期持续天数
 @return 各个排卵期
 */
+ (NSArray<NSDate *> *)vp_GetOvulationWithDate:(NSDate *)date CycleDay:(NSInteger)cycleDay PeriodLength:(NSInteger)periodLength;



@end
