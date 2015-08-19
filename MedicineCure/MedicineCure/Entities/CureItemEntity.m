//
//  CureItemEntity.m
//  MedicineCure
//
//  Created by line0 on 15/8/5.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "CureItemEntity.h"

@implementation CureItemEntity

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super initWithDict:dict];
    if (self)
    {
        self.cureItemId    = [[dict safeBindStringValue:@"id"] integerValue];
        self.courseCount   = [[dict safeBindStringValue:@"courseCount"] integerValue];
        self.diseaseId     = [[dict safeBindStringValue:@"diseaseId"] integerValue];
        self.isDeleted     = [[dict safeBindStringValue:@"isDeleted"] boolValue];
        self.period        = [[dict safeBindStringValue:@"period"] integerValue];
        self.pushPeriod    = [[dict safeBindStringValue:@"pushPeriod"] integerValue];
        self.startDate     = [dict safeBindStringValue:@"startDate"];
        self.status        = [[dict safeBindStringValue:@"status"] integerValue];
        self.treatmentProcessId = [[dict safeBindStringValue:@"treatmentProcessId"] integerValue];
        self.treatmentEntity    = [[TreatmentEntity alloc] initWithDict:[dict safeBindValue:@"treatmentProcess"]];
        self.userId        = [[dict safeBindStringValue:@"userId"] integerValue];
    }
    return self;
}

@end


/*
 {"courseCount":1,"diseaseId":0,"id":4,"isDeleted":0,"period":5,"pushPeriod":1,"startDate":"2015-08-01 00:00:00","status":0,"treatmentProcess":,"treatmentProcessId":1,"userId":17}
 */