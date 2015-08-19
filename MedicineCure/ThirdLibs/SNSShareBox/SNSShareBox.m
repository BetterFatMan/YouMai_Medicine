//
//  SNSShareBox.m
//  loginAndshare
//
//  Created by user on 14-8-14.
//  Copyright (c) 2014年 user. All rights reserved.
//

#import "SNSShareBox.h"
#import "GTMBase64.h"

@implementation ShareEntity

- (id)initWithDict:(NSDictionary *)dict
{
    if (!dict)
    {
        return nil;
    }
    
    self = [super initWithDict:dict];
    if (self)
    {
        self.shareUrl       = [dict safeBindStringValue:@"shareUrl"];
        self.shareTitle     = [dict safeBindStringValue:@"title"];
        self.shareContent   = [dict safeBindStringValue:@"content"];
        self.shareImg       = nil;
        self.shareType      = [[dict safeBindStringValue:@"shareType"]intValue];
        self.shareImgUrl    = [dict safeBindStringValue:@"shareImage"];
        
        if (self.shareUrl && !([self.shareUrl hasPrefix:@"http://"] || [self.shareUrl hasPrefix:@"https://"]))
        {
            self.shareUrl = [NSString stringWithFormat:@"http://%@", self.shareUrl];
        }
        
        self.shareUrl       = self.shareUrl?:@"";
        self.shareContent   = self.shareContent?:@"";
        self.shareTitle     = self.shareTitle?:@"";
        self.shareImgUrl    = self.shareImgUrl?:@"";
        
        if (self.shareImgUrl.length)
        {
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.shareImgUrl]];
            
            __weak typeof(self) _wself = self;
            NSOperationQueue *queue = [NSOperationQueue currentQueue];
            [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                if (data)
                {
                    _wself.shareImg = [UIImage imageWithData:data];
                    if (data.length > 60*1024)
                    {
                        UIGraphicsBeginImageContext(CGSizeMake(300, 300));
                        [_wself.shareImg drawInRect:CGRectMake(0, 0, 300, 300)];
                        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
                        UIGraphicsEndImageContext();
                        NSData *adata = UIImageJPEGRepresentation(img, 0.5);
                        if (adata.length > 28 * 1024)
                        {
                            adata = UIImageJPEGRepresentation(img, 0.3);
                        }
                        
                        if (!adata)
                        {
                            adata = UIImagePNGRepresentation(_wself.shareImg);
                        }
                        
                        _wself.shareImg = [UIImage imageWithData:adata];
                    }
                }
            }];
        }
    }
    return self;
}

- (NSArray *)serializeProperties
{
    return @[@"shareUrl",@"shareTitle", @"shareContent", @"shareImg", @"shareType", @"shareImgUrl"];
}

@end




@interface SNSShareBox()
@property(nonatomic, strong)TencentOAuth      *tencentOAuth;
@end

@implementation SNSShareBox
{
    NSArray                         *_permissions;
        /// 存放登录后的用户的OpenID、Token以及过期时间
    NSString                        *_accessToken;
        /// 请求参数
    NSDictionary                    *_params;
        /// 新浪微博认证时间
    long long int                   _sinaExpiresIn;
        ///新浪微博userID
    NSString                        *_sinaUserID;
        ///新浪微博access_token
    NSString                        *_sinaAccessToken;
        /// 微信认证时间
    long long int                   _wxExpiresIn;
        /// 微信openid
    NSString                        *_wxOpenID;
        ///微信access_token
    NSString                        *_wxAccessToken;
        ///第三方用户信息
    NSMutableArray                  *_userInfoArr;
}


