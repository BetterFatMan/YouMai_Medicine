//
//  CommonDataControl.h
//  MedicineCure
//
//  Created by line0 on 15/8/4.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "BaseDataControl.h"

@interface CommonDataControl : BaseDataControl

- (void)homeInit:(NSDictionary *)params withCompleteBlock:(void(^)(BOOL isSuccess, NSArray *items, NSArray *ummList,NSArray *utmList, NSError *error))completeBlock;

    /// 拉取治疗列表
- (void)getTreatmentList:(NSDictionary *)params withCompleteBlock:(void(^)(BOOL isSuccess, NSArray *treatmentList, NSError *error))completeBlock;

    /// 拉取药物列表
- (void)getMedicineList:(NSDictionary *)params withCompleteBlock:(void(^)(BOOL isSuccess, NSArray *medicineList, NSError *error))completeBlock;

    /// 添加一次药品
- (void)addOneMedicine:(NSDictionary *)params withCompleteBlock:(void(^)(BOOL isSuccess, NSError *error))completeBlock;

@end
