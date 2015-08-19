//
//  HomeTableHeaderView.m
//  MedicineCure
//
//  Created by line0 on 15/7/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "HomeTableHeaderView.h"

#import "MedicineEntity.h"

@interface HomeTableHeaderView ()
{
    UIImageView *_backImage;
    
    UILabel     *_sunShineLable;
    
    UIView      *_infoView;
    UILabel     *_infoDayLable;
    UILabel     *_infoTimeLable;
    UILabel     *_infoContentLable;
    
    UIButton    *_leftBtn;
    UIButton    *_rightBtn;
    
    UIView      *_medicineView;
    
    UIButton    *_searcherBtn;
}

@end

@implementation HomeTableHeaderView

- (void)dealloc
{
    _getSearcherVCBlock = nil;
    _addMedicineBlock   = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        
        CGFloat tempHeight = height - 95;
        
        _backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height - 45)];
        _backImage.backgroundColor = kLightBlueColor;
        [self addSubview:_backImage];
        
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(-10, (tempHeight - 56)/2, 56, 56);
        _leftBtn.backgroundColor = [UIColor whiteColor];
        _leftBtn.layer.borderWidth = 0.5;
        _leftBtn.layer.borderColor = kAppNormalBgColor.CGColor;
        _leftBtn.layer.cornerRadius = 28;
        _leftBtn.clipsToBounds      = YES;
        [_leftBtn setTitle:@"25" forState:UIControlStateNormal];
        [_leftBtn setTitleColor:kLightBlueColor forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = gFontSystemSize(15);
        [self addSubview:_leftBtn];
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(kKeyWindow.width - 46, (tempHeight - 56)/2, 56, 56);
        _rightBtn.backgroundColor = [UIColor whiteColor];
        _rightBtn.layer.borderWidth = 0.5;
        _rightBtn.layer.borderColor = kAppNormalBgColor.CGColor;
        _rightBtn.layer.cornerRadius = 28;
        _rightBtn.clipsToBounds      = YES;
        [_rightBtn setTitle:@"27" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:kLightBlueColor forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = gFontSystemSize(15);
        [self addSubview:_rightBtn];
        [_leftBtn addTarget:self action:@selector(clickLastDayBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_rightBtn addTarget:self action:@selector(clickNextDayBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        _infoView = [[UIView alloc] initWithFrame:CGRectMake((kKeyWindow.width - 150)/2, (tempHeight - 150)/2 - 5, 150, 150)];
        _infoView.layer.borderColor = kLightGreenBtnColor.CGColor;
        _infoView.layer.borderWidth = 0.5;
        _infoView.layer.cornerRadius = 75;
        _infoView.clipsToBounds      = YES;
        [self addSubview:_infoView];
        
        CGFloat midWidth = _infoView.width/2.0;
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(_infoView.left + 10, _infoView.top + 10 + midWidth, _infoView.width - 20, 2)];
        lineView.backgroundColor = kLightGreenBtnColor;
        [self addSubview:lineView];
        
        _infoTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(lineView.left, lineView.top - 27, lineView.width, 18)];
        _infoTimeLable.textAlignment = NSTextAlignmentCenter;
        _infoTimeLable.textColor = kLightGreenBtnColor;
        _infoTimeLable.font      = gFontSystemSize(17);
        _infoTimeLable.text      = @"9月26日";
        [self addSubview:_infoTimeLable];
        
        _infoDayLable = [[UILabel alloc] initWithFrame:CGRectMake(lineView.left, _infoTimeLable.top - 21, lineView.width, 18)];
        _infoDayLable.textAlignment = NSTextAlignmentCenter;
        _infoDayLable.textColor = kLightGreenBtnColor;
        _infoDayLable.font      = gFontSystemSize(17);
        _infoDayLable.text      = @"今天";
        [self addSubview:_infoDayLable];
        
        _infoContentLable = [[UILabel alloc] initWithFrame:CGRectMake(lineView.left, lineView.top + 13, lineView.width, 20)];
        _infoContentLable.textAlignment = NSTextAlignmentCenter;
        _infoContentLable.textColor = kLightGreenBtnColor;
        _infoContentLable.font      = gFontSystemSize(19);
        _infoContentLable.text      = @"住院日";
        [self addSubview:_infoContentLable];
        
        _medicineView = [[UIView alloc] initWithFrame:CGRectMake(0, _backImage.height - 50, width, 45)];
        _medicineView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_medicineView];
        
        UIImageView *yaoImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, _medicineView.top + 10, 18, 25)];
        yaoImage.backgroundColor = [UIColor clearColor];
        yaoImage.image = UIImageByName(@"icon_medicine");
        [self addSubview:yaoImage];
        
        UIButton *minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        minusBtn.frame = CGRectMake(kKeyWindow.width - 33, _medicineView.top + 7, 30, 30);
        minusBtn.backgroundColor = kAppBgColor;
        [minusBtn setImage:UIImageByName(@"icon_minus") forState:UIControlStateNormal];
        minusBtn.titleLabel.font = gFontSystemSize(25);
        [self addSubview:minusBtn];
        [minusBtn addTarget:self action:@selector(minusOneMedicine:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *yaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        yaoBtn.frame = CGRectMake(kKeyWindow.width - 65, _medicineView.top + 7, 30, 30);
        yaoBtn.backgroundColor = kAppBgColor;
        [yaoBtn setImage:UIImageByName(@"icon_plus") forState:UIControlStateNormal];
        yaoBtn.titleLabel.font = gFontSystemSize(25);
        [self addSubview:yaoBtn];
        [yaoBtn addTarget:self action:@selector(addOneMedicine:) forControlEvents:UIControlEventTouchUpInside];
        
        _sunShineLable = [[UILabel alloc] initWithFrame:CGRectMake(0, _medicineView.top - 18, width, 15)];
        _sunShineLable.textAlignment = NSTextAlignmentCenter;
        _sunShineLable.textColor = [UIColor whiteColor];
        _sunShineLable.font = gFontSystemSize(13);
        _sunShineLable.text = @"阳光生活每一天，美好的心情";
        [self addSubview:_sunShineLable];
        
        _searcherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _searcherBtn.frame = CGRectMake((width - 250)/2, _backImage.bottom + 5, 250, 35);
        _searcherBtn.backgroundColor = kYMLightRedColor;
//        _searcherBtn.layer.borderColor = kLBBlackColor.CGColor;
//        _searcherBtn.layer.borderWidth = 0.5;
        _searcherBtn.layer.cornerRadius = 3.5;
        _searcherBtn.clipsToBounds      = YES;
        [_searcherBtn setTitle:@"不适速查" forState:UIControlStateNormal];
        [_searcherBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _searcherBtn.titleLabel.font = gFontSystemSize(16);
        [self addSubview:_searcherBtn];
        [_searcherBtn addTarget:self action:@selector(getGoSearchView:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)clickLastDayBtn:(id)sender
{
    mAlertView(@"提示", @"上一天");
}

- (void)clickNextDayBtn:(id)sender
{
    mAlertView(@"提示", @"下一天");
}

- (void)getGoSearchView:(id)sender
{
    if (_getSearcherVCBlock) {
        _getSearcherVCBlock();
    }
}

- (void)setMedicineList:(NSArray *)medicineList
{
    [_medicineList removeAllObjects];
    [_medicineList addObjectsFromArray:medicineList];
    
    [_medicineView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *view = obj;
        [view removeFromSuperview];
    }];
    
    CGFloat left = 55;
    for (MedicineEntity *entity in medicineList) {
        UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(left, 3, 38, 38)];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = kLightBlueColor;
        lable.font = gFontSystemSize(18);
        lable.text = entity.firtName;
        lable.layer.borderColor = kLightBlueColor.CGColor;
        lable.layer.borderWidth = 0.5;
        lable.layer.cornerRadius = 19;
        lable.clipsToBounds = YES;
        [_medicineView addSubview:lable];
        
        left += 41;
        if (left > kKeyWindow.width - 90) {
            break;
        }
    }
    if (medicineList.count == 0) {
        UILabel *noDataLable=[[UILabel alloc] initWithFrame:CGRectMake(55, 10, 200, 25)];
        noDataLable.textColor = kLBBlackColor;
        noDataLable.font = gFontSystemSize(15);
        noDataLable.text = @"药品提醒内容";
        [_medicineView addSubview:noDataLable];
    }
}

- (void)addOneMedicine:(id)sender
{
    if (_addMedicineBlock) {
        _addMedicineBlock();
    }
}

- (void)minusOneMedicine:(id)sender
{
    if (_addMedicineBlock) {
        _addMedicineBlock();
    }
}

@end