-(id)init
{
    self = [super init];
    if (nil != self)
    {
        _permissions = [NSArray arrayWithObjects:
                        kOPEN_PERMISSION_GET_USER_INFO,
                        kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                        kOPEN_PERMISSION_ADD_ALBUM,
                        kOPEN_PERMISSION_ADD_IDOL,
                        kOPEN_PERMISSION_ADD_ONE_BLOG,
                        kOPEN_PERMISSION_ADD_PIC_T,
                        kOPEN_PERMISSION_ADD_SHARE,
                        kOPEN_PERMISSION_ADD_TOPIC,
                        kOPEN_PERMISSION_CHECK_PAGE_FANS,
                        kOPEN_PERMISSION_DEL_IDOL,
                        kOPEN_PERMISSION_DEL_T,
                        kOPEN_PERMISSION_GET_FANSLIST,
                        kOPEN_PERMISSION_GET_IDOLLIST,
                        kOPEN_PERMISSION_GET_INFO,
                        kOPEN_PERMISSION_GET_OTHER_INFO,
                        kOPEN_PERMISSION_GET_REPOST_LIST,
                        kOPEN_PERMISSION_LIST_ALBUM,
                        kOPEN_PERMISSION_UPLOAD_PIC,
                        kOPEN_PERMISSION_GET_VIP_INFO,
                        kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                        kOPEN_PERMISSION_GET_INTIMATE_FRIENDS_WEIBO,
                        kOPEN_PERMISSION_MATCH_NICK_TIPS_WEIBO,
                        nil];
        
        self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:kTencentAppID andDelegate:self];
        [WeiboSDK enableDebugMode:YES];
        [WeiboSDK registerApp:kSinaWeiboAppKey];
        [WXApi registerApp:kWXAppID];
        _userInfoArr = [NSMutableArray array];
    }
    return self;
}

- (BOOL)handleOpenURL:(NSURL *)url
{
    BOOL weiboRet = NO;
    if ([url.absoluteString hasPrefix:@"wb"])
    {
        weiboRet = [WeiboSDK handleOpenURL:url delegate:self];
    }
    else if([url.absoluteString hasPrefix:@"tencent"])
    {
        weiboRet = [TencentOAuth HandleOpenURL:url];
    }
    else if ([url.absoluteString hasPrefix:@"wx"])
    {
        weiboRet = [WXApi handleOpenURL:url delegate:self];
    }
        /// 响应手Q支付回送的支付结果消息
    else if([url.absoluteString hasPrefix:kQQPayAppName])
    {
        NSMutableDictionary *queryDict = [[NSMutableDictionary alloc] initWithCapacity:10];
        NSArray *queryArray = [[url query] componentsSeparatedByString:@"&" ];
        for( NSString *paramItem in queryArray)
        {
            NSArray *pairArray = [paramItem componentsSeparatedByString:@"=" ];
            if( [pairArray count] == 2 )
            {
                [queryDict setObject:pairArray[1] forKey:pairArray[0]];
            }
        }
        
        if([[url host] isEqualToString:@"response_from_qq"] &&
           [[queryDict safeBindStringValue:@"version"] isEqualToString:@"1"] &&
           [[queryDict safeBindStringValue:@"source"] isEqualToString:@"qq"] &&
           [[queryDict safeBindStringValue:@"source_scheme"] isEqualToString:@"mqqapi"]
           )
        {
            NSString *errorNo = [queryDict safeBindStringValue:@"error"];
            if([errorNo isEqualToString:@"0"] )
            {
                NSLog(@"支付成功");
                [kNotificationCenter postNotificationName:kQQPaySucceed object:nil];
            }
            else
            {
                    /// 支付出错处理 具体内容需要base64解码
                NSString *errMsg = [[NSString alloc] initWithData:[GTMBase64 decodeString:[queryDict safeBindStringValue:@"error_description"]] encoding:NSUTF8StringEncoding];
                NSLog(@"支付出错:%@", errMsg);
                [kNotificationCenter postNotificationName:kQQPayFailed object:nil];
            }
        }
        else
        {
                //返回的基本参数不匹配，这种有可能是版本不匹配或冒充的QQ,建议记录下来或者提示用户反馈处理
            NSLog(@"错误格式的手机QQ支付通知返回");
            [kNotificationCenter postNotificationName:kQQPayFailed object:nil];
        }
        return YES;
    }
    return weiboRet;
}


