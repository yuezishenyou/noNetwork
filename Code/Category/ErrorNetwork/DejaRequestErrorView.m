//
//  DejaRequestErrorView.m
//  mj_noNet
//
//  Created by maoziyue on 2017/9/22.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "DejaRequestErrorView.h"

@implementation DejaRequestErrorView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        [self setupUI];
        self.backgroundColor = [UIColor greenColor];
        
        NSLog(@"-----initWithFrame---DejaRequestErrorView----");
        //        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        //        [self addGestureRecognizer:tap];
    }
    return self;
}


- (void)setupUI
{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(50, 100, 200, 40);
    
    btn.backgroundColor = [UIColor orangeColor];
    
    [btn setTitle:@"没请求不正确" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
    
    
    
}

- (void)btnAction
{
    NSLog(@"--------发送通知----------");
}











@end
