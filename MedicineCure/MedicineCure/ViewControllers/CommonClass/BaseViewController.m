//
//  BaseViewController.m
//  Line0new
//
//  Created by trojan on 14-8-28.
//  Copyright (c) 2014年 com.line0. All rights reserved.
//

#import "BaseViewController.h"
#import "UIButton+Addition.h"
#import "UserDefaultControl.h"


@interface BaseViewController ()
@property(nonatomic, copy) void (^showGuideFinishedBlock)();

@end

@implementation BaseViewController
{
        /// 无数据时显示的image
    UIImageView                 *_noDataTipsImgView;
        /// 无数据时显示的title
    UILabel                     *_noDataTipsLabel;
        /// 新手引导
    UIButton                    *_guideBtn;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor   = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    self.view.clipsToBounds     = YES;
    
    self.navView                = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kKeyWindow.width, 20 + 44)];
    _navView.backgroundColor    = [UIColor whiteColor];
    self.navView.clipsToBounds  = YES;
    [self.view addSubview:_navView];
    
    UIView *btmLineView         = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.bottom-0.5, kKeyWindow.width, 0.5)];
    btmLineView.backgroundColor = UICOLOR_RGB(0xc7, 0xc7, 0xc7);
    btmLineView.hidden          = _isShowBlueNavStyle;
    [_navView addSubview:btmLineView];
    
    _arrownImage = [[UIImageView alloc] initWithFrame:CGRectNull];
    _arrownImage.frame = CGRectMake((kKeyWindow.width - 13)/2, self.navView.height - 5, 13, 5);
    _arrownImage.image = UIImageByName(@"icon_arrowup");
    [self.navView addSubview:_arrownImage];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!self.leftBtn)
    {
        UIButton *backBtn           = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame               = CGRectMake(0, 20, 44, 44);
        [backBtn setImage:[UIImage imageNamed:_isShowBlueNavStyle ? @"icon_back_blue" : @"icon_back"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        self.leftBtn = backBtn;
    }
    [_navView addSubview:_leftBtn];
    
    if (!self.titleLab)
    {
        UILabel *titleLabel         = [[UILabel alloc] initWithFrame:CGRectMake(45, 20, kKeyWindow.width - 90, 44)];
        titleLabel.textAlignment    = NSTextAlignmentCenter;
        titleLabel.backgroundColor  = [UIColor clearColor];
        titleLabel.font             = [UIFont systemFontOfSize:22];
        titleLabel.textColor        = kYMNaviTitleColor;
        titleLabel.autoresizingMask = (UIViewAutoresizingFlexibleWidth);
        self.titleLab = titleLabel;
    }
    [_navView addSubview:_titleLab];
    _titleLab.text             = self.title;
    
        /// 友盟页面统计
    if (_umengPageName.length)
    {
        [MobClick beginLogPageView:_umengPageName];
    }
    
        /// 显示新手引导图片
    [self showGuideImgView:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (_umengPageName.length)
    {
            /// 友盟页面统计
        [MobClick endLogPageView:_umengPageName];
    }
}

- (void)setIsNeedShowNoDataTips:(BOOL)isNeedShowNoDataTips
{
    if (isNeedShowNoDataTips)
    {
        UIImage *tipsImg = [UIImage imageNamed:_noDataTipsImgName];
        if (!_noDataTipsImgView && tipsImg)
        {
            _noDataTipsImgView = [[UIImageView alloc] initWithImage:tipsImg];
            _noDataTipsImgView.frame = CGRectMake(0, 0, tipsImg.size.width/2, tipsImg.size.height/2);
            [self.view addSubview:_noDataTipsImgView];
        }
        
        float marginTop = self.view.center.y - tipsImg.size.height/2;
        if (tipsImg)
        {
            _noDataTipsImgView.frame = CGRectMake((kKeyWindow.width-tipsImg.size.width) / 2, marginTop, tipsImg.size.width, tipsImg.size.height);
            _noDataTipsImgView.image = tipsImg;
            [self.view bringSubviewToFront:_noDataTipsImgView];
        }
        
        if (!_noDataTipsLabel && _noDataTipsStr)
        {
            _noDataTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kKeyWindow.width-30, 30)];
            _noDataTipsLabel.font = [UIFont systemFontOfSize:14];
            _noDataTipsLabel.textColor = kLLBBlackColor;
            _noDataTipsLabel.backgroundColor = [UIColor clearColor];
            _noDataTipsLabel.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:_noDataTipsLabel];
        }
        
        marginTop = MAX(self.view.center.y - 15, _noDataTipsImgView.bottom) ;
        if (_noDataTipsStr)
        {
            _noDataTipsLabel.frame = CGRectMake(15, marginTop, kKeyWindow.width-30, 30);
            _noDataTipsLabel.text = _noDataTipsStr;
            [self.view bringSubviewToFront:_noDataTipsLabel];
        }
        
        _noDataTipsImgView.hidden   = NO;
        _noDataTipsLabel.hidden     = NO;
    }
    else
    {
        _noDataTipsImgView.hidden   = YES;
        _noDataTipsLabel.hidden     = YES;
    }
}

