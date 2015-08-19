//
//  MCCalendarView.m
//  MedicineCure
//
//  Created by line0 on 15/8/3.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "MCCalendarView.h"

@interface MCCalendarView ()

@property(strong,nonatomic)UIView* weekNameView;
@property(weak,nonatomic)LKCalendarDayView* lastSelectedDayView;

@end

@implementation MCCalendarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = kAppBgColor;//[UIColor whiteColor];
        
        self.weekNameView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 30)];
        [self addSubview:_weekNameView];
        
        _calendarView = [[LKCalendarView alloc] initWithFrame:CGRectMake(0, self.weekNameView.bottom, frame.size.width, frame.size.height - 30)];
        [self initCalendarViewData];
        [self addSubview:_calendarView];
    }
    return self;
}

- (void)initCalendarViewData
{
    [self createWeekName:0];
    
    _calendarView.currentDateComponents = getYearMonthDateComponents([NSDate date]);
    [_calendarView startLoadingView];
}


-(void)createWeekName:(int)tag
{
    NSMutableArray* array = [NSMutableArray arrayWithArray:@[@"日",@"一",@"二",@"三",@"四",@"五",@"六"]];
    
    NSMutableArray* showArray = [NSMutableArray array];
    int index = tag;
    while (showArray.count<7) {
        [showArray addObject:[array objectAtIndex:index%7]];
        index ++;
    }
    
    while (_weekNameView.subviews.count) {
        [[_weekNameView.subviews objectAtIndex:0] removeFromSuperview];
    }
    
    _calendarView.leftMonth.firstDayWeek = tag;
    _calendarView.centerMonth.firstDayWeek = tag;
    _calendarView.rightMonth.firstDayWeek = tag;
    
    int i =0;
    for (NSString* title in showArray) {
        UILabel* lb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20,14)];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.center = CGPointMake(SYCC_DayOffsetWidth + (SYCC_DayOffsetWidth+SYCC_DayWidth)*i  + SYCC_DayWidth/2, 30/2) ;
        lb.backgroundColor = [UIColor clearColor];
        lb.font = [UIFont systemFontOfSize:12];
        if([title isEqualToString:@"六"] || [title isEqualToString:@"日"])
        {
            lb.textColor = [UIColor redColor];
        }
        else
        {
            lb.textColor = [UIColor blackColor];
        }
        lb.text = title;
        [_weekNameView addSubview:lb];
        i++;
    }
}
@end