- (void)loginWithType:(SNSSharePlatformType)OtherLoginType
{
    if (SNSSharePlatformTypeQQ == OtherLoginType)
    {
            //判断用户是否安装QQ客户端以及客户端是否支持sso登录
        [self.tencentOAuth authorize:_permissions inSafari:NO];        
    }
    else if (SNSSharePlatformTypeSina == OtherLoginType)
    {
            ///微博登录
        WBAuthorizeRequest *request = [WBAuthorizeRequest request];
        request.redirectURI = kSinaWeiboRedicrctURI;
        request.scope = @"all";
        request.userInfo = nil;
        [WeiboSDK sendRequest:request];
    }
    else if (SNSSharePlatformTypeWeiXin == OtherLoginType)
    {
            ///微信登录
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        req.state = @"123";
        [WXApi sendReq:req];
    }
}

#pragma mark TencentSessionDelegate
- (void)tencentDidLogin
{
        // 登录成功
    if (self.tencentOAuth.accessToken
        && 0 != [self.tencentOAuth.accessToken length])
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(LoginSuccess:andOpenid:userInfo:)])
        {
//            [UserDefaultControl shareInstance].cacheTencentOpenID = [NSString stringWithFormat:@"%@",self.tencentOAuth.openId];
//            [UserDefaultControl shareInstance].cacheTencentAccessToken = [NSString stringWithFormat:@"%@",self.tencentOAuth.accessToken];
            
            __weak typeof(self) _wself = self;
            [self userInfo:SNSSharePlatformTypeQQ completeBlock:^(NSMutableArray *userInfoArr) {
                
//                [_wself.delegate LoginSuccess:SNSSharePlatformTypeQQ andOpenid:[UserDefaultControl shareInstance].cacheTencentOpenID userInfo:userInfoArr];
            }];
        }
    }
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    if (nil != self.delegate && [self.delegate respondsToSelector:@selector(LoginFail:)])
    {
        [self.delegate LoginFail:@"用户取消"];
    }
}

-(void)tencentDidNotNetWork
{
    if (nil != self.delegate && [self.delegate respondsToSelector:@selector(LoginFail:)])
    {
        [self.delegate LoginFail:@"网络连接失败"];
    }
}


#pragma mark WeiboSDKDelegate

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
            ///判断用户是否分享成功
        if ((int)response.statusCode == WeiboSDKResponseStatusCodeSuccess)
        {
            [self SendSuccess:0];
        }
        else
        {
            [self SendFail:0];
        }
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
            ///判断用户是否登录成功
        if ((int)response.statusCode == WeiboSDKResponseStatusCodeSuccess)
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(LoginSuccess:andOpenid:userInfo:)])
            {
                _sinaUserID = [(WBAuthorizeResponse *)response userID];
//                [UserDefaultControl shareInstance].cacheSinaUserID = [NSString stringWithFormat:@"%@",_sinaUserID];
                _sinaAccessToken = [(WBAuthorizeResponse *)response accessToken];
//                [UserDefaultControl shareInstance].cacheSinaAccessToken = [NSString stringWithFormat:@"%@",_sinaAccessToken];
                
                __weak typeof(self) _wself = self;
                [self userInfo:SNSSharePlatformTypeSina completeBlock:^(NSMutableArray *userInfoArr) {
                    
//                    [_wself.delegate LoginSuccess:SNSSharePlatformTypeSina andOpenid:[UserDefaultControl shareInstance].cacheSinaUserID userInfo:userInfoArr];
                }];
            }
        }
        else
        {
            if (nil != self.delegate && [self.delegate respondsToSelector:@selector(LoginFail:)])
            {
                [self.delegate LoginFail:@"授权失败"];
            }
        }
    }
}


