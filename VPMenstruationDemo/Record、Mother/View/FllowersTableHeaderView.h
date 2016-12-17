//
//  FllowersTableHeaderView.h
//  VPMenstruationDemo
//
//  Created by bbigcd on 2016/12/16.
//  Copyright © 2016年 bbigcd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FllowersTableHeaderView : UIView

@property (nonatomic, strong) UIImageView *fllowersImageView;

@property (nonatomic, strong) UILabel *describeLabel;
@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, strong) UILabel *stateLabel;

@end


@interface CalendarBottmLabelView : UIView

@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label3;
@property (nonatomic, strong) UILabel *label4;

@end

@interface HeaderInSectionView : UIView

@property (nonatomic, strong) UILabel *calendarLabel;
@property (nonatomic, strong) UILabel *stateLabel;

@end

