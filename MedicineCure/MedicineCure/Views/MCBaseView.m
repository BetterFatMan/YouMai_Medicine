//
//  MCBaseView.m
//  MedicineCure
//
//  Created by line0 on 15/8/4.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "MCBaseView.h"

@implementation MCBaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panMCBaseView:)]];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMCBaseView:)]];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)panMCBaseView:(UIPanGestureRecognizer *)gesture
{
    
}

- (void)tapMCBaseView:(UIPanGestureRecognizer *)gesture
{
    
}

@end
