//
//  UIPasteboard+Addition.m
//  Line0new
//
//  Created by trojan on 15/3/2.
//  Copyright (c) 2015年 com.line0. All rights reserved.
//

#import "UIPasteboard+Addition.h"

@implementation UIPasteboard (Ext)

+ (void)_accessibilityUseQuickSpeakPasteBoard
{
    NSLog(@"_accessibilityUseQuickSpeakPasteBoard callStackSymbols %@", [NSThread callStackSymbols]);
}

+ (void)accessibilityUseQuickSpeakPasteBoard
{
    NSLog(@"accessibilityUseQuickSpeakPasteBoard callStackSymbols %@", [NSThread callStackSymbols]);
}



@end
