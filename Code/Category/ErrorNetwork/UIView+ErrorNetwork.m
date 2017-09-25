//
//  UIView+ErrorNetwork.m
//  mj_noNet
//
//  Created by maoziyue on 2017/9/22.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import "UIView+ErrorNetwork.h"
#import <objc/runtime.h>
#import "Masonry.h"

#import "DejaNoNetworkView.h"
#import "DejaRequestErrorView.h"
#import "DejaNoDataView.h"




static char *dejErrorTypeKey        = "dejErrorTypeKey";
static char *dejNoNetworkViewKey    = "dejNoNetworkViewKey";
static char *dejRequestErrorViewKey = "dejRequestErrorViewKey";
static char *dejNoDataViewKey       = "dejNoDataViewKey";
static char *dejReloadCompletionKey = "dejReloadCompletionKey";



@implementation UIView (ErrorNetwork)


- (DejErrorType)errorType
{
    return [objc_getAssociatedObject(self, &dejErrorTypeKey) integerValue];
}

- (void)setErrorType:(DejErrorType)errorType
{
    
    NSLog(@"------errorType:%ld--------",errorType);
    
    
    if (self.dejRequestErrorView.superview) [self.dejRequestErrorView removeFromSuperview];
    if (self.dejNoDataView.superview)       [self.dejNoDataView removeFromSuperview];
    if (self.dejNoNetworkView.superview)    [self.dejNoNetworkView removeFromSuperview];
    
    if (errorType == DejErrorTypeNoNetwork)
    {
        
        [self addSubview:self.dejNoNetworkView];
        //self.dejNoNetworkView.frame = [[UIScreen mainScreen]bounds];
        [self.dejNoNetworkView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(self.mas_width);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(self.mas_height);
        }];
    }
    else if (errorType == DejErrorTypeRequest)
    {
        [self addSubview:self.dejRequestErrorView];
        
        //self.dejRequestErrorView.frame = [[UIScreen mainScreen]bounds];
        [self.dejRequestErrorView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(self.mas_width);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(self.mas_height);
        }];
    }
    else if (errorType == DejErrorTypeNoData)
    {
        [self addSubview:self.dejNoDataView];
        self.dejNoDataView.frame = [[UIScreen mainScreen]bounds];
        [self.dejNoDataView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(self.mas_width);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(self.mas_height);
        }];
    }
    else
    {
        
    }
    
    objc_setAssociatedObject(self, &dejErrorTypeKey, @(errorType), OBJC_ASSOCIATION_ASSIGN);

}



- (UIView *)dejNoNetworkView
{
    DejaNoNetworkView *aNoNetworkView = objc_getAssociatedObject(self, &dejNoNetworkViewKey);
    
    if (!aNoNetworkView) {
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        
        aNoNetworkView = [[DejaNoNetworkView alloc] initWithFrame:frame];
        
        __weak typeof(self) weakSelf = self;
        aNoNetworkView.reloadCompletion = ^{
            if (weakSelf.reloadCompletion) {
                weakSelf.reloadCompletion();
            }
        };

        self.dejNoNetworkView = aNoNetworkView;
    }
    return aNoNetworkView;
}

- (UIView *)dejRequestErrorView
{
    DejaRequestErrorView * aRequestErrorView = objc_getAssociatedObject(self, &dejRequestErrorViewKey);
    if (!aRequestErrorView) {
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        
        aRequestErrorView = [[DejaRequestErrorView alloc] initWithFrame:frame];
        
        self.dejRequestErrorView = aRequestErrorView;
    }
    return aRequestErrorView;
}

- (UIView *)dejNoDataView
{
    DejaNoDataView *aNoDataView = objc_getAssociatedObject(self, &dejNoDataViewKey);
    if (!aNoDataView) {
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        aNoDataView = [[DejaNoDataView alloc] initWithFrame:frame];
        self.dejNoDataView = aNoDataView;
    }
    return aNoDataView;
}

- (ReloadCompletion)reloadCompletion
{
    ReloadCompletion reloadCompletion = objc_getAssociatedObject(self, &dejReloadCompletionKey);
    return reloadCompletion;
}

- (void)setReloadCompletion:(ReloadCompletion)reloadCompletion
{
    objc_setAssociatedObject(self, &dejReloadCompletionKey, reloadCompletion, OBJC_ASSOCIATION_COPY);
}



- (void)setDejNoNetworkView:(UIView *)dejNoNetworkView
{
    if (dejNoNetworkView) {
        objc_setAssociatedObject(self, &dejNoNetworkViewKey, dejNoNetworkView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)setDejRequestErrorView:(UIView *)dejRequestErrorView
{
    if (dejRequestErrorView) {
        objc_setAssociatedObject(self, &dejRequestErrorViewKey, dejRequestErrorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)setDejNoDataView:(UIView *)dejNoDataView
{
    if (dejNoDataView) {
        objc_setAssociatedObject(self, &dejNoDataViewKey, dejNoDataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}











@end












