//
//  UINavigationBar+Addition.m
//  Line0New
//
//  Created by line0 on 13-12-12.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

#import "UINavigationBar+Addition.h"
#import <QuartzCore/QuartzCore.h>

@implementation UINavigationBar (Addition)

- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity
{
    // Creating shadow path for better performance
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    self.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = opacity;
    
    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
    self.clipsToBounds = NO;
    
}  

@end
