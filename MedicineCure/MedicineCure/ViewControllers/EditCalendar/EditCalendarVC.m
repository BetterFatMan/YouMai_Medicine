//
//  EditCalendarVC.m
//  MedicineCure
//
//  Created by line0 on 15/8/3.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "EditCalendarVC.h"

#import "MCCalendarView.h"
#import "LKCalendarView.h"
#import "ThreeItemsSelectView.h"
#import "SelectVersionsView.h"
#import "EditTreatmentView.h"

#import "TreatmentDataControl.h"

@interface EditCalendarVC ()<LKCalendarMonthDelegate,LKCalendarDayViewDelegate,LKCalendarViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
    UIView     *_monthView;
    UILabel    *_monthLable;
    
    UILabel    *_yearLable;
    
    UIView     *_todayView;
    UILabel    *_todayDay;
    UILabel    *_todayMonth;
    UILabel    *_todayYear;
    
    NSInteger  _selectDayTime;
    
    UITableView *_editTable;
    ThreeItemsSelectView *_threeItemsView;
    
    TreatmentDataControl *_treatControl;
}

@property(nonatomic, strong)  MCCalendarView *calendar;
@property(weak, nonatomic)    LKCalendarDayView* lastSelectedDayView;

@end

@implementation EditCalendarVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _selectDayTime = 0;
        
        _treatControl = [TreatmentDataControl new];
    }
    return self;
}

- (void)dealloc
{
    [_treatControl cancelOperation];
    _treatControl = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self addAllViewSubs];
}

#pragma mark - ViewSubs
- (void)addAllViewSubs
{
    [self addNaviBars];
    
    _monthView = [self createMonthView];
    [self.view addSubview:_monthView];
    _todayView = [self createTodayView];
    [self.view addSubview:_todayView];
    
    _calendar = [[MCCalendarView alloc] initWithFrame:CGRectMake(0, self.navView.bottom + 35, kKeyWindow.width - 90, 30 + SYCC_MonthHeight)];
    [self.view addSubview:_calendar];
    _calendar.calendarView.delegate = self;
    
    [self calendarViewDidChangedMonth:_calendar.calendarView];
    
    _editTable = [[UITableView alloc] initWithFrame:CGRectMake(0, _calendar.bottom + 5, kKeyWindow.width, 90) style:UITableViewStylePlain];
    _editTable.scrollEnabled = NO;
    _editTable.dataSource    = self;
    _editTable.delegate      = self;
    _editTable.rowHeight     = 45;
    [self.view addSubview:_editTable];
    
    _threeItemsView = [[ThreeItemsSelectView alloc] initWithFrame:CGRectMake(0, kKeyWindow.height - 40, kKeyWindow.width, 40)];
    _threeItemsView.itemsList = @[ @"治疗", @"检查", @"药品" ];
    _threeItemsView.delegate  = self;
    [self.view addSubview:_threeItemsView];
}

