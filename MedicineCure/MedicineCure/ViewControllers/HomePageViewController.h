//
//  HomePageViewController.h
//  MedicineCure
//
//  Created by line0 on 15/7/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "BaseViewController.h"
#import "ICSDrawerController.h"

@interface HomePageViewController : BaseViewController<ICSDrawerControllerChild, ICSDrawerControllerPresenting>

@property(nonatomic, weak) ICSDrawerController *drawer;

@end
