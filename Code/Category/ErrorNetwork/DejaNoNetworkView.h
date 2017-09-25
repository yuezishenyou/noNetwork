//
//  DejaNoNetworkView.h
//  mj_noNet
//
//  Created by maoziyue on 2017/9/22.
//  Copyright © 2017年 maoziyue. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ReloadCompletion)();

@interface DejaNoNetworkView : UIView

@property (nonatomic,copy)ReloadCompletion reloadCompletion;

@end
