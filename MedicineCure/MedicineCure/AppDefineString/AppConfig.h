


/*----------------------------------社区帐号------------------------------------*/

    /// 友盟帐号
#define kUmengKey                   @"55a86c6467e58ea96a005d15"

    /// 微信帐号ID
#define kWXAppID                    @"wx47554ea695f606df"
#define kWXAppSecret                @"de9ac82d89011138668fd4fd802af65f"

    /// 新浪微博
#define kSinaWeiboAppKey            @"3622719705"
    /// 企业包时用到的新浪微博key
#define kSinaWeiboAppKeyEnterprise  @"416885450"
    //#define kSinaWeiboAppSecret         @"750b8b81b9b32ae49e964531e275c963"
#define kSinaWeiboRedicrctURI       @"http://www.line0.com"

    /// QQ
#define kTencentAppID               @"1101335184"
#define kTencentAppKey              @"1V0uUfpVvgK1lcvEg"

    ///JPush
#define kRegistrationID             @"registrationID"

    /// QQ支付所需要的一些配置值
    /// 财付通分配的 10 位商户号
#define kQQPayBargainorId           (@"1238326601")
    /// 如果我们没专门分配 APPID 给商户的对应 APP,那请使用 appname 这个参数,appname 就是 Bundle Identifier.
#define kQQPayAppName               (@"com.line0.Line0")
    /// 财付通分配的应用 appid
#define kQQPayAppId                 (@"")
    /// 签名,签名方法:将以上参数按照字段名升序排序后,按照 url 格式组串,在串最后加上 appid 对应的密钥 注:app 密钥是在申请 appid 的时候一起分配得到
#define kQQPaySign                  (@"93c1d68239443ecb5d7a6ee237130958")

    /// QQ支付成功
#define kQQPaySucceed               (@"kQQPaySucceed")
    /// QQ支付失败
#define kQQPayFailed                (@"kQQPayFailed")

    /// 翼支付scheme
#define kBestPayCallbackScheme      (@"line0bestpay")
    /// 翼支付成功
#define kBestPaySucceed             (@"kBestPaySucceed")
    /// 翼支付失败
#define kBestPayFailed              (@"kBestPayFailed")



    /// app企业包版本号(仅当发布企业包时才用到)
#define kAppVersonCodeEnterprise    ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])
#define kAppBuddelId                ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])
    /// app自定义版本号
#define kAppVersonCode              @"60"

/*---------------------------------用户相关信息-------------------------------------*/


/*---------------------------------程序相关常数-------------------------------------*/
//App Id、下载地址、评价地址
#define kAppId                      @"593499239"
#define kAppUrl                     [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/ling-hao-xian/id%@?mt=8",kAppId]
#define kRateUrl                    [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",kAppId]
    /// 订单来源：1网站，2客服，3手机IOS, 4手机Andriod
#define kSource                     (3)

#define kLine0DbVersionCode         @"Line0DbVersionCode"


/*---------------------------------程序全局通知-------------------------------------*/
#define kShowUserLoginView          (@"UserShowLoginView")

#define kRefreashHomeInit           (@"RefreashHomeInit")

/*---------------------------------程序界面配置信息-------------------------------------*/

    //更新用户信息通知


//设计app默认字体和颜色
#define kTitleFont                  [UIFont boldSystemFontOfSize:20]
#define kTitleWhiteColor            UICOLOR_RGB(0xff,0xff,0xff)

#define UICOLOR_RGB(R,G,B)          ([UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:1])
#define UICOLOR_RGBA(R,G,B,A)       ([UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)])
#define UICOLOR_RGBDigital(RGB)     ([UIColor colorWithRed:((float)((RGB & 0xFF0000) >> 16))/255.0 green:((float)((RGB & 0xFF00) >> 8))/255.0 blue:((float)(RGB & 0xFF))/255.0 alpha:1.0])

    /// 全局线框颜色
#define kLineGrayColor          (UICOLOR_RGB(199, 199, 204))
#define kLineLightGrayColor     (UICOLOR_RGB(0xee, 0xee, 0xee))

