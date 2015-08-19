//
//  UINavigationBar+Addition.h
//  Line0New
//
//  Created by line0 on 13-12-12.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Addition)

- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity;
@end
