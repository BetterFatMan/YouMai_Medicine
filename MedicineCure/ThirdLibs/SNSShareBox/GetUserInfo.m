//
//  GetUserInfo.m
//  Line0new
//
//  Created by user on 14-8-29.
//  Copyright (c) 2014年 com.line0. All rights reserved.
//

#import "GetUserInfo.h"
#import "BaseDataControl.h"

@implementation GetUserInfo

+ (NSDictionary *)sendRequest:(NSURL *)url completeBlock:(void (^)(NSDictionary *resultDict))completeBlock
{
    NSUInteger locat = [url.absoluteString rangeOfString:@"?"].location;
    NSString *parsStr = @"";
    NSDictionary *userInfoArr = [[NSDictionary alloc] init];
    if (locat != NSNotFound)
    {
        parsStr = [url.absoluteString substringFromIndex:locat];
    }
    MKNetworkEngine *networkEngine = [[MKNetworkEngine alloc] initWithHostName:url.host];
    MKNetworkOperation *operation = [networkEngine operationWithPath:[NSString stringWithFormat:@"%@%@", url.relativePath, parsStr]
                                                              params:@{}
                                                          httpMethod:@"GET" ssl:YES];
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation){
        NSDictionary *respDict = completedOperation.responseJSON;
    
        if (completeBlock)
        {
            completeBlock(respDict);
        }
    }errorHandler:^(MKNetworkOperation *completedOperation, NSError *error){
        
        NSLog(@"completedOperation %@\n\n\n error %@", completedOperation, error);
        
        if (completeBlock)
        {
            completeBlock(nil);
        }
    }];
    [networkEngine enqueueOperation:operation];
    return userInfoArr;
}

+ (void)userInfo:(NSString *)urlString andType:(NSString *)otherType completeBlock:(void (^)(NSMutableArray *arr))completeBlock
{
        //网络请求的url
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [self sendRequest:url completeBlock:^(NSDictionary *resultDict) {
        
        if ([resultDict.allKeys containsObject:@"errcode"])
        {
            if (completeBlock)
            {
                completeBlock(nil);
            }
            return ;
        }

        if (resultDict)
        {
            NSMutableArray *userInfoArr = [NSMutableArray array];
            NSString *nickname = @"";
            NSString *imageurl = @"";
            NSString *gender = @"";
                ///从微信端获取的unionid
            NSString *unionid = @"";
            if ([otherType isEqualToString:@"qq"])
            {
                nickname = [resultDict safeBindStringValue:@"nickname"];
                    ///如果存在100 * 100的头像就用100 * 100，否则用40 * 40
                if (nil != [resultDict safeBindStringValue:@"figureurl_qq_2"])
                {
                    imageurl = [resultDict safeBindStringValue:@"figureurl_qq_2"];
                }
                else
                {
                    imageurl = [resultDict safeBindStringValue:@"figureurl_qq_1"];
                }
                if ([[resultDict safeBindStringValue:@"gender"]isEqualToString:@"男"])
                {
                    gender = @"0";
                }
                else
                {
                    gender = @"1";
                }
            }
            else if ([otherType isEqualToString:@"weibo"])
            {
                nickname = [resultDict safeBindStringValue:@"screen_name"];
                imageurl = [resultDict safeBindStringValue:@"avatar_large"];
                gender = [resultDict safeBindStringValue:@"gender"];
                if ([gender isEqualToString:@"f"])
                {
                    gender = @"1";
                }
                else if ([gender isEqualToString:@"m"])
                {
                    gender = @"0";
                }
                
            }
            else if ([otherType isEqualToString:@"weixin"])
            {
                nickname = [resultDict safeBindStringValue:@"nickname"];
                imageurl = [resultDict safeBindStringValue:@"headimgurl"];
                unionid = [resultDict safeBindStringValue:@"unionid"];
                [UserDefaultControl shareInstance].cacheWXUnionID = unionid;
                gender = [NSString stringWithFormat:@"%@",[resultDict safeBindValue:@"sex"]];
                if ([gender isEqualToString:@"1"])
                {
                    gender = @"0";
                }
                else if ([gender isEqualToString:@"2"])
                {
                    gender = @"1";
                }
            }
            [userInfoArr addObject:nickname?:@""];
            [userInfoArr addObject:imageurl?:@""];
            [userInfoArr addObject:gender?:@""];
            if (completeBlock)
            {
                completeBlock(userInfoArr);
            }
        }
    }];
}

@end
