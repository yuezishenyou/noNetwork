//
//  DejaNoNetworkView.m
//  mj_noNet
//
//  Created by maoziyue on 2017/9/22.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "DejaNoNetworkView.h"

@implementation DejaNoNetworkView
{
    CGFloat width ;
    CGFloat height;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        width = [[UIScreen mainScreen]bounds].size.width;
        height = [[UIScreen mainScreen]bounds].size.height;
        [self setupUI];
        self.backgroundColor = [UIColor whiteColor];
        NSLog(@"-----initWithFrame---DejaNoNetworkView----");
        //UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        //[self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setupUI
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake((width - 200)/2, (height - 40)/2, 200, 40);
    
    btn.backgroundColor = [UIColor blackColor];
    
    [btn setTitle:@"没有网络" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];

}

- (void)btnAction
{
    if (_reloadCompletion) {
        _reloadCompletion();
    }
}








@end