#define kButtonTitleColor       UICOLOR_RGB(57, 32, 0)
#define kContentHighlightColor  UICOLOR_RGB(255, 96, 0)
#define kMainColor              UICOLOR_RGB(64, 168, 174)
#define kGrayColor              UICOLOR_RGB(192, 192, 192)
#define kBlackColor             UICOLOR_RGB(50, 50, 50)
#define kRedColor               UICOLOR_RGB(255, 110, 107)

#define kAppNormalBgColor       UICOLOR_RGB(195, 20, 120)

#define kRedBtnColor            UICOLOR_RGB(254, 76, 90)
#define kGreenBtnColor          UICOLOR_RGB(33, 210, 92)
#define kLightRedBtnColor       UICOLOR_RGB(253, 148, 145)
#define kLightGreenBtnColor     UICOLOR_RGB(90, 231, 166)
#define kIconsYellowColor       UICOLOR_RGB(255, 200, 0)
#define kPaysRedColor           UICOLOR_RGB(255, 80, 0)
#define kBlueColor              UICOLOR_RGB(0, 181, 255)
#define kLightBlueColor         UICOLOR_RGB(35, 202, 245)
#define kAlertBlueColor         UICOLOR_RGB(67, 173, 255)

#define kBBlackColor            UICOLOR_RGB(56, 58, 62)
#define kLBBlackColor           UICOLOR_RGB(95, 100, 110)
#define kLLBBlackColor          UICOLOR_RGB(151, 154, 160)

    /// 应用的UIView背景色
#define kAppBgColor             UICOLOR_RGB(235, 235, 235)

#define kBuyingPayRed           UICOLOR_RGB(253, 71, 1)
#define kBuyingNumRed           UICOLOR_RGB(254, 76, 90)

    ////-----------------------------------------

#define kYMGreenColor           UICOLOR_RGB(0x71, 0xca, 0xc4)
#define kYMLightRedColor        UICOLOR_RGB(0xf5, 0x87, 0x94)
#define kYMLoginRedColor        UICOLOR_RGB(0xef, 0x4b, 0x54)
#define kYMNaviTitleColor       UICOLOR_RGB(0xf1, 0x51, 0x5b)

    ////-----------------------------------------


#define kIsIphone5              (((int)[UIScreen mainScreen].bounds.size.height % 568) == 0)

    //判断iphone6
#define kIsIPhone6              ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

    //判断iphone6+
#define kIsIPhone6Plus          ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)


#define dispatch_main_sync_safe(block)\
    if ([NSThread isMainThread]) {\
        block();\
    } else {\
        dispatch_sync(dispatch_get_main_queue(), block);\
    }

#define dispatch_main_async_safe(block)\
    if ([NSThread isMainThread]) {\
        block();\
    } else {\
        dispatch_async(dispatch_get_main_queue(), block);\
    }

#define dispatch_async_background(block)    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)





/*------------定义的全局变量－－－－－－－－－－－*/
typedef enum
{
    PayMethodType_None = -1,
        /// 用户余额
    PayMethodType_Account = 0,
        /// 货到付款
    PayMethodType_DaoFu = 2,
        /// 微信支付
    PayMethodType_WeiXin = 4,
        /// 支付宝钱包
    PayMethodType_AlixPay = 5,
        /// 银联支付
    PayMethodType_UPPay=24,
        /// QQ支付
    PayMethodType_QQPay=26,
        /// 电信天翼翼支付
    PayMethodType_BestPay=29
} PayMethodType;

typedef enum
{
    EnumDeliveryTypeLine0 = 1,
    EnumDeliveryTypeShop = 2,
    EnumDeliveryTypeDaDa = 3
}EnumDeliveryType;


    //调试模式下输入NSLog，发布后不再输入。
#ifndef __OPTIMIZE__
    #define NSLog(...) NSLog(__VA_ARGS__)
#else
    #define NSLog(...) {}
#endif


