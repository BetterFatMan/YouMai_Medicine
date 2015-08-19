//
//  PageEntity.h
//  MedicineCure
//
//  Created by line0 on 15/8/4.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "BaseEntity.h"

@interface PageEntity : BaseEntity

@property(nonatomic, assign) NSInteger pageCount;

@property(nonatomic, assign) NSInteger currentPage;

@end
