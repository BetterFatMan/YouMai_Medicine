//
//  TreatmentEntity.h
//  MedicineCure
//
//  Created by line0 on 15/8/4.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "BaseEntity.h"

@interface TreatmentEntity : BaseEntity

@property(nonatomic, strong) NSString *name;

@property(nonatomic, assign) NSInteger pushPeriod;

@property(nonatomic, assign) NSInteger status;

@property(nonatomic, assign) BOOL      isDeleted;

@property(nonatomic, assign) NSInteger treatmentProcessId;

@property(nonatomic, assign) NSInteger type;

@end

    /*
     "name": "手术",
     
     "pushPeriod": 1,
     
     "status": 0,
     
     "treatmentProcessId": 1,
     
     "type": 0
     */
/*"userId": "1",//
 
 "treatmentProcessId": "1",//治疗处理Id
 
 "courseCount": "1",//疗程
 
 "period": "1",//单个疗程天数
 
 "pushPeriod": "1",//推送的文章更新周期（从治疗类里面获取）
 
 "startDate": "2015-07-31"//开始时间*/