//
//  BaseNavigationController.h
//  Line0new
//
//  Created by line0 on 15/6/4.
//  Copyright (c) 2015年 com.line0. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICSDrawerController.h"

@interface BaseNavigationController : UINavigationController<ICSDrawerControllerChild, ICSDrawerControllerPresenting>

@property(nonatomic, weak) ICSDrawerController *drawer;

@end
