//
//  UIButton+Addition.m
//  Line0new
//
//  Created by trojan on 14/10/30.
//  Copyright (c) 2014年 com.line0. All rights reserved.
//

#import "UIButton+Addition.h"
#include <objc/runtime.h>

@implementation UIButton (Ext)

- (void)setData:(NSObject *)data
{
    objc_setAssociatedObject(self, "data", data, OBJC_ASSOCIATION_RETAIN);
}

- (NSObject *)data
{
    return objc_getAssociatedObject(self, "data");
}


@end
