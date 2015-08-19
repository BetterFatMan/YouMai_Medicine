//
//  MCWordText.m
//  MedicineCure
//
//  Created by line0 on 15/8/3.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "MCWordText.h"


@implementation MCWordText

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        CGFloat width  = frame.size.width;
        CGFloat height = frame.size.height;
        
        _nameImage = [[UIImageView alloc ] initWithFrame:CGRectMake(5, (height - 20)/2, 20, 20)];
        [self addSubview:_nameImage];
        
        _wordTextField = [[MCTextField alloc] initWithFrame:CGRectMake(_nameImage.right + 2, 0, width - 32, height)];
        _wordTextField.textAlignment = NSTextAlignmentCenter;
        _wordTextField.textColor     = UICOLOR_RGB(0xf8, 0xd4, 0xd8);
        _wordTextField.font          = gFontSystemSize(15);
        [self addSubview:_wordTextField];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, height - 0.5, width, 0.5)];
        [self addSubview:line];
        line.backgroundColor = UICOLOR_RGB(0xf6, 0x9d, 0xa0);
    }
    return self;
}

@end
