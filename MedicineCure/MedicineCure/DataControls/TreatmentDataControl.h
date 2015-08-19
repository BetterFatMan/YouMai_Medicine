//
//  TreatmentDataControl.h
//  MedicineCure
//
//  Created by line0 on 15/8/4.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "BaseDataControl.h"

@interface TreatmentDataControl : BaseDataControl

    /// 添加一次治疗
- (void)addOneTreatment:(NSDictionary *)params withCompleteBlock:(void(^)(BOOL isSuccess, NSError *error))completeBlock;

@end
