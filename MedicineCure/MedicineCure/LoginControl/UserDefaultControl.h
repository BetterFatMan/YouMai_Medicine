//
//  UserDefaultControl.h
//  Line0new
//
//  Created by trojan on 14-8-4.
//  Copyright (c) 2014年 com.line0. All rights reserved.
//  当前类是操作所有NSUserDefault的缓存值的统一入口

#import <Foundation/Foundation.h>
#import "UserEntity.h"

@interface UserDefaultControl : NSObject

+ (instancetype)shareInstance;

    /// 注意 这里的所有属性最好全部以 cacheXxx方式(即开头包含"cache")

    /// 读取与写入banner的缓存数据
//@property(nonatomic, assign) NSArray        *cacheBanner;
//    /// 读取与写入上次图片缓存时间
//@property(nonatomic, assign) NSDate         *cacheLastImgCacheDate;
//    /// 读取与写入零号线当前支持的城市列表
//@property(nonatomic, assign) NSArray        *cacheSupportCityArr;
    /// 读取与写入当前登录过的用户信息
@property(nonatomic, assign) UserEntity     *cacheLoginedUserEntity;
//    /// 读取与写入当前用户所在城市信息
//@property(nonatomic, assign) CityEntity     *cacheUserCityEntity;
//    /// 读取与写入微信认证时间
//@property(nonatomic, assign) NSString       *cacheWXExpiresIn;
//    /// 读取与写入微信access_token
//@property(nonatomic, assign) NSString       *cacheWXAccessToken;
//    /// 读取与写入微信openid
//@property(nonatomic, assign) NSString       *cacheWXOpenID;
//    /// 读取与写入微博认证时间
//@property(nonatomic, assign) NSString       *cacheSinaExpiresIn;
//    /// 读取与写入微博用户id
//@property(nonatomic, assign) NSString       *cacheSinaUserID;
//    /// 读取与写入微博access_token
//@property(nonatomic, assign) NSString       *cacheSinaAccessToken;
//    /// 读取与写入qq OpenID
//@property(nonatomic, assign) NSString       *cacheTencentOpenID;
//    /// 读取与写入qq access_token
//@property(nonatomic, assign) NSString       *cacheTencentAccessToken;
//    /// 读取与写入qq认证时间
//@property(nonatomic, assign) NSString       *cacheTencentExpiresIn;
//    /// 读取与写入用户设置的当前收货地址
//@property(nonatomic, assign) UserAddressEntity  *cacheUserAddrEntity;
//
//    /// 判断app是否发生crash
//@property(nonatomic, assign) BOOL           cacheIsAppHasCrash;
//    /// 判断app是否启动完成
//@property(nonatomic, assign) BOOL           cacheIsAppLoadOK;
//    /// 判断app是否在app启动过程发生crash
//@property(nonatomic, assign) BOOL           cacheIsAppCrashPreLoadOk;
//    /// 判断是否接受促销类通知
//@property(nonatomic, assign) BOOL           cacheIsCloseOfActivity;
//    /// 判断是否接受公告类通知
//@property(nonatomic, assign) BOOL           cacheIsCloseOfSystem;
//    /// 判断是否接受订单类通知
//@property(nonatomic, assign) BOOL           cacheIsCloseOfOrder;
//    /// 判断当前设备是否添加JPush Tag成功
//@property(nonatomic, assign) BOOL           cacheIsAddJPushTagSuccess;
//@property(nonatomic, assign) NSString       *cacheLocalCity;
//
//    /// 记录选择的性别
//@property(nonatomic, assign) NSInteger      cacheSelectedSex;
//    /// 记录选择的职位
//@property(nonatomic, assign) NSString       *cacheSelectedjobPositon;
//    /// 记录选择的收入
//@property(nonatomic, assign) NSString       *cacheSelectedincomeStage;
//    /// 记录选择的学历
//@property(nonatomic, assign) NSString       *cacheSelectedEducation;
//    /// 记录选择的工作时间
//@property(nonatomic, assign) NSString       *cacheSelectedjobAge;
//    /// 判断是否绑定了手机号
//@property(nonatomic, assign) BOOL           cacheIsBindMobile;
//    /// 判断是否绑定了QQ账号
//@property(nonatomic, assign) BOOL           cacheIsBindQQ;
//    /// 判断是否绑定了微信账号
//@property(nonatomic, assign) BOOL           cacheIsBindWeiXin;
//    /// 判断是否绑定了新浪账号
//@property(nonatomic, assign) BOOL           cacheIsBindSina;
//    /// 记录首签提示
//@property(nonatomic, assign) BOOL           cacheIsFirstCheckIn;
//    /// 记录闪屏次数
//@property(nonatomic, assign) int            cacheSplashScreenTimes;
    /// 记录微信的unionid
@property(nonatomic, assign) NSString       *cacheWXUnionID;
//    /// 记录当前的登录类型
//@property(nonatomic, assign) int            cacheCurrentLoginType;
//
//    /// 读取与写入当前登录过的用户的MineInfo接口返回信息
////@property(nonatomic, assign) UserMineInfoEntity     *cacheUserMineInfoEntity;
//    /// 是否在打开应用时自动定位
//@property(nonatomic, assign) BOOL           cacheIsAutoLocation;
//    /// 上回显示的升级等级
//@property(nonatomic, assign) int            cacheLastUpToLevel;
//    /// 记录当前用户的吃货力等级
//@property(nonatomic, assign) NSString       *cacheCurrentLevelName;
//    /// 记录当前app显示了的哪些界面的新手引导
//@property(nonatomic, assign) NSArray        *cacheShowedGuideVCArr;
//    /// 记录当前环境是测试or正式
//@property(nonatomic, assign) BOOL           cacheIsTestWebsite;
//    /// 用户登录用户的账户余额
//@property(nonatomic, assign) float          cacheUserBalance;
//    /// 用户登录用户的现金红包余额
//@property(nonatomic, assign) float          cacheUserRedPacket;

- (void)logout;

@end






