//
//  FlipWindow.m
//  Line0new
//
//  Created by line0 on 15/1/29.
//  Copyright (c) 2015年 com.line0. All rights reserved.
//

#import "FlipWindow.h"

#define kBackBtnTag 8989
#define kFlipViewTag 1989

@interface FlipWindow ()
{
    
}

@property(nonatomic, strong) UIButton *flipBackBtn;
@property(nonatomic, strong) UIView   *currentView;

@property(nonatomic, assign) int       animationType;
@property(nonatomic, assign) BOOL      isGetSuccess;

@end

NSString*const kNoticeFlipWindowSetHide = @"NoticeFlipWindowToSetViewHide";

@implementation FlipWindow

- (void)dealloc
{
    self.hideBlock = nil;
    self.successHideViewBlock = nil;
    self.successShowSubBlock  = nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _flipBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_flipBackBtn addTarget:self action:@selector(dissMisFlipWindow:) forControlEvents:UIControlEventTouchUpInside];
        _flipBackBtn.tag = kBackBtnTag;
        [self addSubview:_flipBackBtn];
        
        [_flipBackBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_flipBackBtn]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_flipBackBtn)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_flipBackBtn]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_flipBackBtn)]];
    }
    return self;
}

+ (instancetype)showFlipWindowWithSubview:(UIView *)subView
{
    return [FlipWindow showFlipWindowWithSubview:subView animationType:0];
}

+ (instancetype)showFlipWindowWithSubview:(UIView *)subView animationType:(int)type
{
    FlipWindow *flipWindow = [[FlipWindow alloc] initWithFrame:CGRectMake(0, 0, kKeyWindow.width, kKeyWindow.height)];

    flipWindow.isNeedHideWhenTouch = YES;
    flipWindow.tag = kFlipViewTag;
    flipWindow.currentView = subView;
    [flipWindow addSubview:flipWindow.currentView];
    subView.center = flipWindow.center;
    flipWindow.isGetSuccess = YES;
    
    __weak typeof(flipWindow) _wflip = flipWindow;
    flipWindow.hideBlock = ^(BOOL isSuccess){
        _wflip.isGetSuccess = isSuccess;
        [_wflip removeFlipWindowAnimation];
    };
    [flipWindow bringSubviewToFront:subView];
    
    flipWindow.animationType = (type > 0 ? type : random()%kAnimationTypeCount+1);
    
    for (id subView in kKeyWindow.subviews) {
        if ([subView isKindOfClass:[FlipWindow class]])
        {
            FlipWindow *flip = (FlipWindow *)subView;
            if (flip.tag == kFlipViewTag)
            {
                [flip removeFromSuperview];
                break;
            }
        }
    }
    
    [kKeyWindow addSubview:flipWindow];
    [flipWindow addAnimationWithType:flipWindow.animationType];
    return flipWindow;
}

- (void)setBackBtnColor:(UIColor *)backBtnColor
{
    _backBtnColor = backBtnColor;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.56 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([self.flipBackBtn.layer animationForKey:@"animationBackColor"])
        {
            [self.flipBackBtn.layer removeAnimationForKey:@"animationBackColor"];
        }
        
        self.flipBackBtn.backgroundColor = backBtnColor;
    });
}

#pragma mark - UIButtonAction
- (void)dissMisFlipWindow:(id)sender
{
    if (self.isNeedHideWhenTouch)
    {
        [self removeFlipWindowAnimation];
    }
}

- (void)removeFlipWindowAnimation
{
    [self.flipBackBtn.layer removeAnimationForKey:@"animationBackColor"];
    if (_backBtnColor)
    {
        self.flipBackBtn.backgroundColor = [UIColor clearColor];
    }
    if (self.animationType == 1)
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
    else if (self.animationType == 2)
    {
        CGFloat pointX = self.currentView.layer.position.x;
        CGFloat pointY = self.currentView.layer.position.y;
        
        NSArray *frameValues = @[[NSValue valueWithCGPoint:CGPointMake(pointX, pointY)],
                                 [NSValue valueWithCGPoint:CGPointMake(pointX, 0.85 * pointY)],
                                 [NSValue valueWithCGPoint:CGPointMake(pointX, 1.4 * pointY)],
                                 [NSValue valueWithCGPoint:CGPointMake(pointX, kKeyWindow.height+pointY)]];
        NSArray *frameTimes = @[@(0.0), @(0.25), @(0.8), @(1.0)];
        
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        animation.values = frameValues;
        animation.keyTimes = frameTimes;
        
        CAKeyframeAnimation *animationT = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        animationT.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1)],
                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.6, 0.6, 1)]];
        animationT.keyTimes = @[@(0.1), @(0.45)];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.fillMode = kCAFillModeForwards;
        group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        group.removedOnCompletion = NO;
        group.duration = 0.55;
        group.delegate = self;
        
        group.animations = [NSArray arrayWithObjects:animation, animationT, nil];
        
        [self.layer addAnimation:group forKey:@"animationPopDown"];
    }
    else if (self.animationType == 3)
    {
        [self.layer removeAnimationForKey:@"animationPopUp"];
        
        NSArray *frameValues = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1)],
                                 [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.55, 0.55, 1)],
                                 [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.2, 0.2, 1)],
                                 [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01, 0.01, 1)]];
        NSArray *frameTimes = @[@(0.0), @(0.3), @(0.85), @(1.0)];
        
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        animation.values = frameValues;
        animation.keyTimes = frameTimes;
        
        CABasicAnimation *transition = [CABasicAnimation animationWithKeyPath:@"opacity"];
        transition.toValue = @0;
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.fillMode = kCAFillModeForwards;
        group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        group.removedOnCompletion = NO;
        group.duration = 0.55;
        group.delegate = self;
        group.animations = [NSArray arrayWithObjects:animation, transition, nil];
        
        [self.layer addAnimation:group forKey:@"animationPopDown"];
    }
    else
    {
        [self.layer removeAnimationForKey:@"animationPopUp"];
        
        CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        anima.values = @[[NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DMakeTranslation(0, 0, 0), 1.0, 1.0, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DMakeTranslation(0, 40, 0), 0.85, 0.85, 1.0)],
                         [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DMakeTranslation(0, 165, 0), 0.25, 0.25, 1.0)],
                         [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DMakeTranslation(0, 220, 0), 0.1, 0.1, 1.0)]];
        anima.keyTimes = @[@(0.0), @(0.3), @(0.85), @(1.0)];
        
        CABasicAnimation *transition = [CABasicAnimation animationWithKeyPath:@"opacity"];
        transition.toValue = @0;
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.fillMode = kCAFillModeForwards;
        group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        group.removedOnCompletion = NO;
        group.duration = 0.55;
        group.delegate = self;
        group.animations = [NSArray arrayWithObjects:anima, transition, nil];
        
        [self.layer addAnimation:group forKey:@"animationPopDown"];
    }
}

