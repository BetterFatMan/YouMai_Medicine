//
//  SNSShareBox.h
//  loginAndshare
//
//  Created by user on 14-8-14.
//  Copyright (c) 2014年 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WeiboSDK.h"
#import "WXApi.h"
#import "UserDefaultControl.h"
#import "WXPayEntryActivity.h"
#import "GetUserInfo.h"
#import "BlockAlertView.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import "BaseEntity.h"

@interface ShareEntity : BaseEntity

@property(nonatomic, strong) NSString *shareUrl;
@property(nonatomic, strong) NSString *shareTitle;
@property(nonatomic, strong) NSString *shareContent;
@property(nonatomic, strong) UIImage  *shareImg;
@property(nonatomic, assign) int       shareType;
@property(nonatomic, strong) NSString *shareImgUrl;

@end




typedef enum
{
    SNSSharePlatformTypeSina,
    SNSSharePlatformTypeQQ,
    SNSSharePlatformTypeWeiXin
}SNSSharePlatformType;


@protocol SNSShareBoxDelegate;
@interface SNSShareBox : NSObject<TencentSessionDelegate,WeiboSDKDelegate,WXApiDelegate,WBHttpRequestDelegate,UIAlertViewDelegate>

@property (nonatomic, weak) id<SNSShareBoxDelegate> delegate;


- (BOOL)handleOpenURL:(NSURL *)url;

    ///**
    // *@description 第三方登录
    // *@param weibotype:第三方登录类型
    // */
- (void)loginWithType:(SNSSharePlatformType)OtherLoginType;

/**
 *@description 退出登录
 *@param weibotype:第三方登录类型
 */- (void)logOutWithType;




/**
 微信分享
 */
- (void)sendAppContentWithMessage:(NSDictionary *)params WithScene:(int)scene;

/**
 微博分享
 */
- (void)weiboShare:(NSDictionary *)params;
@end




@protocol SNSShareBoxDelegate <NSObject>
@optional
- (void)LoginSuccess:(SNSSharePlatformType) otherLoginType andOpenid:(NSString *) openId userInfo:(NSMutableArray *)userInfoArr;

- (void)LoginFail:(NSString *)errStr;

- (void)shareEngineSendSuccess:(int)shareType;

- (void)shareEngineSendFail:(int)shareType;
@end

