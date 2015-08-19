//
//  UIFont+Alert.m
//  AlertsDemo
//
//  Created by M B. Bitar on 1/15/13.
//  Copyright (c) 2013 progenius, inc. All rights reserved.
//

#import "UIFont+Alert.h"

@implementation UIFont (Alert)

+(UIFont*)boldSystemFontThatFitsSize:(CGSize)size maxFontSize:(int)max minSize:(int)min text:(NSString*)text
{
    for(int i = max; i > min; i--) {
        UIFont *font = [UIFont boldSystemFontOfSize:i];
        CGSize _size = getStringSizeByBreakMode(text, font, CGSizeMake(size.width, MAXFLOAT), NSLineBreakByWordWrapping);
        
        if(_size.height <= size.height)
            return font;
    }
    return [UIFont boldSystemFontOfSize:min];
}

@end
