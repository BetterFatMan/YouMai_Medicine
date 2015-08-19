//
//  LeftViewController.h
//  MedicineCure
//
//  Created by line0 on 15/7/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICSDrawerController.h"

@interface LeftViewController : UIViewController<ICSDrawerControllerChild, ICSDrawerControllerPresenting>

@property(nonatomic, weak) ICSDrawerController *drawer;

@end
