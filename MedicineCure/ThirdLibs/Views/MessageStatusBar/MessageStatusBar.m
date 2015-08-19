//
//  CustomStatueBar.m
//  CustomStatueBar
//
//  Created by 贺 坤 on 12-5-21.
//  Copyright (c) 2012年 深圳市瑞盈塞富科技有限公司. All rights reserved.
//

#import "MessageStatusBar.h"

@implementation MessageStatusBar

+ (MessageStatusBar *)sharedInstance
{
    MessageStatusBar *messageStatusBar = nil;
    if (!messageStatusBar)
    {
        messageStatusBar = [[MessageStatusBar alloc] init];
    }
    return messageStatusBar;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.windowLevel = UIWindowLevelStatusBar + 1.0f;
		self.frame = [UIApplication sharedApplication].statusBarFrame;
        self.backgroundColor = [UIColor darkTextColor];
        
        self.messageLbl = [[BBCyclingLabel alloc]initWithFrame:[UIApplication sharedApplication].statusBarFrame andTransitionType:BBCyclingLabelTransitionEffectScrollUp];
        self.messageLbl.backgroundColor = [UIColor clearColor];
        self.messageLbl.clipsToBounds = YES;
        self.messageLbl.textAlignment = NSTextAlignmentCenter;
        self.messageLbl.adjustsFontSizeToFitWidth = YES;
        [self.messageLbl setText:@"" animated:NO];
        self.messageLbl.transitionDuration = 0.75;
        self.messageLbl.font = [UIFont systemFontOfSize:15];
        self.messageLbl.textColor = [UIColor whiteColor];
        [self addSubview:self.messageLbl];
    }
    return self;
}

- (void)show
{
    self.hidden = NO;
    [UIView animateWithDuration:0.5f
                     animations:^
    {
        self.alpha = 1.0;
    }
                     completion:^(BOOL finished)
    {
    }];
}

- (void)hide
{
    [UIView animateWithDuration:0.5f
                     animations:^
    {
        self.alpha = 0.0f;
    }
                     completion:^(BOOL finished)
    {
        self.hidden = YES;
    }];
}

- (void)updateStatusMessage:(NSString *)message
{
    [self show];
    [self.messageLbl setText:message animated:YES];
}


@end