- (void)backBtnClick:(UIButton *)sender
{
    if (self.backBtnClickCallback)
    {
        self.backBtnClickCallback();
        self.backBtnClickCallback = nil;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)backSwipeGuesture:(UISwipeGestureRecognizer *)gesture
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showGuideImgView:(void (^)(void))finishedBlock
{
//    if (![self.guideImgArray count] ||
//        [[UserDefaultControl shareInstance].cacheShowedGuideVCArr containsObject:NSStringFromClass([self class])])
//    {
//        return;
//    }
//    
//    if (finishedBlock)
//    {
//        self.showGuideFinishedBlock = finishedBlock;
//    }
//    NSLog(@"NSStringFromClass([self class]) %@", NSStringFromClass([self class]));
//    NSMutableArray *arr = [NSMutableArray arrayWithArray:[UserDefaultControl shareInstance].cacheShowedGuideVCArr];
//    [arr addObject:NSStringFromClass([self class])];
//    [UserDefaultControl shareInstance].cacheShowedGuideVCArr = arr;
//    
//    if(!_guideBtn)
//    {
//        _guideBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _guideBtn.frame = CGRectMake(0, 0, kKeyWindow.width, kKeyWindow.width <= 320 ? 568 : kKeyWindow.height);
//        [_guideBtn addTarget:self action:@selector(guideBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        _guideBtn.backgroundColor = UICOLOR_RGBA(0, 0, 0, 0.7);
//        [kKeyWindow addSubview:_guideBtn];
//    }
//    [kKeyWindow bringSubviewToFront:_guideBtn];
//        /// iphone4和iphone5共用一套图
//    NSString *v = _guideBtn.width <= 320 ? @"5" : (kIsIPhone6 ? @"6" : @"6p");
//    NSString *imgName = [self.guideImgArray firstObject];
//    NSString *fullName = [NSString stringWithFormat:@"%@_%@.png", imgName, v];
//    UIImage *img = LoadLocalImgByName(fullName);
//    _guideBtn.data = imgName;
//    [_guideBtn setImage:img forState:UIControlStateNormal];
}

- (void)guideBtnClick:(UIButton *)btn
{
    NSUInteger index = [self.guideImgArray indexOfObject:btn.data];
    if ([self.guideImgArray count] <= index+1)
    {
        [_guideBtn removeFromSuperview];
        _guideBtn = nil;
        
        if (self.showGuideFinishedBlock)
        {
            self.showGuideFinishedBlock();
        }
    }
        /// iphone4和iphone5共用一套图
    NSString *v = _guideBtn.width <= 320 ? @"5" : (kIsIPhone6 ? @"6" : @"6p");
    NSString *imgName = [self.guideImgArray objectAtIndex:index];
    NSString *fullName = [NSString stringWithFormat:@"%@_%@.png", imgName, v];
    UIImage *img = LoadLocalImgByName(fullName);
    _guideBtn.data = imgName;
    [_guideBtn setImage:img forState:UIControlStateNormal];
}


@end
