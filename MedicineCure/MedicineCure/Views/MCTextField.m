//
//  MCTextField.m
//  MedicineCure
//
//  Created by line0 on 15/8/2.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "MCTextField.h"

@implementation MCTextField
{
    UIView *_textLine;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        _textLine = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-0.5, frame.size.width, 0.5)];
        _textLine.backgroundColor = kAppNormalBgColor;
        [self addSubview:_textLine];
    }
    return self;
}

@end