- (void)addNaviBars
{
    _yearLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, 90, 36)];
    _yearLable.textAlignment = NSTextAlignmentCenter;
    _yearLable.textColor     = kBBlackColor;
    _yearLable.font          = gFontSystemSize(25);
    _yearLable.center        = CGPointMake(kKeyWindow.width/2, _yearLable.center.y);
    [self.navView addSubview:_yearLable];
    
    UIButton *nextMonth = [UIButton buttonWithType:UIButtonTypeCustom];
    nextMonth.frame = CGRectMake(_yearLable.right + 20, 24, 35, 35);
    [nextMonth setTitle:@">" forState:UIControlStateNormal];
    [nextMonth setTitleColor:kBBlackColor forState:UIControlStateNormal];
    [nextMonth addTarget:self action:@selector(clickNextYearBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:nextMonth];
    
    UIButton *lastMonth = [UIButton buttonWithType:UIButtonTypeCustom];
    lastMonth.frame = CGRectMake(_yearLable.left - 55, 24, 35, 35);
    [lastMonth setTitle:@"<" forState:UIControlStateNormal];
    [lastMonth setTitleColor:kBBlackColor forState:UIControlStateNormal];
    [lastMonth addTarget:self action:@selector(clickLastYearBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:lastMonth];
    
    UIButton *todayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    todayBtn.frame = CGRectMake(kKeyWindow.width - 44, 20, 44, 44);
    [todayBtn setTitle:@"今" forState:UIControlStateNormal];
    [todayBtn setTitleColor:kBBlackColor forState:UIControlStateNormal];
    [todayBtn addTarget:self action:@selector(clickTodayBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:todayBtn];
}

- (UIView *)createMonthView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.bottom, kKeyWindow.width - 90, 35)];
    bgView.backgroundColor = [UIColor whiteColor];
    
    _monthLable = [[UILabel alloc] initWithFrame:bgView.bounds];
    _monthLable.textAlignment = NSTextAlignmentCenter;
    _monthLable.textColor     = kLBBlackColor;
    _monthLable.font          = gFontSystemSize(19);
    [bgView addSubview:_monthLable];
    
    UIButton *nextMonth = [UIButton buttonWithType:UIButtonTypeCustom];
    nextMonth.frame = CGRectMake(bgView.width - 55, 0, 35, 35);
    [nextMonth setTitle:@">" forState:UIControlStateNormal];
    [nextMonth setTitleColor:kLBBlackColor forState:UIControlStateNormal];
    [nextMonth addTarget:self action:@selector(clickNextMonthBtn:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:nextMonth];
    
    UIButton *lastMonth = [UIButton buttonWithType:UIButtonTypeCustom];
    lastMonth.frame = CGRectMake(20, 0, 35, 35);
    [lastMonth setTitle:@"<" forState:UIControlStateNormal];
    [lastMonth setTitleColor:kLBBlackColor forState:UIControlStateNormal];
    [lastMonth addTarget:self action:@selector(clickLastMonthBtn:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:lastMonth];
    
    return bgView;
}

- (UIView *)createTodayView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(kKeyWindow.width - 90, self.navView.bottom, 90, 90)];
    bgView.backgroundColor = kLightBlueColor;
    
    _todayMonth = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, 45, 15)];
    _todayMonth.textAlignment = NSTextAlignmentCenter;
    _todayMonth.textColor     = [UIColor whiteColor];
    _todayMonth.font          = gFontSystemSize(14);
    [bgView addSubview:_todayMonth];
    
    _todayYear = [[UILabel alloc] initWithFrame:CGRectMake(0, _todayMonth.bottom + 1, 45, 16)];
    _todayYear.textAlignment = NSTextAlignmentCenter;
    _todayYear.textColor     = [UIColor whiteColor];
    _todayYear.font          = gFontSystemSize(14);
    [bgView addSubview:_todayYear];
    
    _todayDay = [[UILabel alloc] initWithFrame:CGRectMake(bgView.width - 50, bgView.height - 50, 44, 44)];
    _todayDay.textAlignment = NSTextAlignmentCenter;
    _todayDay.textColor     = [UIColor whiteColor];
    _todayDay.font          = gFontSystemSize(26);
    _todayDay.layer.borderColor = kAppNormalBgColor.CGColor;
    _todayDay.layer.borderWidth = 0.5;
    _todayDay.layer.cornerRadius = 22;
    _todayDay.clipsToBounds      = YES;
    [bgView addSubview:_todayDay];
    
    return bgView;
}

#pragma mark - HTTP Requests
- (void)requestAddOneTreatment
{
    
    [_treatControl addOneTreatment:@{@"userId" : @([UserDefaultControl shareInstance].cacheLoginedUserEntity.userId), @"treatmentProcessId" : @"1", @"courseCount" : @"1", @"period" : @"5", @"pushPeriod" : @"1", @"startDate" : @"2015-08-01" } withCompleteBlock:^(BOOL isSuccess, NSError *error) {
        if (isSuccess)
        {
            mAlertView(@"提示", @"添加成功");
        }
        else
        {
            mAlertView(@"提示", error.errMsg);
        }
    }];
}

