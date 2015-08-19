//
//  FlipWindow.h
//  Line0new
//
//  Created by line0 on 15/1/29.
//  Copyright (c) 2015年 com.line0. All rights reserved.
//  弹窗

#import <UIKit/UIKit.h>

#define kAnimationTypeCount   4

@interface FlipWindow : UIView

    /// default is Yes,点击外框的黑色区域，页面消失；No 点击不消失
@property(nonatomic, assign) BOOL  isNeedHideWhenTouch;

@property(nonatomic, copy) void (^successShowSubBlock)(void);// 整个页面加载显示成功之后
@property(nonatomic, copy) void (^successHideViewBlock)();//成功隐藏view且isSuccess ＝ yes
@property(nonatomic, copy) void (^hideBlock)(BOOL isSuccess);

+ (instancetype)showFlipWindowWithSubview:(UIView *)subView;

+ (instancetype)showFlipWindowWithSubview:(UIView *)subView animationType:(int)type;

@property(nonatomic, strong) UIColor *backBtnColor;

@end