#pragma mark WXApiDelegate
- (void)onResp:(BaseResp*)resp
{
    if ([resp isKindOfClass:[SendAuthResp class]])
    {
        if (resp.errCode == 0)
        {
            SendAuthResp *aresp = (SendAuthResp *)resp;
            [self getAccessTokenWithCode:aresp.code];
        }
        else if (resp.errCode == -4 && nil != self.delegate && [self.delegate respondsToSelector:@selector(LoginFail:)])
        {
            [self.delegate LoginFail:@"用户拒绝"];
        }
        else if (resp.errCode == -2 && nil != self.delegate && [self.delegate respondsToSelector:@selector(LoginFail:)])
        {
            [self.delegate LoginFail:@"用户取消"];
        }
    }
    else if ([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        if (0 == resp.errCode)
        {
            [self SendSuccess:1];
        }
        else
        {
            [self SendFail:1];
        }
    }
    else if ([resp isKindOfClass:[PayResp class]])
    {
        PayResp *response = (PayResp *)resp;
        if (response.errCode == WXSuccess)
        {
            [kNotificationCenter postNotificationName:kWeixinPaySuccessNotification object:resp];
            mAlertView(@"微信提示", @"支付成功");
        }
        else if (response.errCode == WXErrCodeCommon)
        {
            NSLog(@"errCode:%d",response.errCode);
            [kNotificationCenter postNotificationName:kWeixinPayFailedNotification object:resp];
            mAlertView(@"微信提示", @"签名错误，支付失败");
        }
        else if (response.errCode == WXErrCodeUserCancel)
        {
                ///取消操作
            [kNotificationCenter postNotificationName:kWeixinPayFailedNotification object:resp];
        }
        else
        {
            NSLog(@"errCode:%d",response.errCode);
            [kNotificationCenter postNotificationName:kWeixinPayFailedNotification object:resp];
            mAlertView(@"微信提示", response.errStr);
        }
    }
}

- (void)getAccessTokenWithCode:(NSString *)code
{
        ///使用code获取access token
    NSString *urlString = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",kWXAppID,kWXAppSecret,code];
    
    __weak typeof(self) _wself = self;
    [GetUserInfo sendRequest:[NSURL URLWithString:urlString] completeBlock:^(NSDictionary *resultDict)
     {
         if (resultDict)
         {
             if (self.delegate && [self.delegate respondsToSelector:@selector(LoginSuccess:andOpenid:userInfo:)])
             {
                 _wxAccessToken = [resultDict safeBindValue:@"access_token"];
//                 [UserDefaultControl shareInstance].cacheWXAccessToken = _wxAccessToken;
                 _wxOpenID = [resultDict safeBindValue:@"openid"];
//                 [UserDefaultControl shareInstance].cacheWXOpenID = _wxOpenID;
                 
                 [self userInfo:SNSSharePlatformTypeWeiXin completeBlock:^(NSMutableArray *userInfoArr) {
                     
//                     [_wself.delegate LoginSuccess:SNSSharePlatformTypeWeiXin andOpenid:[UserDefaultControl shareInstance].cacheWXOpenID userInfo:userInfoArr];
                 }];
             }
         }
     }];
    
}


- (void)userInfo:(SNSSharePlatformType)otherType completeBlock:(void (^)(NSMutableArray *userInfoArr))completeBlock
{
        ///获取第三方的用户信息
    NSString *urlString = nil;
    switch (otherType)
    {
        case SNSSharePlatformTypeQQ:
        {
//            urlString = [NSString stringWithFormat:@"https://graph.qq.com/user/get_simple_userinfo?access_token=%@&oauth_consumer_key=%@&openid=%@",[UserDefaultControl shareInstance].cacheTencentAccessToken,kTencentAppID,[UserDefaultControl shareInstance].cacheTencentOpenID];
            [GetUserInfo userInfo:urlString andType:@"qq" completeBlock:^(NSMutableArray *arr) {
                
                if (completeBlock)
                {
                    completeBlock(arr);
                }
            }];
        }
            break;
        case SNSSharePlatformTypeSina:
        {
//            urlString = [NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?access_token=%@&uid=%@",[UserDefaultControl shareInstance].cacheSinaAccessToken,[UserDefaultControl shareInstance].cacheSinaUserID];
            
            [GetUserInfo userInfo:urlString andType:@"weibo" completeBlock:^(NSMutableArray *arr) {
                
                if (completeBlock)
                {
                    completeBlock(arr);
                }
            }];
        }
            break;
        case SNSSharePlatformTypeWeiXin:
        {
//            urlString = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",[UserDefaultControl shareInstance].cacheWXAccessToken,[UserDefaultControl shareInstance].cacheWXOpenID];
            
            [GetUserInfo userInfo:urlString andType:@"weixin" completeBlock:^(NSMutableArray *arr) {
                
                if (completeBlock)
                {
                    completeBlock(arr);
                }
            }];
        }
            break;
    }
}


- (void)logOutWithType
{
    [self.tencentOAuth logout:self];
    [WeiboSDK logOutWithToken:_sinaAccessToken delegate:self withTag:nil];
    _wxAccessToken = nil;
}

#pragma mark tencentLoginOutDelegate
- (void)tencentDidLogout
{
    self.tencentOAuth.accessToken = @"";
}


    ///微信分享
- (void)sendAppContentWithMessage:(NSDictionary *)params WithScene:(int)scene
{
    NSString *shareMessage = [params objectForKey:@"shareMessage"];
    NSString *shareURL     = [params objectForKey:@"shareURL"];
    UIImage  *shareImage   = [params objectForKey:@"shareImage"];
    NSString *shareTitle   = [params objectForKey:@"shareTitle"];
        // 发送内容给微信
    BOOL isWXAppInstall = [WXApi isWXAppInstalled];
    if (isWXAppInstall)
    {
        WXMediaMessage *message = [WXMediaMessage message];
        if (WXSceneTimeline == scene)
        {
            message.title = shareMessage;
        }
        else
        {
            message.title = shareTitle;
        }
        message.description = shareMessage;
        [message setThumbImage:shareImage];
        
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = shareURL;
        
        message.mediaObject = ext;
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = scene;
        
        [WXApi sendReq:req];
    }
    else
    {
        mAlertView(@"微信提示",@"您还没有安装微信，请先安装。");
    }
}

    ///微博分享
- (void)weiboShare:(NSDictionary *)params
{
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare:params]];
    [WeiboSDK sendRequest:request];
}

