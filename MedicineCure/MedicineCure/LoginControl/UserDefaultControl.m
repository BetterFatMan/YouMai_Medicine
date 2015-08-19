//
//  UserDefaultControl.m
//  Line0new
//
//  Created by trojan on 14-8-4.
//  Copyright (c) 2014年 com.line0. All rights reserved.
//

#import "UserDefaultControl.h"

@implementation UserDefaultControl
static UserDefaultControl *_instance = nil;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

//- (void)setCacheBanner:(NSArray *)cacheBanner
//{
//    if (!cacheBanner)
//    {
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cachedBanner"];
//    }
//    else
//    {
//        NSData *cacheBannerData = [NSKeyedArchiver archivedDataWithRootObject:cacheBanner];
//        if (cacheBannerData)
//        {
//            [[NSUserDefaults standardUserDefaults] setObject:cacheBannerData forKey:@"cachedBanner"];
//        }
//    }
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//- (NSArray *)cacheBanner
//{
//    NSData *cacheBannerData = [[NSUserDefaults standardUserDefaults] objectForKey:@"cachedBanner"];
//    if (cacheBannerData)
//    {
//        NSArray *bannerEntities = [NSKeyedUnarchiver unarchiveObjectWithData:cacheBannerData];
//        if (bannerEntities && [bannerEntities isKindOfClass:[NSArray class]])
//        {
//            return bannerEntities;
//        }
//    }
//    return nil;
//}
//
//
//- (void)setCacheLastImgCacheDate:(NSDate *)cacheLastImgCacheDate
//{
//    if (!cacheLastImgCacheDate)
//    {
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cacheLastImgCacheDate"];
//    }
//    else
//    {
//        NSData *cacheImgCacheDateData = [NSKeyedArchiver archivedDataWithRootObject:cacheLastImgCacheDate];
//        if (cacheImgCacheDateData)
//        {
//            [[NSUserDefaults standardUserDefaults] setObject:cacheImgCacheDateData forKey:@"cacheLastImgCacheDate"];
//        }
//    }
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//
//- (NSDate *)cacheLastImgCacheDate
//{
//    NSData *cacheImgCacheDateData = [[NSUserDefaults standardUserDefaults] objectForKey:@"cacheLastImgCacheDate"];
//    if (cacheImgCacheDateData)
//    {
//        NSDate *cacheImgCacheDate = [NSKeyedUnarchiver unarchiveObjectWithData:cacheImgCacheDateData];
//        if (cacheImgCacheDate && [cacheImgCacheDate isKindOfClass:[NSDate class]])
//        {
//            return cacheImgCacheDate;
//        }
//    }
//    return nil;
//}
//
//
//- (void)setCacheSupportCityArr:(NSArray *)cacheSupportCityArr
//{
//    if (!cacheSupportCityArr)
//    {
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cacheSupportCityArr"];
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cacheSupportCityArrTime"];
//    }
//    else
//    {
//        NSData *cacheData = [NSKeyedArchiver archivedDataWithRootObject:cacheSupportCityArr];
//        if (cacheData)
//        {
//            [[NSUserDefaults standardUserDefaults] setObject:cacheData forKey:@"cacheSupportCityArr"];
//            [[NSUserDefaults standardUserDefaults] setDouble:[[NSDate date] timeIntervalSince1970] forKey:@"cacheSupportCityArrTime"];
//        }
//    }
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//
//- (NSArray *)cacheSupportCityArr
//{
//    NSData *cacheData = [[NSUserDefaults standardUserDefaults] objectForKey:@"cacheSupportCityArr"];
//    if (cacheData)
//    {
//        NSArray *cacheCityArr = [NSKeyedUnarchiver unarchiveObjectWithData:cacheData];
//        if (cacheCityArr && [cacheCityArr isKindOfClass:[NSArray class]])
//        {
//            return cacheCityArr;
//        }
//    }
//    return [CityEntity defaultSupportCityArr];
//}

