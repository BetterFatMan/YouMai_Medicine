//
//  UserDataControl.m
//  MedicineCure
//
//  Created by line0 on 15/8/3.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "UserDataControl.h"

@implementation UserDataControl

- (void)userLogin:(NSDictionary *)params withCompleteBlock:(void(^)(BOOL isSuccess, UserEntity *entity, NSError *error))completeBlock
{
    NSDictionary *httpParams = [self defaultPars:params];
    [self postApiWithPath:kLogin params:httpParams completeBlock:^(BOOL isSuccess, MKNetworkOperation *operation, NSError *err) {
        if (isSuccess) {
            NSDictionary *response = operation.responseJSON;
            
            UserEntity *entity = [[UserEntity alloc] init];
            entity.userId      = [[response safeBindStringValue:@"userId"] integerValue];
            
            if (completeBlock) {
                completeBlock(YES, entity, err);
            }
        } else {
            if (completeBlock) {
                completeBlock(NO, nil, err);
            }
        }
    }];
}

- (void)userRegister:(NSDictionary *)params withCompleteBlock:(void(^)(BOOL isSuccess, UserEntity *entity, NSError *error))completeBlock
{
    NSDictionary *httpParams = [self defaultPars:params];
    [self postApiWithPath:kRegister params:httpParams completeBlock:^(BOOL isSuccess, MKNetworkOperation *operation, NSError *err) {
        if (isSuccess) {
            NSDictionary *response = operation.responseJSON;
            
            UserEntity *entity = [[UserEntity alloc] init];
            entity.userId      = [[response safeBindStringValue:@"userId"] integerValue];
            
            if (completeBlock) {
                completeBlock(YES, entity, err);
            }
        } else {
            if (completeBlock) {
                completeBlock(NO, nil, err);
            }
        }
    }];
}

//NSDictionary *httpParams = [self defaultPars:params];
//[self postApiWithPath:@"" params:httpParams completeBlock:^(BOOL isSuccess, MKNetworkOperation *operation, NSError *err) {
//    
//}];

@end
