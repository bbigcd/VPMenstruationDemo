//
//  DataModel.h
//  VPMenstruationDemo
//
//  Created by bbigcd on 2016/12/17.
//  Copyright © 2016年 bbigcd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property (nonatomic, copy) NSArray *datesWithEvent;// 单事件
@property (nonatomic, copy) NSArray *datesWithMultipleEvents;// 多重事件

@property (nonatomic, copy) NSArray *datesOfLastForecastPeriod;
@property (nonatomic, copy) NSArray *datesOfMenstrualPeriod;// 月经期
@property (nonatomic, copy) NSArray *datesOfForecastPeriod;// 预产下一月经期
@property (nonatomic, copy) NSArray *datesOfOvulation;// 排卵期
@property (nonatomic, copy) NSArray *datesOfOvulationDay;// 排卵日
@property (nonatomic, copy) NSArray *datesOfNextForecastPeriod;
@property (nonatomic, strong) NSMutableArray *iconImageArray;
@property (nonatomic, strong) NSMutableArray *titleLabelTextArray;
@property (nonatomic, copy) NSArray *titleLabelForBottomStateGuide;

@end