- (WBMessageObject *)messageToShare:(NSDictionary *)params
{
    NSString *shareMessage = [params objectForKey:@"shareMessage"];
    NSString *shareURL     = [params objectForKey:@"shareURL"];
    UIImage  *shareImage   = [params objectForKey:@"shareImage"];
    NSString *shareTitle   = [params objectForKey:@"shareTitle"];
    WBMessageObject *message = [WBMessageObject message];
    WBWebpageObject *webpage = [WBWebpageObject object];
    webpage.objectID = @"identifier1";
    webpage.title = shareTitle;
    webpage.description = shareMessage;
    webpage.thumbnailData = UIImagePNGRepresentation(shareImage);
    webpage.webpageUrl = shareURL;
    message.mediaObject = webpage;
    return message;
}

    ///分享成功
- (void)SendSuccess:(int)shareType
{
    if (nil != self.delegate && [self.delegate respondsToSelector:@selector(shareEngineSendSuccess:)])
    {
        [self.delegate shareEngineSendSuccess:shareType];
    }
}

    ///分享失败
- (void)SendFail:(int)shareType
{
    if (nil != self.delegate && [self.delegate respondsToSelector:@selector(shareEngineSendFail:)])
    {
        [self.delegate shareEngineSendFail:shareType];
    }
}

@end
