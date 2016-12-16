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
    
    _dayLabel.frame = CGRectMake(0, 0, 80, 80);
    _dayLabel.center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    // 这里用autolayout布局简直能飞起来
    // 添加高度约束:40
//    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:_describeLabel
//                                                                        attribute:NSLayoutAttributeHeight
//                                                                        relatedBy:NSLayoutRelationEqual
//                                                                           toItem:nil
//                                                                        attribute:NSLayoutAttributeNotAnAttribute
//                                                                       multiplier:0.0
//                                                                         constant:40];
    
    // 添加底部约束：_describeLabel的底部距离父控件底部 0 的间距
//    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:_describeLabel
//                                                                        attribute:NSLayoutAttributeBottom
//                                                                        relatedBy:NSLayoutRelationEqual
//                                                                           toItem:_dayLabel
//                                                                        attribute:NSLayoutAttributeTop
//                                                                       multiplier:1.0
//                                                                         constant:0];
    
//    [_describeLabel addConstraint:heightConstraint];
//    [_describeLabel addConstraint:bottomConstraint];
    
    
    
    _describeLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 40);
    _describeLabel.center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 40);
    
    _stateLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 40);
    _stateLabel.center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 40);
}

- (NSLayoutConstraint *)constraintWithItem:(id)selfView
                                 attribute:(NSLayoutAttribute)attr1
                                    toItem:(id)toView
                                 attribute:(NSLayoutAttribute)attr2
                                  constant:(CGFloat)value
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:selfView
                                                                     attribute:attr1
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:toView
                                                                     attribute:attr2
                                                                    multiplier:1.0
                                                                      constant:value];
    return constraint;
}


- (UIImageView *)fllowersImageView{
    if (!_fllowersImageView) {
        _fllowersImageView = [[UIImageView alloc] init];
    }
    return _fllowersImageView;
}


- (UILabel *)describeLabel{
    if (!_describeLabel) {
        _describeLabel = [[UILabel alloc] init];
        _describeLabel.font = [UIFont systemFontOfSize:20];
        _describeLabel.textAlignment = NSTextAlignmentCenter;
//        _describeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _describeLabel.textColor = [UIColor whiteColor];
    }
    return _describeLabel;
}

- (UILabel *)dayLabel{
    if (!_dayLabel) {
        _dayLabel = [[UILabel alloc] init];
        _dayLabel.font = [UIFont systemFontOfSize:35];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
        _dayLabel.textColor = [UIColor whiteColor];
    }
    return _dayLabel;
}

- (UILabel *)stateLabel{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.font = [UIFont systemFontOfSize:20];
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        _stateLabel.textColor = [UIColor whiteColor];
    }
    return _stateLabel;
}

@end
