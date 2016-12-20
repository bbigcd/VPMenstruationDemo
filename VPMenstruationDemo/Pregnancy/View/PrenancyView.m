//
//  PrenancyView.m
//  VPMenstruationDemo
//
//  Created by bbigcd on 2016/12/19.
//  Copyright © 2016年 bbigcd. All rights reserved.
//

#import "PrenancyView.h"

@implementation PrenancyView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}


- (void)setupViews{
    UIScrollView *scrollView = ({
        UIScrollView *view = [UIScrollView new];
        [self addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);//.insets(UIEdgeInsetsMake(50, 20, 50, 20))
        }];
        view.backgroundColor = [UIColor lightGrayColor];
        
        view;
    });
    /** 一个view容器，提高代码的重用性*/
    UIView *container = ({
        UIView *view = [UIView new];
        [scrollView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(scrollView);
        }];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    
    
    CGSize size = CGSizeMake(80, 80);
    
    UIView *v1 = ({
        UIView *view = [UIView new];
        [scrollView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(size);
        }];
        view.backgroundColor = [UIColor redColor];
        view;
    });
    UIView *v2 = ({
        UIView *view = [UIView new];
        [scrollView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(size);
            make.left.equalTo(v1.mas_right);
            make.top.equalTo(v1.mas_bottom);
        }];
        view.backgroundColor = [UIColor yellowColor];
        view;
    });
    UIView *v3 = ({
        UIView *view = [UIView new];
        [scrollView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(size);
            make.right.equalTo(v2.mas_left);
            make.top.equalTo(v2.mas_bottom);
        }];
        view.backgroundColor = [UIColor greenColor];
        view;
    });
    UIView *v4 = ({
        UIView *view = [UIView new];
        [scrollView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(size);
            make.right.equalTo(v3.mas_left);
            make.top.equalTo(v3.mas_bottom);
        }];
        view.backgroundColor = [UIColor blueColor];
        view;
    });
    UIView *v5 = ({
        UIView *view = [UIView new];
        [scrollView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(size);
            make.left.equalTo(v4.mas_right);
            make.top.equalTo(v4.mas_bottom);
        }];
        view.backgroundColor = [UIColor brownColor];
        view;
    });
    
    [container mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(v4.mas_left);
        make.top.equalTo(v1.mas_top);
        make.right.equalTo(v2.mas_right);
        make.bottom.equalTo(v5.mas_bottom);
    }];
}


@end