#pragma mark - UIButton Actions
- (void)clickNextMonthBtn:(id)sender
{
    NSDateComponents *com = [_calendar.calendarView.currentDateComponents copy];
    com.month ++;
    if(com.month > 12 || com.month < 1)
    {
        NSDate* date = [currentLKCalendar dateFromComponents:com];
        com = [currentLKCalendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    }
    [_calendar.calendarView setCurrentDateComponents:com animation:YES];
    if(_lastSelectedDayView)
        _lastSelectedDayView.selected = NO;
}

- (void)clickLastMonthBtn:(id)sender
{
    NSDateComponents *com = [_calendar.calendarView.currentDateComponents copy];
    com.month --;
    if(com.month > 12 || com.month < 1)
    {
        NSDate* date = [currentLKCalendar dateFromComponents:com];
        com = [currentLKCalendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    }
    [_calendar.calendarView setCurrentDateComponents:com animation:YES];
    if(_lastSelectedDayView)
        _lastSelectedDayView.selected = NO;
}

- (void)clickNextYearBtn:(id)sender
{
    NSDateComponents *com = [_calendar.calendarView.currentDateComponents copy];
    com.year ++;
    [_calendar.calendarView setCurrentDateComponents:com animation:YES];
    if(_lastSelectedDayView)
        _lastSelectedDayView.selected = NO;
}

- (void)clickLastYearBtn:(id)sender
{
    NSDateComponents *com = [_calendar.calendarView.currentDateComponents copy];
    com.year --;
    [_calendar.calendarView setCurrentDateComponents:com animation:YES];
    if(_lastSelectedDayView)
        _lastSelectedDayView.selected = NO;
}

- (void)clickTodayBtn:(id)sender
{
    _selectDayTime = 0;
    NSDateComponents *com = [currentLKCalendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    [_calendar.calendarView setCurrentDateComponents:com animation:YES];
    if(_lastSelectedDayView)
        _lastSelectedDayView.selected = NO;
}

- (void)clickThreeItemsBtn:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    btn.selected  = YES;
    
    [btn.superview.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx != btn.tag) {
            UIButton *temlabel = btn.superview.subviews[idx];
            temlabel.selected = NO;
        }
    }];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"com.edit.carlendar.cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    
    cell.textLabel.text = @"编辑";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self requestAddOneTreatment];
    
    EditTreatmentView *version = [[EditTreatmentView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:version];
    version.treatmentId = 1;
    [version beginViewAnimation];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - LKCalendarMonthDelegate,LKCalendarDayViewDelegate,LKCalendarViewDelegate
-(void)calendarViewDidChangedMonth:(LKCalendarView *)sender
{
    _todayMonth.text = _monthLable.text = [NSString stringWithFormat:@"%ld月", sender.currentDateComponents.month];
    _todayYear.text  = _yearLable.text  = [NSString stringWithFormat:@"%ld", sender.currentDateComponents.year];
    _todayDay.text   = [NSString stringWithFormat:@"%ld", _selectDayTime>0 ? _selectDayTime:sender.currentDateComponents.day];
}
-(void)calendarMonth:(LKCalendarMonth *)month dayView:(LKCalendarDayView *)dayView date:(NSDate *)date
{
//    int monthdiff = monthDiffWithDateComponents(month.currentMonth,getYearMonthDateComponents(date));
    dayView.backgroundColor = [UIColor grayColor];
    dayView.date = date;
//    dayView.lb_date.hidden = (monthdiff != 0);
}
-(void)calendarDayViewWillSelected:(LKCalendarDayView *)dayView
{
    if([_lastSelectedDayView isEqual:dayView])
        return;
    
    if(_lastSelectedDayView)
        _lastSelectedDayView.selected = NO;
    
    _lastSelectedDayView = dayView;
    
    NSInteger monthdiff = monthDiffWithDateComponents(_calendar.calendarView.currentDateComponents,getYearMonthDateComponents(dayView.date));
    if(monthdiff != 0)
    {
        dayView.selected = NO;
        LKCalendarDayView* selectedView = [_calendar.calendarView moveToDate:dayView.date];
        
        selectedView.selected = YES;
        _lastSelectedDayView = selectedView;
    }
    NSDateComponents *com = getYearMonthDateComponents(dayView.date);
    _selectDayTime = com.day;
    _todayDay.text   = [NSString stringWithFormat:@"%ld", com.day];
}

@end
