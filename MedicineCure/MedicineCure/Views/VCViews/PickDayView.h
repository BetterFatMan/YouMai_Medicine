//
//  PickDayView.h
//  MedicineCure
//
//  Created by line0 on 15/8/4.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickDayView : UIView

@property(nonatomic, strong) UIDatePicker *dayView;

@property(nonatomic, copy)   void (^pickDayBlock)(NSDate *date);

- (void)addAnimation;
- (void)removeAnimations;

@end
