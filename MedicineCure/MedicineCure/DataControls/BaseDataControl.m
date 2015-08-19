//
//  BaseDataControl.m
//  Line0new
//
//  Created by line0_dev on 14-7-29.
//  Copyright (c) 2014年 com.line0. All rights reserved.
//

#import "BaseDataControl.h"
#import "UIDevice+DeviceInfo.h"
#import "OpenUDID.h"

@implementation NSError(Ext)

- (void)setErrMsg:(NSString *)msg
{
    objc_setAssociatedObject(self, "errMsg", msg, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)errMsg
{
    return objc_getAssociatedObject(self, "errMsg");
}

- (NSString *)localizedDescription
{
#ifdef DEBUG
    return self.errMsg ? self.errMsg : [NSString stringWithFormat:@"未知错误, 错误码%ld, 原始错误信息:\n%@\n", (long)self.code, [self.userInfo objectForKey:NSLocalizedDescriptionKey]];
#endif
    return self.errMsg ? self.errMsg : [NSString stringWithFormat:@"未知错误, 错误码%ld", (long)self.code];
}

@end



@implementation BaseDataControl
static MKNetworkEngine *_shareInstanceEngine = nil;
static MKNetworkEngine *_shareImgPostEngine = nil;

+ (MKNetworkEngine *)shareEngine
{
    if (!_shareInstanceEngine)
    {
        NSString *baseUrl = kMainWebsite;
        _shareInstanceEngine = [[MKNetworkEngine alloc] initWithHostName:baseUrl];
        [UIImageView setDefaultEngine:_shareInstanceEngine];
        [_shareInstanceEngine useCache];
    }
    return _shareInstanceEngine;
}

+ (MKNetworkEngine *)shareImgPostEngine
{
    if (!_shareImgPostEngine)
    {
        _shareImgPostEngine = [[MKNetworkEngine alloc] initWithHostName:@"img.line0.com"];
        [UIImageView setDefaultEngine:_shareImgPostEngine];
        [_shareImgPostEngine useCache];
    }
    return _shareImgPostEngine;
}

+ (NSError *)errorWithApiErrorCode:(long)errCode errMsg:(NSString *)errMsg
{
        //这里最好是读取一个配置文件(json格式{"404":"服务错误"}), 根据errCode找对应的错误提示信息
    switch (errCode)
    {
        case kLoginExp:
            errMsg = @"登录状态已失效，请重新登录";
            break;
        case 504:
            errMsg = @"网络连接失败, 服务器出问题了(504)";
            break;
        case 306:
            errMsg = @"网络连接失败, 服务器出问题了(306)";
            break;
        case -1009:
            errMsg = @"网络连接失败, 请检查您的网络. 如是否设置了代理等";
            break;
        case -1001:
            errMsg = @"网络请求超时(-1001)";
            break;
        case -1004:
            errMsg = @"未能连接到服务器(-1004)";
            break;
        case 400:
        case 404:
            errMsg = @"http错误";
            break;
        case 500:
            errMsg = @"服务器出现错误(http status code 500)";
            break;
        case kUnknownApiErrCode:
            errMsg = @"请求出现未知错误";
            break;
        case kNullUsernamePassword:
            errMsg = @"用户名或密码为空";
            break;
        case kErrorUsernamePassword:
            errMsg = @"用户名或密码错误";
            break;
        case kErrorPhone:
            errMsg = @"手机号码格式错误";
            break;
        case kErrorEmail:
            errMsg = @"邮箱格式错误";
            break;
        case kErrorReferPhone:
            errMsg = @"推荐人手机号码错误";
            break;
        case kIsusedPhone:
            errMsg = @"手机号已经被注册";
            break;
        case kIsusedEmail:
            errMsg = @"邮箱已经被注册";
            break;
        case kErrorOldPassword:
            errMsg = @"旧密码错误";
            break;
        case kErrorUploadAvatar:
            errMsg = @"上传头像失败";
            break;
        case kErrorOrderCantCancel:
            errMsg = @"该订单不能取消";
            break;
        case kErrorOrderCantChangePayType:
            errMsg = @"该订单不能更改支付方式";
            break;
        case kErrorOrderCreateFailed:
            errMsg = [NSString stringWithFormat:@"创建订单失败(%@)", errMsg];
            break;
        case kErrorCouponCantUse:
            errMsg = [NSString stringWithFormat:@"优惠券不可用(%@)", errMsg];
            break;
        case kErrorShopNotExist:
            errMsg = @"店铺不存在";
            break;
        case kErrorShopOutOfDelivery:
            errMsg = @"超出该店铺配送范围";
            break;
        case kErrorOutOfService:
            errMsg = @"超出服务范围";
            break;
        case kErrorProductOffShelves:
            errMsg = @"该商品已经下架";
            break;
        case kErrorNotusedPhone:
            errMsg = @"手机号未注册";
            break;
        case kErrorexpiredCode:
            errMsg = @"验证码已过期\n请重新获取";
            break;
        case kErrorValidateCode:
            errMsg = @"您输入的验证码有误\n请重新输入";
            break;
        case kErrorFastLoginUser:
            errMsg = @"快捷登录用户";
            break;
        case kErrorImgCode:
            errMsg = @"图片验证失败";
            break;
        case kErrorEmptyRegistId:
            errMsg = @"注册码为空";
            break;
        default:
            break;
    }
    
    NSError *err = [NSError errorWithDomain:@"com.line0.err" code:errCode userInfo:nil];
    err.errMsg = errMsg;
    return err;
}


    ///如果子类也要使用, 则子类必须实现该方法
+ (instancetype)shareDataControl
{
    return nil;
}

- (void)dealloc
{
    NSLog(@"cancelOperation by dealloc %@", [NSString stringWithFormat:@"%@", self]);
    [self cancelOperation];
}

- (void)cancelOperation
{
    NSLog(@"cancelOperation %@", [NSString stringWithFormat:@"%@", self]);
    [MKNetworkEngine cancelOperationsContainingURLString:[NSString stringWithFormat:@"%@", self]];
}

- (void)getApiWithPath:(NSString *)path params:(NSDictionary *)params completeBlock:(void (^)(BOOL isSuccess, MKNetworkOperation *operation, NSError *err))completeBlock
{
    [self makeRequestOperation:path params:params files:nil httpMethod:@"GET" networkEngine:nil completeBlock:completeBlock];
}


- (void)postApiWithPath:(NSString *)path params:(NSDictionary *)params completeBlock:(void (^)(BOOL isSuccess, MKNetworkOperation *operation, NSError *err))completeBlock
{
    [self makeRequestOperation:path params:params files:nil httpMethod:@"POST" networkEngine:nil completeBlock:completeBlock];
}


- (void)postApiWithPath:(NSString *)path params:(NSDictionary *)params files:(NSDictionary *)files completeBlock:(void (^)(BOOL isSuccess, MKNetworkOperation *operation, NSError *err))completeBlock
{
    [self makeRequestOperation:path params:params files:files httpMethod:@"POST" networkEngine:nil completeBlock:completeBlock];
}

    /// 上传图片
- (void)postImgApiWithPath:(NSString *)path params:(NSDictionary *)params files:(NSDictionary *)files completeBlock:(void (^)(BOOL isSuccess, MKNetworkOperation *operation, NSError *err))completeBlock
{
    [self makeRequestOperation:path params:params files:files httpMethod:@"POST" networkEngine:[[self class] shareEngine] completeBlock:completeBlock];
}

- (void)makeRequestOperation:(NSString *)path params:(NSDictionary *)params files:(NSDictionary *)files httpMethod:(NSString *)method networkEngine:(MKNetworkEngine *)netEngine completeBlock:(void (^)(BOOL isSuccess, MKNetworkOperation *operation, NSError *err))completeBlock
{
    method = method ? method : @"GET";
    MKNetworkEngine *networkEngine = netEngine ? netEngine : [[self class] shareEngine];
    NSMutableDictionary *conbinePars = [NSMutableDictionary dictionary];
    if ([params count])
    {
        if ([method isEqualToString:@"POST"] && ![files count])
        {
            [conbinePars addEntriesFromDictionary:@{@"params" : params}];
        }
        else
        {
            [conbinePars addEntriesFromDictionary:params];
        }
    }
    
    MKNetworkOperation *operation = [networkEngine operationWithPath:path params:conbinePars httpMethod:method];
    ((NSMutableURLRequest *)operation.readonlyRequest).timeoutInterval = kRequestTimeOut;
    
//    NSLog(@"identifier %@ %@",  self, [NSThread callStackSymbols]);
    operation.operationIdentifier = [NSString stringWithFormat:@"%@_%lf", self, [[NSDate date] timeIntervalSince1970]];
    
    if ([files count])
    {
        method = @"POST";
        for (NSString *key in files.allKeys)
        {
            if (params && [params count])
            {
                NSString *ext = [[files[key] pathExtension] lowercaseString];
                NSString *mimeType = @"multipart/form-data";
                if ([ext isEqualToString:@"jpg"])
                {
                    mimeType = @"image/jpg";
                }
                else if ([ext isEqualToString:@"jpeg"])
                {
                    mimeType = @"image/jpeg";
                }
                else if ([ext isEqualToString:@"png"])
                {
                    mimeType = @"image/png";
                }
                else if ([ext isEqualToString:@"m4a"])
                {
                    mimeType = @"audio/m4a";
                }
                else if ([ext isEqualToString:@"mp4"])
                {
                    mimeType = @"video/mp4";
                }
                [operation addFile:files[key] forKey:key mimeType:mimeType];
            }
            else
            {
                [operation addFile:files[key] forKey:key];
                    // setFreezable uploads your images after connection is restored!
                [operation setFreezable:YES];
            }
        }
    }
    
    if([method isEqualToString:@"POST"] && ![files count])
    {
        operation.postDataEncoding = MKNKPostDataEncodingTypeJSON;
    }

    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation){
        
        NSLog(@"REQUEST SUCCESS %@", completedOperation);
            //所有接口返回的错误都将会在这里被处理, 转化成相应的NSError并返回给调用方, 以便提示
        NSError *err = nil;
        BOOL isSuccess = YES;
        NSDictionary *respDict = completedOperation.responseJSON;
        if (completedOperation.HTTPStatusCode != 200)
        {
            err = [BaseDataControl errorWithApiErrorCode:completedOperation.HTTPStatusCode errMsg:[NSString stringWithFormat:@"http请求错误, 错误码%ld", (long)completedOperation.HTTPStatusCode]];
            isSuccess = NO;
        }
        else if (![respDict isKindOfClass:[NSDictionary class]])
        {
                //ERROR CODE :-10000未知错误
            err = [BaseDataControl errorWithApiErrorCode:kUnknownApiErrCode errMsg:@"未知错误"];
            isSuccess = NO;
        }
        else
        {
            NSDictionary *responseDict = [respDict safeBindValue:@"response"];
            if (!responseDict)
            {
                responseDict = respDict;
            }
            if (![responseDict isKindOfClass:[NSDictionary class]])
            {
                    //ERROR CODE :-101未知错误
                err = [BaseDataControl errorWithApiErrorCode:kApiResponseDataErrCode errMsg:@"返回response数据格式错误"];
                isSuccess = NO;
            }
            else
            {
                int errCode = [[responseDict safeBindValue:@"errorCode"] intValue];
                NSString *errMsg = [responseDict safeBindValue:@"msg"];
                if (errCode != kApiResponseOk)
                {
                    err = [BaseDataControl errorWithApiErrorCode:errCode errMsg:errMsg];
                    isSuccess = NO;
                }
            }
        }
        
        if (completeBlock)
        {
            completeBlock(isSuccess, completedOperation, err);
        }
            /// 如果登录失效 弹出登录框
        if (err.code == kLoginExp)
        {
//            [[GlobalControl shareInstance] logout];
            dispatch_main_sync_safe(^{
                
//                [kNotificationCenter postNotificationName:kShowUserLoginView object:nil];
            });
        }
    }
    errorHandler:^(MKNetworkOperation *completedOperation, NSError *error){
        
        NSError *err = [BaseDataControl errorWithApiErrorCode:error.code errMsg:error.localizedDescription];
        if (completeBlock)
        {
            completeBlock(NO, completedOperation, err);
        }
    }];
    [networkEngine enqueueOperation:operation];
}


