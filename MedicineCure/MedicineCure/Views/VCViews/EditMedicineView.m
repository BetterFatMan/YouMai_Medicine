//
//  EditMedicineView.m
//  MedicineCure
//
//  Created by line0 on 15/8/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "EditMedicineView.h"
#import "EditTreatmentView.h"
#import "PickDayView.h"

#import "CommonDataControl.h"

@interface EditMedicineView ()

{
    UIView      *_backView;
    
    UIButton     *_cancleBtn;
    UIButton     *_confirmBtn;
    
    TreatDayTimeView *_beginView;
    TreatDayTimeView *_endView;
    
    UILabel      *_contentTitle;
    UILabel      *_timeTitle;
    UITextField      *_treatmentContent;
    UITextField      *_treatmentTime;
    
    PickDayView  *_picker;
    
    CommonDataControl *_comControl;
}

@property(nonatomic, strong) NSString *beginTime;
@property(nonatomic, strong) NSString *endTime;

@end

@implementation EditMedicineView

- (void)dealloc
{
    _medicineSuccessBlock = nil;
    [_comControl cancelOperation];
    _comControl = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        _comControl = [CommonDataControl new];
        
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
        _contentTitle.text          = @"药名";
        [self addSubview:_contentTitle];
        
        _treatmentContent = [[UITextField alloc] initWithFrame:CGRectMake(_contentTitle.right + 20, _contentTitle.top, 200, _contentTitle.height)];
        _treatmentContent.textAlignment = NSTextAlignmentLeft;
        _treatmentContent.textColor     = [UIColor whiteColor];
        _treatmentContent.font          = gFontSystemSize(17);
        [self addSubview:_treatmentContent];
        
        _timeTitle = [[UILabel alloc] initWithFrame:CGRectMake(_contentTitle.left, _contentTitle.bottom + 30, 45, 25)];
        _timeTitle.textAlignment = NSTextAlignmentLeft;
        _timeTitle.textColor     = kLightBlueColor;
        _timeTitle.font          = gFontSystemSize(15);
        _timeTitle.text          = @"用法";
        [self addSubview:_timeTitle];
        
        _treatmentTime = [[UITextField alloc] initWithFrame:CGRectMake(_timeTitle.right + 20, _timeTitle.top, 200, _timeTitle.height)];
        _treatmentTime.textAlignment = NSTextAlignmentLeft;
        _treatmentTime.textColor     = [UIColor whiteColor];
        _treatmentTime.font          = gFontSystemSize(17);
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
    
    _treatmentContent.text       = @"依西美坦";
    
    NSMutableAttributedString *atrr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"1天  2次"]];
    [atrr addAttribute:NSFontAttributeName value:gFontSystemSize(22) range:NSMakeRange(atrr.length - 2, 1)];
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
    
    [UIView animateWithDuration:0.35 animations:^{
        _backView.alpha = 0;
        self.top  = kKeyWindow.height;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)tapTreatmentView:(UITapGestureRecognizer *)gesture
{
    [self tapMCBaseView:nil];
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
//        NSString *tem = [day stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
        if (_wtreat.tag == 1) {
            _wself.beginTime = day;
        }
        else {
            _wself.endTime = day;
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

- (void)tapMCBaseView:(UIPanGestureRecognizer *)gesture
{
    [_treatmentContent resignFirstResponder];
    [_treatmentTime resignFirstResponder];
}

#pragma mark - HTTP Requests
- (void)requestAddOneTreatment
{
    [[LWaittingView sharedInstance] showWaittingView];
    
    __weak typeof(self) _wself = self;
    [_comControl addOneMedicine:@{@"userId" : @([UserDefaultControl shareInstance].cacheLoginedUserEntity.userId), @"medicineId" : @(arc4random()%5 + 1), @"frequency" : @"1", @"dosage" : @(2), @"endDate" : _endTime, @"startDate" : _beginTime } withCompleteBlock:^(BOOL isSuccess, NSError *error) {
        if (isSuccess)
        {
            mAlertView(@"提示", @"药品添加成功");
            if (_wself.medicineSuccessBlock)
            {
                _wself.medicineSuccessBlock();
            }
            [_wself endViewAnimation];
        }
        else
        {
            mAlertView(@"提示", error.errMsg);
        }
        [[LWaittingView sharedInstance] hideWaittingView];
    }];
}

@end
