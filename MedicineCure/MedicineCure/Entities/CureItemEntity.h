//
//  CureItemEntity.h
//  MedicineCure
//
//  Created by line0 on 15/8/5.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "BaseEntity.h"
#import "TreatmentEntity.h"

@interface CureItemEntity : BaseEntity

@property(nonatomic, assign) NSInteger          cureItemId;

@property(nonatomic, assign) NSInteger          courseCount;

@property(nonatomic, assign) NSInteger          diseaseId;

@property(nonatomic, assign) BOOL               isDeleted;

@property(nonatomic, assign) NSInteger          period;

@property(nonatomic, assign) NSInteger          pushPeriod;

@property(nonatomic, strong) NSString          *startDate;

@property(nonatomic, assign) NSInteger          status;

@property(nonatomic, strong) TreatmentEntity   *treatmentEntity;

@property(nonatomic, assign) NSInteger          treatmentProcessId;

@property(nonatomic, assign) NSInteger          userId;

@end
    /*
     {"courseCount":1,"diseaseId":0,"id":4,"isDeleted":0,"period":5,"pushPeriod":1,"startDate":"2015-08-01 00:00:00","status":0,"treatmentProcess":,"treatmentProcessId":1,"userId":17}
     */