//
//  BaseDataControl.h
//  Line0new
//
//  Created by line0_dev on 14-7-29.
//  Copyright (c) 2014年 com.line0. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "BaseEntity.h"
#import "MKNetworkKit.h"

    /// 用户信息相关错误码
    /// 登录过期
#define kLoginExp                           (-10)
    /// 接口的未知错误
#define kUnknownApiErrCode                  (-10000)
    /// 接口返回的response字段数据错误
#define kApiResponseDataErrCode             (-101)
    /// 用户名或密码为空
#define kNullUsernamePassword               (100001)
    /// 用户名或密码错误
#define kErrorUsernamePassword              (100003)
    /// 手机号码格式错误
#define kErrorPhone                         (100005)
    /// 邮箱格式错误
#define kErrorEmail                         (100006)
    /// 推荐人手机号码错误
#define kErrorReferPhone                    (100007)
    /// 手机号已经被注册
#define kIsusedPhone                        (100008)
    /// 邮箱已经被注册
#define kIsusedEmail                        (100009)
    /// 旧密码错误
#define kErrorOldPassword                   (100010)
    /// 头像上传失败
#define kErrorUploadAvatar                  (100011)
    ///验证码已过期，请重新获取
#define kErrorexpiredCode                   (100012)
    ///手机号未注册
#define kErrorNotusedPhone                  (100013)
    ///错误的验证码
#define kErrorValidateCode                  (100014)
    ///快捷登录用户
#define kErrorFastLoginUser                 (100015)
    ///图片验证失败
#define kErrorImgCode                       (100016)
#define kErrorEmptyRegistId                 (100018)



    /// 订单相关错误码
    /// 该订单不能取消
#define kErrorOrderCantCancel               (300003)
    /// 该订单不能更改支付方式
#define kErrorOrderCantChangePayType        (300007)
    /// 创建订单失败(预约时间选择错误)
#define kErrorOrderCreateFailed             (300010)

    /// 优惠券相关错误码
    /// 优惠券不可用
#define kErrorCouponCantUse                 (400001)

    /// 店铺商品相关错误码
    /// 店铺不存在
#define kErrorShopNotExist                  (500001)
    /// 超出该店铺配送范围
#define kErrorShopOutOfDelivery             (500004)
    /// 该商品已经下架
#define kErrorProductOffShelves             (500005)
    /// 超出服务范围
#define kErrorOutOfService                  (500010)

    //接口响应中status正确值(即未出错时)
#define kApiResponseOk                      (1)
#define kRequestTimeOut                     (60)

typedef void (^apiResponseSimpleCompleteBlock)(BOOL isSuccess, NSError *err);
typedef void (^apiResponseWithArrCompleteBlock)(BOOL isSuccess, NSArray *dataArr, int totalPage, int totalCount, NSError *err);
typedef void (^apiResponseWithEntityCompleteBlock)(BOOL isSuccess, BaseEntity *entity, NSError *err);
typedef void (^apiResponseWithDictCompleteBlock)(BOOL isSuccess, NSDictionary *dict, NSError *err);



@interface NSError(Ext)
    /// 扩展属性
@property(nonatomic, strong) NSString *errMsg;

@end






@interface BaseDataControl : NSObject

+ (MKNetworkEngine *)shareEngine;

+ (NSError *)errorWithApiErrorCode:(long)errCode errMsg:(NSString *)errMsg;

    ///如果子类也要使用, 则子类必须实现该方法, 默认返回nil
+ (instancetype)shareDataControl;

- (void)getApiWithPath:(NSString *)path params:(NSDictionary *)params completeBlock:(void (^)(BOOL isSuccess, MKNetworkOperation *operation, NSError *err))completeBlock;

- (void)postApiWithPath:(NSString *)path params:(NSDictionary *)params completeBlock:(void (^)(BOOL isSuccess, MKNetworkOperation *operation, NSError *err))completeBlock;
    
- (void)postApiWithPath:(NSString *)path params:(NSDictionary *)params files:(NSDictionary *)files completeBlock:(void (^)(BOOL isSuccess, MKNetworkOperation *operation, NSError *err))completeBlock;

    /// 上传图片
- (void)postImgApiWithPath:(NSString *)path params:(NSDictionary *)params files:(NSDictionary *)files completeBlock:(void (^)(BOOL isSuccess, MKNetworkOperation *operation, NSError *err))completeBlock;

+ (void)cancelOperationsContainingURLString:(NSString *)url;

+ (void)cancelAllRequest;

+ (NSMutableDictionary *)appendDefaultPars:(NSDictionary *)pars;

- (NSMutableDictionary *)defaultPars:(NSDictionary *)pars;
    /// isNeedLocation是否在默认参数中添加位置信息参数(userX, userY)
- (NSMutableDictionary *)defaultPars:(NSDictionary *)pars isNeedLocation:(BOOL)isNeedLocation;

- (void)cancelOperation;

@end