- (void)setCacheLoginedUserEntity:(UserEntity *)cacheLoginedUserEntity
{
    if (!cacheLoginedUserEntity)
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cacheLoginedUserEntity"];
    }
    else
    {
        NSData *cacheData = [NSKeyedArchiver archivedDataWithRootObject:cacheLoginedUserEntity];
        if (cacheData)
        {
            [[NSUserDefaults standardUserDefaults] setObject:cacheData forKey:@"cacheLoginedUserEntity"];
        }
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (UserEntity *)cacheLoginedUserEntity
{
    NSData *cacheData = [[NSUserDefaults standardUserDefaults] objectForKey:@"cacheLoginedUserEntity"];
    if (cacheData)
    {
        UserEntity *userEntity = [NSKeyedUnarchiver unarchiveObjectWithData:cacheData];
        if (userEntity && [userEntity isKindOfClass:[UserEntity class]])
        {
            return userEntity;
        }
    }
    return nil;
}

//
//- (void)setCacheUserCityEntity:(CityEntity *)cacheUserCityEntity
//{
//    if (!cacheUserCityEntity)
//    {
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cacheUserCityEntity"];
//    }
//    else
//    {
//        NSData *cacheData = [NSKeyedArchiver archivedDataWithRootObject:cacheUserCityEntity];
//        if (cacheData)
//        {
//            [[NSUserDefaults standardUserDefaults] setObject:cacheData forKey:@"cacheUserCityEntity"];
//        }
//    }
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//
//- (CityEntity *)cacheUserCityEntity
//{
//    NSData *cacheData = [[NSUserDefaults standardUserDefaults] objectForKey:@"cacheUserCityEntity"];
//    if (cacheData)
//    {
//        CityEntity *cityEntity = [NSKeyedUnarchiver unarchiveObjectWithData:cacheData];
//        if (cityEntity && [cityEntity isKindOfClass:[CityEntity class]])
//        {
//            return cityEntity;
//        }
//    }
//    return nil;
//}
//
//
//- (void)setCacheWXExpiresIn:(NSString *)cacheWXExpiresIn
//{
//    if (!cacheWXExpiresIn)
//    {
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cacheWXExpiresIn"];
//    }
//    else
//    {
//        [[NSUserDefaults standardUserDefaults] setObject:cacheWXExpiresIn forKey:@"cacheWXExpiresIn"];
//    }
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//
//- (NSString *)cacheWXExpiresIn
//{
//    return [[NSUserDefaults standardUserDefaults] objectForKey:@"cacheWXExpiresIn"];
//}
//
//- (void)setCacheWXAccessToken:(NSString *)cacheWXAccessToken
//{
//    if (!cacheWXAccessToken)
//    {
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cacheWXAccessToken"];
//    }
//    else
//    {
//        [[NSUserDefaults standardUserDefaults] setObject:cacheWXAccessToken forKey:@"cacheWXAccessToken"];
//    }
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//
//- (NSString *)cacheWXAccessToken
//{
//    return [[NSUserDefaults standardUserDefaults] objectForKey:@"cacheWXAccessToken"];
//}
//
//
//- (void)setCacheWXOpenID:(NSString *)cacheWXOpenID
//{
//    if (!cacheWXOpenID)
//    {
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cacheWXOpenID"];
//    }
//    else
//    {
//        [[NSUserDefaults standardUserDefaults] setObject:cacheWXOpenID forKey:@"cacheWXOpenID"];
//    }
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//
//- (NSString *)cacheWXOpenID
//{
//    return [[NSUserDefaults standardUserDefaults] objectForKey:@"cacheWXOpenID"];
//}
//
//- (void)setCacheSinaExpiresIn:(NSString *)cacheSinaExpiresIn
//{
//    if (!cacheSinaExpiresIn)
//    {
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cacheSinaExpiresIn"];
//    }
//    else
//    {
//        [[NSUserDefaults standardUserDefaults] setObject:cacheSinaExpiresIn forKey:@"cacheSinaExpiresIn"];
//    }
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//
//- (NSString *)cacheSinaExpiresIn
//{
//    return [[NSUserDefaults standardUserDefaults] objectForKey:@"cacheSinaExpiresIn"];
//}
//
//
//- (void)setCacheSinaUserID:(NSString *)cacheSinaUserID
//{
//    if (!cacheSinaUserID)
//    {
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cacheSinaUserID"];
//    }
//    else
//    {
//        [[NSUserDefaults standardUserDefaults] setObject:cacheSinaUserID forKey:@"cacheSinaUserID"];
//    }
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//
//- (NSString *)cacheSinaUserID
//{
//    return [[NSUserDefaults standardUserDefaults] objectForKey:@"cacheSinaUserID"];
//}
//
//
//- (void)setCacheSinaAccessToken:(NSString *)cacheSinaAccessToken
//{
//    if (!cacheSinaAccessToken)
//    {
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cacheSinaAccessToken"];
//    }
//    else
//    {
//        [[NSUserDefaults standardUserDefaults] setObject:cacheSinaAccessToken forKey:@"cacheSinaAccessToken"];
//    }
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//
//- (NSString *)cacheSinaAccessToken
//{
//    return [[NSUserDefaults standardUserDefaults] objectForKey:@"cacheSinaAccessToken"];
//}
//
//
//- (void)setCacheTencentOpenID:(NSString *)cacheTencentOpenID
//{
//    if (!cacheTencentOpenID)
//    {
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cacheTencentOpenID"];
//    }
//    else
//    {
//        [[NSUserDefaults standardUserDefaults] setObject:cacheTencentOpenID forKey:@"cacheTencentOpenID"];
//    }
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//
//- (NSString *)cacheTencentOpenID
//{
//    return [[NSUserDefaults standardUserDefaults] objectForKey:@"cacheTencentOpenID"];
//}
//
//
//- (void)setCacheTencentAccessToken:(NSString *)cacheTencentAccessToken
//{
//    if (!cacheTencentAccessToken)
//    {
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cacheTencentAccessToken"];
//    }
//    else
//    {
//        [[NSUserDefaults standardUserDefaults] setObject:cacheTencentAccessToken forKey:@"cacheTencentAccessToken"];
//    }
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//
//- (NSString *)cacheTencentAccessToken
//{
//    return [[NSUserDefaults standardUserDefaults] objectForKey:@"cacheTencentAccessToken"];
//}
//
//- (void)setCacheTencentExpiresIn:(NSString *)cacheTencentExpiresIn
//{
//    if (!cacheTencentExpiresIn)
//    {
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cacheTencentExpiresIn"];
//    }
//    else
//    {
//        [[NSUserDefaults standardUserDefaults] setObject:cacheTencentExpiresIn forKey:@"cacheTencentExpiresIn"];
//    }
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//
//- (NSString *)cacheTencentExpiresIn
//{
//    return [[NSUserDefaults standardUserDefaults] objectForKey:@"cacheTencentExpiresIn"];
//}
//
//- (void)setCacheUserAddrEntity:(UserAddressEntity *)entity
//{
//    if (!entity)
//    {
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cacheUserAddrEntity"];
//    }
//    else
//    {
//        NSData *cacheData = [NSKeyedArchiver archivedDataWithRootObject:entity];
//        if (cacheData)
//        {
//            [[NSUserDefaults standardUserDefaults] setObject:cacheData forKey:@"cacheUserAddrEntity"];
//        }
//    }
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//- (UserAddressEntity *)cacheUserAddrEntity
//{
//    NSData *cacheData = [[NSUserDefaults standardUserDefaults] objectForKey:@"cacheUserAddrEntity"];
//    if (cacheData)
//    {
//        UserAddressEntity *entiy = [NSKeyedUnarchiver unarchiveObjectWithData:cacheData];
//        if (entiy && [entiy isKindOfClass:[UserAddressEntity class]])
//        {
//            return entiy;
//        }
//    }
//    return nil;
//}
//
//- (BOOL)cacheIsAppHasCrash
//{
//    BOOL isAppHasCrash = [kUserDefaults boolForKey:kIsAppHasCrash];
//    return isAppHasCrash;
//}
//
//- (void)setCacheIsAppHasCrash:(BOOL)cacheIsAppHasCrash
//{
//    [kUserDefaults setBool:cacheIsAppHasCrash forKey:kIsAppHasCrash];
//    [kUserDefaults synchronize];
//}
//
//- (BOOL)cacheIsAppLoadOK
//{
//    BOOL isAppLoadOK = [kUserDefaults boolForKey:kIsAppLoadOK];
//    return isAppLoadOK;
//}
//
//- (void)setCacheIsAppLoadOK:(BOOL)cacheIsAppLoadOK
//{
//    [kUserDefaults setBool:cacheIsAppLoadOK forKey:kIsAppLoadOK];
//    [kUserDefaults synchronize];
//}
//
//-(BOOL)cacheIsAppCrashPreLoadOk
//{
//    BOOL isAppCrashPreLoadOk = [kUserDefaults boolForKey:kIsAppCrashPreLoadOk];
//    return isAppCrashPreLoadOk;
//}
//
//- (void)setCacheIsAppCrashPreLoadOk:(BOOL)cacheIsAppCrashPreLoadOk
//{
//    [kUserDefaults setBool:cacheIsAppCrashPreLoadOk forKey:kIsAppCrashPreLoadOk];
//    [kUserDefaults synchronize];
//}
//
//- (BOOL)cacheIsCloseOfActivity
//{
//    BOOL isCloseOfActivity = [kUserDefaults boolForKey:kIsCloseOfActivity];
//    return isCloseOfActivity;
//}
//
//- (void)setCacheIsCloseOfActivity:(BOOL)cacheIsCloseOfActivity
//{
//    [kUserDefaults setBool:cacheIsCloseOfActivity forKey:kIsCloseOfActivity];
//    [kUserDefaults synchronize];
//}
//
//- (BOOL)cacheIsCloseOfSystem
//{
//    BOOL isCloseOfSystem = [kUserDefaults boolForKey:kIsCloseOfSystem];
//    return isCloseOfSystem;
//}
//
//- (void)setCacheIsCloseOfSystem:(BOOL)cacheIsCloseOfSystem
//{
//    [kUserDefaults setBool:cacheIsCloseOfSystem forKey:kIsCloseOfSystem];
//    [kUserDefaults synchronize];
//}
//
//- (BOOL)cacheIsCloseOfOrder
//{
//    BOOL isCloseOfOrder = [kUserDefaults boolForKey:kIsCloseOfOrder];
//    return isCloseOfOrder;
//}
//
//- (void)setCacheIsCloseOfOrder:(BOOL)cacheIsCloseOfOrder
//{
//    [kUserDefaults setBool:cacheIsCloseOfOrder forKey:kIsCloseOfOrder];
//    [kUserDefaults synchronize];
//}
//
//- (BOOL)cacheIsAddJPushTagSuccess
//{
//    return [kUserDefaults boolForKey:kIsAddJPushTagSuccess];
//}
//
//- (void)setCacheIsAddJPushTagSuccess:(BOOL)cacheIsFirstLaunch
//{
//    [kUserDefaults setBool:cacheIsFirstLaunch forKey:kIsAddJPushTagSuccess];
//    [kUserDefaults synchronize];
//}
//
//- (NSString *)cacheLocalCity
//{
//    NSString *localCity = [kUserDefaults stringForKey:@"cacheLocalCity"];
//    return localCity;
//}
//
//- (void)setCacheLocalCity:(NSString *)cacheLocalCity
//{
//    [kUserDefaults setObject:cacheLocalCity forKey:@"cacheLocalCity"];
//    [kUserDefaults synchronize];
//}
//
//- (NSInteger)cacheSelectedSex
//{
//    NSInteger  sex = [[kUserDefaults stringForKey:kUserSex]integerValue];
//    return sex;
//}
//
//- (void)setCacheSelectedSex:(NSInteger)cacheSelectedSex
//{
//    [kUserDefaults setObject:[NSString stringWithFormat:@"%ld",(long)cacheSelectedSex] forKey:kUserSex];
//    [kUserDefaults synchronize];
//}
//
//- (NSString *)cacheSelectedjobPositon
//{
//    NSString *jobPositon = [kUserDefaults stringForKey:kUserjobPositon];
//    return jobPositon;
//}
//
//- (void)setCacheSelectedjobPositon:(NSString *)cacheSelectedjobPositon
//{
//    [kUserDefaults setObject:cacheSelectedjobPositon forKey:kUserjobPositon];
//    [kUserDefaults synchronize];
//}
//
//- (NSString *)cacheSelectedincomeStage
//{
//    NSString *incomeStage = [kUserDefaults stringForKey:kUserincomeStage];
//    return incomeStage;
//}
//
//- (void)setCacheSelectedincomeStage:(NSString *)cacheSelectedincomeStage
//{
//    [kUserDefaults setObject:cacheSelectedincomeStage forKey:kUserincomeStage];
//    [kUserDefaults synchronize];
//}
//
//- (NSString *)cacheSelectedEducation
//{
//    NSString *education = [kUserDefaults stringForKey:kUsereducation];
//    return education;
//}
//
//- (void)setCacheSelectedEducation:(NSString *)cacheSelectedEducation
//{
//    [kUserDefaults setObject:cacheSelectedEducation forKey:kUsereducation];
//    [kUserDefaults synchronize];
//}
//
//- (NSString *)cacheSelectedjobAge
//{
//    NSString *jobAge = [kUserDefaults stringForKey:kUserjobAge];
//    return jobAge;
//}
//
//- (void)setCacheSelectedjobAge:(NSString *)cacheSelectedjobAge
//{
//    [kUserDefaults setObject:cacheSelectedjobAge forKey:kUserjobAge];
//    [kUserDefaults synchronize];
//}
//
//
//- (UserMineInfoEntity *)cacheUserMineInfoEntity
//{
//    NSData *cacheData = [kUserDefaults objectForKey:@"cacheUserMineInfoEntity"];
//    if (cacheData)
//    {
//        UserMineInfoEntity *entity = [NSKeyedUnarchiver unarchiveObjectWithData:cacheData];
//        if ([entity isKindOfClass:[UserMineInfoEntity class]])
//        {
//            return entity;
//        }
//    }
//    return nil;
//}
//
//- (void)setCacheUserMineInfoEntity:(UserMineInfoEntity *)entity
//{
//    if (entity)
//    {
//        NSData *cacheData = [NSKeyedArchiver archivedDataWithRootObject:entity];
//        if (cacheData)
//        {
//            [kUserDefaults setObject:cacheData forKey:@"cacheUserMineInfoEntity"];
//            [kUserDefaults synchronize];
//        }
//    }
//    else
//    {
//        [kUserDefaults removeObjectForKey:@"cacheUserMineInfoEntity"];
//        [kUserDefaults synchronize];
//    }
//}
//
//
//- (BOOL)cacheIsFirstCheckIn
//{
//    BOOL isFirstCheckIn = [kUserDefaults boolForKey:kFirstCheckIn];
//    return isFirstCheckIn;
//}
//
//- (void)setCacheIsFirstCheckIn:(BOOL)cacheIsFirstCheckIn
//{
//    [kUserDefaults setBool:cacheIsFirstCheckIn forKey:kFirstCheckIn];
//    [kUserDefaults synchronize];
//}
//
//- (int)cacheSplashScreenTimes
//{
//    int splashScreenTimes = (int)[kUserDefaults integerForKey:kSplashScreenTimes];
//    return splashScreenTimes;
//}
//
//- (void)setCacheSplashScreenTimes:(int)cacheSplashScreenTimes
//{
//    [kUserDefaults setInteger:cacheSplashScreenTimes forKey:kSplashScreenTimes];
//    [kUserDefaults synchronize];
//}

- (NSString *)cacheWXUnionID
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"cacheWXUnionID"];
}

