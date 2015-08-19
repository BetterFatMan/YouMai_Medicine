//
//  PickDayView.m
//  MedicineCure
//
//  Created by line0 on 15/8/4.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "PickDayView.h"

@interface PickDayView ()
{
    
}

@end

@implementation PickDayView

- (void)dealloc
{
    _pickDayBlock = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        UIButton *comfirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        comfirmBtn.frame = CGRectMake(3, 219, frame.size.width - 6, 30);
        comfirmBtn.backgroundColor = kLightBlueColor;
        comfirmBtn.layer.borderColor = kAppBgColor.CGColor;
        comfirmBtn.layer.borderWidth = 0.5;
        comfirmBtn.layer.cornerRadius = 3.5;
        comfirmBtn.clipsToBounds      = YES;
        comfirmBtn.titleLabel.font = gFontSystemSize(16);
        [comfirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [comfirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [self addSubview:comfirmBtn];
        [comfirmBtn addTarget:self action:@selector(comfirmDate:) forControlEvents:UIControlEventTouchUpInside];
        
        _dayView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        _dayView.backgroundColor = [UIColor whiteColor];
        _dayView.datePickerMode = UIDatePickerModeDate;
        [self addSubview:_dayView];
    }
    return self;
}

- (void)comfirmDate:(id)sender
{
    if (_pickDayBlock)
    {
        _pickDayBlock(_dayView.date);
        [self removeAnimations];
    }
}

- (void)addAnimation
{
    NSArray *frameValues = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.35, 1.35, 1)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1)]];
    NSArray *frameTimes = @[@(0.0), @(0.5), @(0.9), @(1.0)];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.values = frameValues;
    animation.keyTimes = frameTimes;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.removedOnCompletion = NO;
    animation.duration = 0.55;
    animation.delegate = self;
    
    [self.layer addAnimation:animation forKey:@"animationPopUp"];
}

- (void)removeAnimations
{
    NSArray *frameValues = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.85, 0.85, 1)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.05, 0.05, 1)]];
    NSArray *frameTimes = @[@(0.0), @(0.3), @(0.8), @(1.0)];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.values = frameValues;
    animation.keyTimes = frameTimes;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.removedOnCompletion = NO;
    animation.duration = 0.35;
    animation.delegate = self;
    
    [self.layer addAnimation:animation forKey:@"animationPopDown"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (anim == [self.layer animationForKey:@"animationPopUp"])
    {
        [self.layer removeAnimationForKey:@"animationPopUp"];
    }
    else if (anim == [self.layer animationForKey:@"animationPopDown"])
    {
        [self.layer removeAnimationForKey:@"animationPopDown"];
        
        [self removeFromSuperview];
    }
    
}

@end
