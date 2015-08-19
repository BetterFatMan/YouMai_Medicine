//
//  ThreeItemsSelectView.m
//  MedicineCure
//
//  Created by line0 on 15/8/4.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "ThreeItemsSelectView.h"

@interface ThreeItemsSelectView ()
{
    UIButton *_leftBtn;
    UIButton *_midBtn;
    UIButton *_rightBtn;
}

@end

@implementation ThreeItemsSelectView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        CGFloat width = frame.size.width/3.0;
        CGFloat height = frame.size.height;
        
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(0, 0, width, height);
        _leftBtn.layer.borderWidth = 0.5;
        _leftBtn.layer.borderColor = kLineGrayColor.CGColor;
        [_leftBtn setTitleColor:kLBBlackColor forState:UIControlStateNormal];
        [_leftBtn setTitleColor:kAppNormalBgColor forState:UIControlStateSelected];
        [self addSubview:_leftBtn];
        
        _midBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _midBtn.frame = CGRectMake(width, 0, width, height);
        _midBtn.layer.borderWidth = 0.5;
        _midBtn.layer.borderColor = kLineGrayColor.CGColor;
        [_midBtn setTitleColor:kLBBlackColor forState:UIControlStateNormal];
        [_midBtn setTitleColor:kAppNormalBgColor forState:UIControlStateSelected];
        [self addSubview:_midBtn];
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(_midBtn.right, 0, width, height);
        _rightBtn.layer.borderWidth = 0.5;
        _rightBtn.layer.borderColor = kLineGrayColor.CGColor;
        [_rightBtn setTitleColor:kLBBlackColor forState:UIControlStateNormal];
        [_rightBtn setTitleColor:kAppNormalBgColor forState:UIControlStateSelected];
        [self addSubview:_rightBtn];
        
        _leftBtn.tag = 0;
        _midBtn.tag  = 1;
        _rightBtn.tag = 2;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_itemsList.count > 2)
    {
        [_leftBtn setTitle:_itemsList[0] forState:UIControlStateNormal];
        [_midBtn setTitle:_itemsList[1] forState:UIControlStateNormal];
        [_rightBtn setTitle:_itemsList[2] forState:UIControlStateNormal];
        [_leftBtn setTitle:_itemsList[0] forState:UIControlStateSelected];
        [_midBtn setTitle:_itemsList[1] forState:UIControlStateSelected];
        [_rightBtn setTitle:_itemsList[2] forState:UIControlStateSelected];
        
        if (_delegate)
        {
            [_leftBtn addTarget:_delegate action:@selector(clickThreeItemsBtn:) forControlEvents:UIControlEventTouchUpInside];
            [_midBtn addTarget:_delegate action:@selector(clickThreeItemsBtn:) forControlEvents:UIControlEventTouchUpInside];
            [_rightBtn addTarget:_delegate action:@selector(clickThreeItemsBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
        _leftBtn.selected = YES;
    }
}

- (void)clickThreeItemsBtn:(id)sender
{
    
}

@end