- (void)setCacheWXUnionID:(NSString *)cacheWXUnionID
{
    if (!cacheWXUnionID)
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cacheWXUnionID"];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setObject:cacheWXUnionID forKey:@"cacheWXUnionID"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//- (int)cacheCurrentLoginType
//{
//    return (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"cacheCurrentLoginType"];
//}
//
//- (void)setCacheCurrentLoginType:(int)cacheCurrentLoginType
//{
//    if (!cacheCurrentLoginType)
//    {
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cacheCurrentLoginType"];
//    }
//    else
//    {
//        [[NSUserDefaults standardUserDefaults] setInteger:cacheCurrentLoginType forKey:@"cacheCurrentLoginType"];
//    }
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//
//- (void)setCacheIsAutoLocation:(BOOL)cacheIsAutoLocation
//{
//    [[NSUserDefaults standardUserDefaults] setBool:cacheIsAutoLocation forKey:@"cacheIsAutoLocation"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//- (BOOL)cacheIsAutoLocation
//{
//        /// 设定默认值是yes
//    NSObject *obj = [[NSUserDefaults standardUserDefaults] objectForKey:@"cacheIsAutoLocation"];
//    if (!obj)
//    {
//        self.cacheIsAutoLocation = YES;
//    }
//    return [[NSUserDefaults standardUserDefaults] boolForKey:@"cacheIsAutoLocation"];
//}
//
//- (int)cacheLastUpToLevel
//{
//    NSObject *obj = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastUpToLevel"];
//    if (obj)
//    {
//        return (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"lastUpToLevel"];
//    }
//    return -1;
//}
//
//- (void)setCacheLastUpToLevel:(int)lastUpToLevel
//{
//    [[NSUserDefaults standardUserDefaults] setInteger:lastUpToLevel forKey:@"lastUpToLevel"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//- (NSString *)cacheCurrentLevelName
//{
//    NSRange range = [[GlobalControl shareInstance].loginUser.userToken rangeOfString:@"@"];
//    NSString *uid = [[GlobalControl shareInstance].loginUser.userToken substringToIndex:range.location];
//    return [[NSUserDefaults standardUserDefaults] objectForKey:uid];
//}
//
//- (void)setCacheCurrentLevelName:(NSString *)cacheCurrentLevelName
//{
//    NSRange range = [[GlobalControl shareInstance].loginUser.userToken rangeOfString:@"@"];
//    NSString *uid = [[GlobalControl shareInstance].loginUser.userToken substringToIndex:range.location];
//    if (!cacheCurrentLevelName)
//    {
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:uid];
//    }
//    else
//    {
//        [[NSUserDefaults standardUserDefaults] setObject:cacheCurrentLevelName forKey:uid];
//    }
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//- (NSArray *)cacheShowedGuideVCArr
//{
//    return [[NSUserDefaults standardUserDefaults] objectForKey:@"cacheShowedGuideVCArr"];
//}
//
//- (void)setCacheShowedGuideVCArr:(NSArray *)cacheShowedGuideVCArr
//{
//    [[NSUserDefaults standardUserDefaults] setObject:cacheShowedGuideVCArr forKey:@"cacheShowedGuideVCArr"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//- (BOOL)cacheIsTestWebsite
//{
//    BOOL isTestWebsite = [kUserDefaults boolForKey:kIsTestWebsite];
//    return isTestWebsite;
//}
//
//- (void)setCacheIsTestWebsite:(BOOL)cacheIsTestWebsite
//{
//    [kUserDefaults setBool:cacheIsTestWebsite forKey:kIsTestWebsite];
//    [kUserDefaults synchronize];
//}
//
//- (float)cacheUserBalance
//{
//    return [kUserDefaults floatForKey:kAccountBalance];
//}
//
//- (void)setCacheUserBalance:(float)userBalance
//{
//    [kUserDefaults setFloat:userBalance forKey:kAccountBalance];
//        /// 小于0时清空
//    if (userBalance < 0.00001)
//    {
//        [kUserDefaults removeObjectForKey:kAccountBalance];
//    }
//    [kUserDefaults synchronize];
//}
//
//- (float)cacheUserRedPacket
//{
//    return [kUserDefaults floatForKey:kUserRedPacket];
//}
//
//- (void)setCacheUserRedPacket:(float)redPacket
//{
//    [kUserDefaults setFloat:redPacket forKey:kUserRedPacket];
//        /// 小于0时清空
//    if (redPacket < 0.00001)
//    {
//        [kUserDefaults removeObjectForKey:kUserRedPacket];
//    }
//    [kUserDefaults synchronize];
//}

- (void)logout
{
    self.cacheLoginedUserEntity = nil;
    self.cacheWXUnionID         = nil;
    
    [kNotificationCenter postNotificationName:kShowUserLoginView object:nil];
}

@end




















