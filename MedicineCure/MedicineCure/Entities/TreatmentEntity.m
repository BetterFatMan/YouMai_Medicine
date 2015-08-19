//
//  TreatmentEntity.m
//  MedicineCure
//
//  Created by line0 on 15/8/4.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "TreatmentEntity.h"

@implementation TreatmentEntity

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super initWithDict:dict];
    if (self)
    {
        self.name               = [dict safeBindStringValue:@"name"];
        self.pushPeriod         = [[dict safeBindStringValue:@"pushPeriod"] integerValue];
        self.status             = [[dict safeBindStringValue:@"status"] integerValue];
        self.treatmentProcessId = [[dict safeBindStringValue:@"treatmentProcessId"] integerValue];
        self.type               = [[dict safeBindStringValue:@"type"] integerValue];
        self.isDeleted          = [[dict safeBindStringValue:@"isDeleted"] boolValue];
    }
    return self;
}

- (NSArray *)serializeProperties
{
    return @[ @"name", @"pushPeriod", @"status", @"isDeleted", @"treatmentProcessId", @"type" ];
}

@end
/*
 "name": "手术",
 
 "pushPeriod": 1,
 
 "status": 0,
 
 "treatmentProcessId": 1,
 
 "type": 0
 */
