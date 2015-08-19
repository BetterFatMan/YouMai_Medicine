//
//  SYCalendarDayView.m
//  Seeyou
//
//  Created by upin on 13-10-22.
//  Copyright (c) 2013年 linggan. All rights reserved.
//

#import "LKCalendarDayView.h"
#import "LKCalendarDefine.h"

@interface LKCalendarDayView()
@property(weak,nonatomic)UIImageView* selectedView;
@end

@implementation LKCalendarDayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroupView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.backgroupView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_backgroupView];
        
        self.lb_date = [[UILabel alloc]initWithFrame:CGRectMake((frame.size.width - 32)/2,(frame.size.height - 26)/2, 32, 20)];
        _lb_date.backgroundColor = [UIColor clearColor];
        _lb_date.textColor = kLBBlackColor;
        _lb_date.font = [UIFont systemFontOfSize:20];
        _lb_date.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lb_date];
        
        _lb_point = [[UIView alloc] initWithFrame:CGRectMake((frame.size.width - 3)/2, _lb_date.bottom + 3, 3, 3)];
        _lb_point.backgroundColor = kPaysRedColor;
        _lb_point.layer.cornerRadius = 1.5;
        _lb_point.clipsToBounds      = YES;
        [self addSubview:_lb_point];
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.selected = YES;
    if([self.delegate respondsToSelector:@selector(calendarDayViewWillSelected:)])
    {
       [self.delegate calendarDayViewWillSelected:self];
    }
}
-(void)setDate:(NSDate *)date
{
    _date = [date copy];
    NSDateComponents* dateComponents = [currentLKCalendar components:NSDayCalendarUnit fromDate:_date];
    _lb_date.text = [NSString stringWithFormat:@"%ld",dateComponents.day];
}
-(void)setSelected:(BOOL)selected
{
    _selected = selected;
    if(_selected)
    {
        if(self.selectedView == nil)
        {
            UIImageView* maskview = [[UIImageView alloc]initWithFrame:self.bounds];
            UIImage* maskImage =  [UIImage imageNamed:@"c_seletebox"];
            maskview.image = [maskImage stretchableImageWithLeftCapWidth:maskImage.size.width/2 topCapHeight:maskImage.size.height/2];
            [self addSubview:maskview];
            self.selectedView = maskview;
        }
    }
    else
    {
        [self.selectedView removeFromSuperview];
        self.selectedView = nil;
    }
}
@end














