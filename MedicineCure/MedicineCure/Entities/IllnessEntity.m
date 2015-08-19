//
//  IllnessEntity.m
//  MedicineCure
//
//  Created by line0 on 15/7/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IllnessEntity.h"

@implementation IllnessEntity

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super initWithDict:dict];
    if (self)
    {
        self.imageUrl = [dict safeBindStringValue:@"imageUrl"];
        self.dayTime = [dict safeBindStringValue:@"dayTime"];
        self.content = [dict safeBindStringValue:@"content"];
        self.detailContent = [dict safeBindStringValue:@"detailContent"];
        self.doneThins = [dict safeBindStringValue:@"doneThins"];
    }
    return self;
}

@end
