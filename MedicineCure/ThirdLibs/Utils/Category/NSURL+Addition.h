//
//  NSURL+Addition.h
//  Line0new
//
//  Created by trojan on 14/10/22.
//  Copyright (c) 2014年 com.line0. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (Addition)

    /// GET方式传递的参数数组
- (NSDictionary *)urlGetParameters;

    /// 获取Scheme下GET方式传递的参数数组
- (NSDictionary *)urlGetSchemeParameters;

@end
