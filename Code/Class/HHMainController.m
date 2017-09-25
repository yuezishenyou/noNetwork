//
//  HHMainController.m
//  mj_noNet
//
//  Created by maoziyue on 2017/9/22.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "HHMainController.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "UIScrollView+Refresh.h"
#import "UIView+ErrorNetwork.h"
#import "HHDetailController.h"


@interface HHMainController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong)UITableView *tbView;

@property (nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation HHMainController
{
    CGFloat width ;
    CGFloat height;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"mao";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    width = [[UIScreen mainScreen]bounds].size.width;
    
    height = [[UIScreen mainScreen]bounds].size.height;
    
    
    self.dataSource = [[NSMutableArray alloc]init];
    
    [self initSubView];
    
    
    [self setupRefresh];
    
    [self.tbView.mj_header beginRefreshing];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadData) name:@"NONETWORKNOTIFICATION" object:nil];
    
}
- (void)reloadData
{
    NSLog(@"---没有网络------");
    self.view.errorType = DejErrorTypeDefalt;
    [self loadData];
}


- (void)setupRefresh
{
    self.tbView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tbView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}



- (void)loadNewData
{
    [self loadData];
}


- (void)loadMoreData
{
    [self loadData];
    
}



- (void)loadData
{
    [[AFHTTPSessionManager manager]GET:@"http://api.mglife.me/v2/home/0" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.view.errorType = DejErrorTypeDefalt;
        
        NSArray *array = responseObject[@"data"][@"home_list"];
        if (self.dataSource.count > 0) {
            [self.dataSource removeAllObjects];
        }
        
        [self.dataSource addObjectsFromArray:array];
        
        NSLog(@"----成功:%ld-------",self.dataSource.count);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tbView reloadData];
        });
        
        [self.tbView.mj_header endRefreshing];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"------失败:%@-------",error);
        self.view.errorType = DejErrorTypeNoNetwork;
        [self.tbView.mj_header endRefreshing];
    
    }];
}






- (void)initSubView
{
    self.tbView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, width, height - 64) style:0];
    
    self.tbView.delegate = self;
    
    self.tbView.dataSource = self;
    
    [self.view addSubview:self.tbView];
    
    __weak typeof(self) weakSelf = self;
    self.view.reloadCompletion = ^{
    
        NSLog(@"---abc----");
        [weakSelf reloadData];
    };
    
}


#pragma mark --mark
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"--abc-%ld-",indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HHDetailController *vc = [[HHDetailController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)dealloc
{
    NSLog(@"---释放--");
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"NONETWORKNOTIFICATION" object:nil];
}





@end

















