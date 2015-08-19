//
//  SettingInfoVC.m
//  MedicineCure
//
//  Created by line0 on 15/7/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "SettingInfoVC.h"

@interface SettingInfoVC ()
{
    
}

@end

@implementation SettingInfoVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"设置";
    [self addViewSubs];
}

#pragma mark - ViewSubs
- (void)addViewSubs
{
    UIButton *backBtn           = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame               = CGRectMake(0, 20, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.leftBtn = backBtn;
}

- (void)backBtnClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
