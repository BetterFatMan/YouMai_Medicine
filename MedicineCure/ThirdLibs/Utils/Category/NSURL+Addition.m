//
//  NSURL+Addition.m
//  Line0new
//
//  Created by trojan on 14/10/22.
//  Copyright (c) 2014年 com.line0. All rights reserved.
//

#import "NSURL+Addition.h"
#import "NSString+Addition.h"

@implementation NSURL (Addition)

    /// GET方式传递的参数数组
- (NSDictionary *)urlGetParameters
{
    NSMutableDictionary *pars = nil;
    NSArray *tempArr = [[self.absoluteString URLDecodedString] componentsSeparatedByString:@"?"];
    if ([tempArr count] > 1)
    {
        pars = [NSMutableDictionary dictionary];
        NSString *parsStr = [tempArr objectAtIndexSafe:1];
        NSArray *parsKeyValueArr = [parsStr componentsSeparatedByString:@"&"];
        for (NSString *keyValueStr in parsKeyValueArr)
        {
            if (keyValueStr.length)
            {
                NSArray *arr = [keyValueStr componentsSeparatedByString:@"="];
                if ([arr count] > 0)
                {
                    [pars setValue:@"" forKey:[arr objectAtIndexSafe:0]];
                }
                
                if ([arr count] > 1)
                {
                    [pars setValue:[arr objectAtIndexSafe:1] forKey:[arr objectAtIndexSafe:0]];
                }
            }
        }
    }
    return pars;
}

    /// 获取Scheme下GET方式传递的参数数组
- (NSDictionary *)urlGetSchemeParameters
{
    NSMutableDictionary *pars = nil;
    NSArray *tempArr = [[self.absoluteString URLDecodedString] componentsSeparatedByString:@"//"];
    if ([tempArr count] > 1)
    {
        pars = [NSMutableDictionary dictionary];
        NSString *parsStr = [tempArr objectAtIndexSafe:1];
        NSArray *parsKeyValueArr = [parsStr componentsSeparatedByString:@"&"];
        for (NSString *keyValueStr in parsKeyValueArr)
        {
            if (keyValueStr.length)
            {
                NSArray *arr = [keyValueStr componentsSeparatedByString:@"="];
                if ([arr count] > 0)
                {
                    [pars setValue:@"" forKey:[arr objectAtIndexSafe:0]];
                }
                
                if ([arr count] > 1)
                {
                    [pars setValue:[arr objectAtIndexSafe:1] forKey:[arr objectAtIndexSafe:0]];
                }
            }
        }
    }
    return pars;
}



@end