#pragma mark - Animation
- (void)addAnimationWithType:(int)type
{
    
    if (type == 1)
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
    else if (type == 2)
    {
        CGFloat pointX = self.currentView.layer.position.x;
        CGFloat pointY = self.currentView.layer.position.y;
        
        NSArray *frameValues = @[[NSValue valueWithCGPoint:CGPointMake(pointX, -pointY)],
                                 [NSValue valueWithCGPoint:CGPointMake(pointX, 0)],
                                 [NSValue valueWithCGPoint:CGPointMake(pointX, 1.2 * pointY)],
                                 [NSValue valueWithCGPoint:CGPointMake(pointX, pointY)]];
        NSArray *frameTimes = @[@(0.0), @(0.2), @(0.8), @(1.0)];
        
        CAKeyframeAnimation *animationP = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        
        animationP.values = frameValues;
        animationP.keyTimes = frameTimes;
        
        CAKeyframeAnimation *animationT = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        animationT.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.6, 0.6, 1)],
                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1)]];
        animationT.keyTimes = @[@(0.3), @(0.95)];
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.fillMode = kCAFillModeForwards;
        group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        group.removedOnCompletion = NO;
        group.duration = 0.55;
        group.delegate = self;
        
        group.animations = [NSArray arrayWithObjects:animationP, animationT, nil];
        
        [self.layer addAnimation:group forKey:@"animationPopUp"];
    }
    else if (type == 3)
    {
        [self.layer removeAllAnimations];
        
        NSArray *frameValues = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(2.1, 2.1, 1)],
                                 [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.65, 1.65, 1)],
                                 [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1)],
                                 [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1)]];
        NSArray *frameTimes = @[@(0.0), @(0.3), @(0.9), @(1.0)];
        
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        animation.values = frameValues;
        animation.keyTimes = frameTimes;
        
        CABasicAnimation *transition = [CABasicAnimation animationWithKeyPath:@"opacity"];
        transition.fromValue = @0;
        transition.toValue = @1;
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.fillMode = kCAFillModeForwards;
        group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        group.removedOnCompletion = NO;
        group.duration = 0.55;
        group.delegate = self;
        group.animations = [NSArray arrayWithObjects:animation, transition, nil];
        
        [self.layer addAnimation:group forKey:@"animationPopUp"];
    }
    else
    {
        [self.layer removeAnimationForKey:@"animationPopDown"];
        
        CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        anima.values = @[[NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DMakeTranslation(0, 220, 0), 0.3, 0.3, 1)],
                         [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DMakeTranslation(0, 150, 0), 0.55, 0.55, 1.0)],
                         [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DMakeTranslation(0, 35, 0), 0.9, 0.9, 1.0)],
                         [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DMakeTranslation(0, 0, 0), 1.0, 1.0, 1.0)]];
        anima.keyTimes = @[@(0.0), @(0.3), @(0.85), @(1.0)];
        anima.fillMode = kCAFillModeForwards;
        anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        anima.removedOnCompletion = NO;
        anima.duration = 0.55;
        anima.delegate = self;
        
        [self.layer addAnimation:anima forKey:@"animationPopUp"];
    }
}

#pragma mark - 
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (anim == [self.layer animationForKey:@"animationPopUp"])
    {
        CABasicAnimation *baseAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
        baseAnimation.fromValue = (id)UICOLOR_RGBA(0, 0, 0, 0).CGColor;
        baseAnimation.toValue   = (id)UICOLOR_RGBA(0, 0, 0, 0.4).CGColor;
        baseAnimation.duration  = 0.25;
        baseAnimation.removedOnCompletion = NO;
        baseAnimation.fillMode  = kCAFillModeForwards;
        baseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        [self.flipBackBtn.layer addAnimation:baseAnimation forKey:@"animationBackColor"];
        
        if (self.successShowSubBlock)
        {
                /// 页面弹出成功
            self.successShowSubBlock();
        }
    }
    else if (anim == [self.layer animationForKey:@"animationPopDown"])
    {
        if (_isGetSuccess)
        {
            if (_successHideViewBlock)
            {
                _successHideViewBlock();
            }
        }
        
        if (self && [self isKindOfClass:[UIView class]])
        {
            [self removeFromSuperview];
        }
    }
        
}

@end
