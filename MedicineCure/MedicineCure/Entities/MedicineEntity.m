//
//  MedicineEntity.m
//  MedicineCure
//
//  Created by line0 on 15/8/7.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "MedicineEntity.h"

@implementation MedicineEntity

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super initWithDict:dict];
    if (self)
    {
        NSDictionary *medicine = [dict safeBindValue:@"medicine"];
        
        self.medicineId     = [[dict safeBindStringValue:@"medicineId"] integerValue];
        self.medicineName   = [medicine safeBindStringValue:@"medicineName"];
        self.detailUrl      = [dict safeBindStringValue:@"detailUrl"];
        self.dictionary     = [medicine safeBindStringValue:@"dictionary"];
        
        self.diseaseId      = [[dict safeBindStringValue:@"diseaseId"] integerValue];
        self.dosage         = [[dict safeBindStringValue:@"dosage"] integerValue];
        self.frequency      = [[dict safeBindStringValue:@"frequency"] integerValue];
        
//        self.firtName = @"药";
        if (self.medicineName.length > 0) {
            self.firtName = [self.medicineName substringToIndex:1];
        }
    }
    return self;
}

@end

/*dosage = 2;
 endDate = "2015-08-25 00:00:00";
 frequency = 1;
 id = 11;
 isDeleted = 0;
 medicine =     {
 detailUrl = "www.baidu.com";
 dictionary = T;
 diseaseId = 1;
 dosage = 1;
 frequency = 1;
 isDeleted = 0;
 medicineId = 1;
 medicineName = "\U4ed6\U83ab\U6614\U82ac";
 status = 0;
 };
 medicineId = 1;
 startDate = "2015-08-08 00:00:00";
 status = 0;
 userId = 17;*/



/*"detailUrl": "www.baidu.com",
 
 "dictionary": "A",//字典
 
 "diseaseId": 1,//疾病id
 
 "dosage": 1,//用量
 
 "frequency": 1,//一天几次
 
 "medicineId": 1,
 
 "medicineName":“A药品”*/


