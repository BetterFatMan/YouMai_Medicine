//
//  UserDataControl.h
//  MedicineCure
//
//  Created by line0 on 15/8/3.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "BaseDataControl.h"

@class UserEntity;
@interface UserDataControl : BaseDataControl

- (void)userLogin:(NSDictionary *)params withCompleteBlock:(void(^)(BOOL isSuccess, UserEntity *entity, NSError *error))completeBlock;

- (void)userRegister:(NSDictionary *)params withCompleteBlock:(void(^)(BOOL isSuccess, UserEntity *entity, NSError *error))completeBlock;

@end
