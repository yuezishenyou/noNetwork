//
//  DejaNoDataView.m
//  mj_noNet
//
//  Created by maoziyue on 2017/9/22.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "DejaNoDataView.h"

@implementation DejaNoDataView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        NSLog(@"-----initWithFrame---DejaNoDataView----");
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(50, 100, 200, 40);
    
    btn.backgroundColor = [UIColor yellowColor];
    
    [btn setTitle:@"没有数据" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
    
    
    
}

- (void)btnAction
{
    NSLog(@"--------发送通知----------");
}










@end
