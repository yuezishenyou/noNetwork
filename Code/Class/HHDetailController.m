//
//  HHDetailController.m
//  mj_noNet
//
//  Created by maoziyue on 2017/9/24.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHDetailController.h"
#import "AFNetworking.h"
#import "UIView+ErrorNetwork.h"

@interface HHDetailController ()

@end

@implementation HHDetailController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"detail";
    
    
    [self initSubViews];
    
    [self initData];
    
    //[self loadData];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadData) name:@"NONETWORKNOTIFICATION" object:nil];
    
    __weak typeof(self) weakSelf = self;
    self.view.reloadCompletion = ^{
        
        NSLog(@"---detail reload----");
        [weakSelf reloadData];
    };
    
}

- (void)reloadData
{
    NSLog(@"重新请求");
    [self loadData];
}

- (void)initData
{
    
}


- (void)initSubViews
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"请求" style:UIBarButtonItemStyleDone target:self action:@selector(rightAction)];
    
}

- (void)rightAction
{
    [self loadData];
}


- (void)loadData
{
    
    [[AFHTTPSessionManager manager]GET:@"http://api.mglife.me/v2/home/0" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.view.errorType = DejErrorTypeDefalt;
        
        NSArray *array = responseObject[@"data"][@"home_list"];
        NSLog(@"------count:%ld-----",array.count);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"-----错误-----");
        self.view.errorType = DejErrorTypeNoNetwork;
    }];
}


- (void)dealloc
{
    NSLog(@"---释放---");
}



@end















