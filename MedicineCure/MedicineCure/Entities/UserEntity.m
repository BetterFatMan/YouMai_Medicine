//
//  UserEntity.m
//  MedicineCure
//
//  Created by line0 on 15/8/2.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "UserEntity.h"

@implementation UserEntity

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super initWithDict:dict];
    if (self)
    {
        self.userId = [[dict safeBindStringValue:@"userId"] integerValue];
    }
    return self;
}

- (NSArray *)serializeProperties
{
    return @[ @"userId" ];
}

@end
