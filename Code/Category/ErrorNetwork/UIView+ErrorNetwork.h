//
//  UIView+ErrorNetwork.h
//  mj_noNet
//
//  Created by maoziyue on 2017/9/22.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, DejErrorType ) {

    DejErrorTypeDefalt,         //界面消失
    DejErrorTypeNoNetwork,      //没有网络
    DejErrorTypeRequest,        //请求接口 后台报错
    DejErrorTypeNoData,         //当前页面没有数据
};

typedef void(^ReloadCompletion)();

@interface UIView (ErrorNetwork)

//*********************** 设置 *************************

//@property(nonatomic, assign) BOOL isHiddenHeader;//遮挡navbar
//
//@property(nonatomic, assign) BOOL isHiddenFooter;//遮挡tabbar
//
//@property(nonatomic, assign) BOOL isHiddenAll;   //两都遮挡


// 设置页面显示的类型
@property(nonatomic, assign) DejErrorType errorType;


@property (nonatomic, copy) ReloadCompletion reloadCompletion;



/**
 *  没有网络时显示的视图
 */
@property(nonatomic, strong) UIView *dejNoNetworkView;

/**
 *  访问出错时显示的视图
 */
//@property(nonatomic, strong) UIView *dejRequestErrorView;

/**
 *  没有数据显示的视图
 */
//@property(nonatomic, strong) UIView *dejNoDataView;















@end
















