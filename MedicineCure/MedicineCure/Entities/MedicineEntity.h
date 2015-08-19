//
//  MedicineEntity.h
//  MedicineCure
//
//  Created by line0 on 15/8/7.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "BaseEntity.h"

@interface MedicineEntity : BaseEntity

@property(nonatomic, assign) NSInteger  medicineId;

@property(nonatomic, strong) NSString  *medicineName;
@property(nonatomic, strong) NSString  *firtName;

@property(nonatomic, strong) NSString  *detailUrl;

@property(nonatomic, strong) NSString  *dictionary;

@property(nonatomic, assign) NSInteger  diseaseId;
@property(nonatomic, assign) NSInteger  dosage;
@property(nonatomic, assign) NSInteger  frequency;

@end

/*"detailUrl": "www.baidu.com",
 
 "dictionary": "A",//字典
 
 "diseaseId": 1,//疾病id
 
 "dosage": 1,//用量
 
 "frequency": 1,//一天几次
 
 "medicineId": 1,
 
 "medicineName":“A药品”*/