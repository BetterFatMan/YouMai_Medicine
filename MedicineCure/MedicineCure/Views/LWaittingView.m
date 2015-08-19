//
//  LWaitingView.m
//  Line0New
//
//  Created by line0 on 13-4-28.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

#import "LWaittingView.h"

@interface LWaittingView ()
@property (strong, nonatomic) UIImageView   *imgView;

@end

@implementation LWaittingView

+ (id)sharedInstance
{
    static LWaittingView *waittingView = nil;
    if (!waittingView)
    {
        waittingView = [[LWaittingView alloc] init];
    }
    return waittingView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 64, kKeyWindow.width, kKeyWindow.height)];
    if (self)
    {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.15];
        self.hidden = YES;
        [appDelegate().window addSubview:self];
        
        CGRect rect = CGRectMake((self.width - 38)/2, 130 + (kKeyWindow.height > 500 ? kKeyWindow.height - 568 : 0), 38, 38);
        self.imgView = [[UIImageView alloc] initWithFrame:rect];
        self.imgView.image = UIImageByName(@"loading_icon_whitebg");
        [self.imgView startRotationAnimatingWithDuration:0.25];
        self.imgView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.imgView];
    }
    return self;
}

- (void)showWaittingView
{
    if (![appDelegate().window.subviews containsObject:self])
    {
        [appDelegate().window addSubview:self];
    }
    
    self.alpha = 0.0;
    self.hidden = NO;
    [UIView animateWithDuration:0.75 animations:^
    {
        self.alpha = 1.0;
    }];
}

- (void)hideWaittingView
{
    self.alpha = 1.0;
    [UIView animateWithDuration:0.75
                     animations:^{
                         self.alpha = 0.0;
    }
                     completion:^(BOOL finished)
    {
        self.hidden = YES;
        if ([appDelegate().window.subviews containsObject:self])
        {
            [self removeFromSuperview];
        }
    }];
}


@end
