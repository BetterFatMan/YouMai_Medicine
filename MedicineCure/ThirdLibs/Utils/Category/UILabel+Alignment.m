//
//  UILabel+Alignment.m
//  Line0New
//
//  Created by line0 on 13-11-7.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

#import "UILabel+Alignment.h"

@implementation UILabel (Alignment)

- (void)alignTop
{
    CGSize fontSize = getStringSize(self.text, self.font, CGSizeMake(MAXFLOAT, MAXFLOAT));
    double finalHeight = fontSize.height * self.numberOfLines;
    double finalWidth = self.frame.size.width;    //expected width of label
    CGSize theStringSize = getStringSizeByBreakMode(self.text, self.font, CGSizeMake(finalWidth, finalHeight), self.lineBreakMode);
    int newLinesToPad = (finalHeight  - theStringSize.height) / fontSize.height;
    for(int i=0; i<newLinesToPad; i++)
        self.text = [self.text stringByAppendingString:@"\n "];
}

- (void)alignBottom
{
    CGSize fontSize = getStringSize(self.text, self.font, CGSizeMake(MAXFLOAT, MAXFLOAT));
    double finalHeight = fontSize.height * self.numberOfLines;
    double finalWidth = self.frame.size.width;    //expected width of label
    CGSize theStringSize = getStringSizeByBreakMode(self.text, self.font, CGSizeMake(finalWidth, finalHeight), self.lineBreakMode);
    int newLinesToPad = (finalHeight  - theStringSize.height) / fontSize.height;
    for(int i=0; i<newLinesToPad; i++)
        self.text = [NSString stringWithFormat:@" \n%@",self.text];
}

@end
