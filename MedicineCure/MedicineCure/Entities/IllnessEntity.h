//
//  IllnessEntity.h
//  MedicineCure
//
//  Created by line0 on 15/7/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "BaseEntity.h"

@interface IllnessEntity : BaseEntity

@property(nonatomic, strong) NSString *dayTime;

@property(nonatomic, strong) NSString *imageUrl;

@property(nonatomic, strong) NSString *content;

@property(nonatomic, strong) NSString *detailContent;

@property(nonatomic, strong) NSString *doneThins;

@property(nonatomic, assign) int       imageType;

    /// 用于判断是否当天信息
@property(nonatomic, assign) BOOL    isTouday;

@end