+ (void)cancelOperationsContainingURLString:(NSString *)url
{
    [MKNetworkEngine cancelOperationsContainingURLString:url];
}


+ (void)cancelAllRequest
{
    NSString *baseUrl = kMainWebsite;
    [MKNetworkEngine cancelOperationsContainingURLString:baseUrl];
}

+ (NSMutableDictionary *)appendDefaultPars:(NSDictionary *)pars
{
    return [self appendDefaultPars:pars isNeedLocation:YES];
}

+ (NSMutableDictionary *)appendDefaultPars:(NSDictionary *)pars isNeedLocation:(BOOL)isNeedLocation
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    UserAddressEntity *addr = [UserDefaultControl shareInstance].cacheUserAddrEntity;
//    long cityId = addr.cityId;
//    [params setObject:@(cityId) forKey:@"cityId"];
//    NSString *userToken = [GlobalControl shareInstance].loginUser.userToken;
//    [params setObject:userToken ? : @"" forKey:@"userToken"];
//    [params setObject:[UIDevice deviceVersion]?:@"" forKey:@"deviceType"];
    [params setObject:@(kSource).stringValue forKey:@"source"];
    
    if (pars && [pars isKindOfClass:[NSDictionary class]])
    {
        [params addEntriesFromDictionary:pars];
    }
    return params;
}

- (NSMutableDictionary *)defaultPars:(NSDictionary *)pars
{
    return [[self class] appendDefaultPars:pars];
}

    /// isNeedLocation是否在默认参数中添加位置信息参数(userX, userY)
- (NSMutableDictionary *)defaultPars:(NSDictionary *)pars isNeedLocation:(BOOL)isNeedLocation
{
    return [[self class] appendDefaultPars:pars isNeedLocation:isNeedLocation];
}

@end
