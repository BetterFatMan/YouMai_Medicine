//
//  WXPayEntryActivity.m
//  Line0new
//
//  Created by line0 on 14-6-27.
//  Copyright (c) 2014年 zhanglei. All rights reserved.
//

#import "WXPayEntryActivity.h"

@implementation WXPayEntryActivity

+(void)payOrderStringAtWXWithDetail:(NSDictionary*)orderString {
    PayReq * payRequest = [[PayReq alloc] init];
    
    payRequest.openID = [orderString objectForKey:@"appId"];
    payRequest.partnerId = [orderString objectForKey:@"partnerId"];
    payRequest.prepayId = [orderString objectForKey:@"prepayId"];
    payRequest.nonceStr = [orderString objectForKey:@"nonceStr"];
    payRequest.timeStamp = (UInt32)[[orderString objectForKey:@"timeStamp"] integerValue];
    payRequest.package = @"Sign=WXPay";
    
    payRequest.sign = [orderString objectForKey:@"signIos"];
    
    BOOL rect = [WXApi sendReq:payRequest];
    if (!rect) {
        NSLog(@"WX Pay Failed!");
    }
}

@end