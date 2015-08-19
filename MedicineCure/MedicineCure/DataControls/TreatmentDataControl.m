//
//  TreatmentDataControl.m
//  MedicineCure
//
//  Created by line0 on 15/8/4.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "TreatmentDataControl.h"


#define kAddTreatMent     (@"home/addTreatment")

@implementation TreatmentDataControl

- (void)addOneTreatment:(NSDictionary *)params withCompleteBlock:(void(^)(BOOL isSuccess, NSError *error))completeBlock
{
    NSDictionary *httpParams = [self defaultPars:params];
    [self postApiWithPath:kAddTreatMent params:httpParams completeBlock:^(BOOL isSuccess, MKNetworkOperation *operation, NSError *err) {
        if (isSuccess)
        {
            if (completeBlock)
            {
                completeBlock(YES, err);
            }
        }
        else
        {
            if (completeBlock)
            {
                completeBlock(NO, err);
            }
        }
    }];
}



@end
