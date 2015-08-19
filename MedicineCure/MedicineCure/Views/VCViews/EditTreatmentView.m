//
//  EditTreatmentView.m
//  MedicineCure
//
//  Created by line0 on 15/8/5.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "EditTreatmentView.h"

#import "PickDayView.h"

#import "TreatmentDataControl.h"

@interface EditTreatmentView ()
{
    UIView      *_backView;
    
    UIButton     *_cancleBtn;
    UIButton     *_confirmBtn;
    
    TreatDayTimeView *_beginView;
    TreatDayTimeView *_endView;
    
    UILabel      *_contentTitle;
    UILabel      *_timeTitle;
    UILabel      *_treatmentContent;
    UILabel      *_treatmentTime;
    
    PickDayView  *_picker;
    
    TreatmentDataControl *_treatControl;
}

@property(nonatomic, strong) NSString *beginTime;
@property(nonatomic, strong) NSString *endTime;

@end

@implementation EditTreatmentView

- (void)dealloc
{
    _completeBlock = nil;
    [_treatControl cancelOperation];
    _treatControl = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        _treatControl = [TreatmentDataControl new];
        
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        _backView.backgroundColor = UICOLOR_RGBA(1, 1, 1, 0.6);
        [self addSubview:_backView];
        
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.frame = CGRectMake(kKeyWindow.width/2 - 100, kKeyWindow.height - 70, 50, 50);
        [_cancleBtn setImage:UIImageByName(@"large_x") forState:UIControlStateNormal];
        [self addSubview:_cancleBtn];
        [_cancleBtn addTarget:self action:@selector(endViewAnimation) forControlEvents:UIControlEventTouchUpInside];
        
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.frame = CGRectMake(kKeyWindow.width/2 + 50, kKeyWindow.height - 70, 50, 50);
        [_confirmBtn setImage:UIImageByName(@"large_x") forState:UIControlStateNormal];
        [self addSubview:_confirmBtn];
        [_confirmBtn addTarget:self action:@selector(confirmViewAnimation:) forControlEvents:UIControlEventTouchUpInside];
        
        _beginView = [[TreatDayTimeView alloc] initWithFrame:CGRectMake((kKeyWindow.width - 260)/2, 130, 260, 35)];
        [self addSubview:_beginView];
        [_beginView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTreatmentView:)]];
        _beginView.userInteractionEnabled = YES;
        _beginView.tag = 1;
        
        _endView = [[TreatDayTimeView alloc] initWithFrame:CGRectMake(_beginView.left, _beginView.bottom + 28, _beginView.width, _beginView.height)];
        [self addSubview:_endView];
        [_endView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTreatmentView:)]];
        _endView.userInteractionEnabled = YES;
        _endView.tag = 2;
        
        _contentTitle = [[UILabel alloc] initWithFrame:CGRectMake(_beginView.left + 7, _endView.bottom + 30, 45, 25)];
        _contentTitle.textAlignment = NSTextAlignmentLeft;
        _contentTitle.textColor     = kLightBlueColor;
        _contentTitle.font          = gFontSystemSize(15);
        _contentTitle.text          = @"方案";
        [self addSubview:_contentTitle];
        
        _treatmentContent = [[UILabel alloc] initWithFrame:CGRectMake(_contentTitle.right + 20, _contentTitle.top, 200, _contentTitle.height)];
        _treatmentContent.textAlignment = NSTextAlignmentLeft;
        _treatmentContent.textColor     = [UIColor whiteColor];
        _treatmentContent.font          = gFontSystemSize(17);
        [self addSubview:_treatmentContent];
        
        _timeTitle = [[UILabel alloc] initWithFrame:CGRectMake(_contentTitle.left, _contentTitle.bottom + 30, 45, 25)];
        _timeTitle.textAlignment = NSTextAlignmentLeft;
        _timeTitle.textColor     = kLightBlueColor;
        _timeTitle.font          = gFontSystemSize(15);
        _timeTitle.text          = @"周期";
        [self addSubview:_timeTitle];
        
        _treatmentTime = [[UILabel alloc] initWithFrame:CGRectMake(_timeTitle.right + 20, _timeTitle.top, 200, _timeTitle.height)];
        _treatmentTime.textAlignment = NSTextAlignmentLeft;
        _treatmentTime.textColor     = [UIColor whiteColor];
        _treatmentTime.font          = gFontSystemSize(22);
        [self addSubview:_treatmentTime];
        
        _beginView.instructeLable.text = @"开始";
        _endView.instructeLable.text = @"结束";
        _beginTime = [dateFormatter_yyyyMMdd() stringFromDate:[NSDate date]];
        _endTime = @"2015-08-25";
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _beginView.timeLable.text    = [_beginTime stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    
    _endView.timeLable.text      = [_endTime stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    
    _treatmentContent.text       = _ttitle?:@"伽玛刀";
    
    NSMutableAttributedString *atrr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld天", [self sysCureDayTime]]];
    [atrr addAttribute:NSFontAttributeName value:gFontSystemSize(17) range:NSMakeRange(atrr.length - 1, 1)];
    _treatmentTime.attributedText = atrr;
}

- (void)confirmViewAnimation:(id)sender
{
    
    [self requestAddOneTreatment];
}

- (void)beginViewAnimation
{
    _backView.alpha = 0;
    self.top  = kKeyWindow.height;
    [UIView animateWithDuration:0.35 animations:^{
        _backView.alpha = 1.0;
        self.top = 0;
    }];
}

- (void)endViewAnimation
{
    if (_completeBlock) {
        _completeBlock();
    }
    [UIView animateWithDuration:0.35 animations:^{
        _backView.alpha = 0;
        self.top  = kKeyWindow.height;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)tapTreatmentView:(UITapGestureRecognizer *)gesture
{
    TreatDayTimeView *treatment = (TreatDayTimeView *)gesture.view;
    
    if (!_picker)
    {
        _picker = [[PickDayView alloc] initWithFrame:CGRectMake(0, 200, kKeyWindow.width, 255)];
        
    }
    if (_picker.pickDayBlock) {
        _picker.pickDayBlock = nil;
    }
    __weak typeof(treatment) _wtreat = treatment;
    __weak typeof(self) _wself = self;
    _picker.pickDayBlock = ^(NSDate *date){
        NSString *day = [dateFormatter_yyyyMMdd() stringFromDate:date];
        NSString *tem = [day stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
        if (_wtreat.tag == 1) {
            _wself.beginTime = tem;
        }
        else {
            _wself.endTime = tem;
        }
    };
    
    [_picker.dayView setDate:[dateFormatter_yyyyMMdd() dateFromString:[treatment.timeLable.text stringByReplacingOccurrencesOfString:@"/" withString:@"-"]] animated:YES];
    [self addSubview:_picker];
    [_picker addAnimation];
}

- (NSInteger)sysCureDayTime
{
    NSInteger time = 0;
    
    NSDate *begin = [dateFormatter_yyyyMMdd() dateFromString:_beginTime];
    NSDate *end   = [dateFormatter_yyyyMMdd() dateFromString:_endTime];
    
    NSComparisonResult result = [begin compare:end];
    if (result == NSOrderedAscending) {
        NSTimeInterval benTime = [begin timeIntervalSince1970];
        NSTimeInterval endTime = [end timeIntervalSince1970];
        
        time = (endTime - benTime)/(24*60*60);
    }
    
    return time;
}

#pragma mark - HTTP Requests
- (void)requestAddOneTreatment
{
    [[LWaittingView sharedInstance] showWaittingView];
    
    __weak typeof(self) _wself = self;
    [_treatControl addOneTreatment:@{@"userId" : @([UserDefaultControl shareInstance].cacheLoginedUserEntity.userId), @"treatmentProcessId" : @(_treatmentId), @"courseCount" : @"1", @"period" : @([self sysCureDayTime]), @"pushPeriod" : @"1", @"startDate" : _beginTime } withCompleteBlock:^(BOOL isSuccess, NSError *error) {
        if (isSuccess)
        {
            mAlertView(@"提示", @"添加成功");
            [_wself endViewAnimation];
            [kNotificationCenter postNotificationName:kRefreashHomeInit object:nil];
        }
        else
        {
            mAlertView(@"提示", error.errMsg);
        }
        [[LWaittingView sharedInstance] hideWaittingView];
    }];
}

@end


@interface TreatDayTimeView ()
{
    UIView *_lineView;
}
@end


@implementation TreatDayTimeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        
        _image = [[UIImageView alloc] initWithFrame:CGRectMake(5, (height - 35)/2, 35, 35)];
        _image.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_image];
        
        _instructeLable = [[UILabel alloc] initWithFrame:CGRectMake(width - 50, 5, 45, height-5)];
        _instructeLable.textAlignment = NSTextAlignmentCenter;
        _instructeLable.textColor     = kLightBlueColor;
        _instructeLable.font          = gFontSystemSize(15);
        [self addSubview:_instructeLable];
        
        _timeLable = [[UILabel alloc] initWithFrame:CGRectMake(_image.right + 10, 5, _instructeLable.left - _image.right - 10, height-5)];
        _timeLable.textAlignment = NSTextAlignmentCenter;
        _timeLable.textColor     = kLightBlueColor;
        _timeLable.font          = gFontSystemSize(20);
        [self addSubview:_timeLable];
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(_timeLable.left, _timeLable.bottom - 0.5, width - _timeLable.left, 0.5)];
        _lineView.backgroundColor = kLineGrayColor;
        [self addSubview:_lineView];
    }
    return self;
}

@end
