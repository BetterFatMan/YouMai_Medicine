//
//  UILabel+Addition.m
//  Line0new
//
//  Created by trojan on 14/12/30.
//  Copyright (c) 2014年 com.line0. All rights reserved.
//

#import "UILabel+Addition.h"

@implementation UILabel(Addition)

- (void)clearColorSizeTxtColorAlignment:(CGFloat)sysFontSize color:(UIColor *)color align:(NSTextAlignment)align
{
    self.backgroundColor = [UIColor clearColor];
    self.font = [UIFont systemFontOfSize:sysFontSize];
    self.textColor = color;
    self.textAlignment = align;
}

@end
