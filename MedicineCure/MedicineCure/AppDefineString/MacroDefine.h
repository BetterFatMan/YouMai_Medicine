

/*--------------------------------开发中常用到的宏定义--------------------------------------*/

#define gFontNumberHelvetica(X)             [UIFont fontWithName:@"Helvetica" size:(X)]
#define gFontSystemSize(X)                  [UIFont systemFontOfSize:(X)]
#define gBoldFontSysSize(X)                 [UIFont boldSystemFontOfSize:(X)]

#define gFontNumberSize(X)                  [UIFont fontWithName:@"Helvetica" size:(X)]
#define g_Font_Number_style_1               (gFontNumberSize(27))
#define g_Font_Number_style_2               (gFontNumberSize(24))
#define g_Font_Number_style_3               (gFontNumberSize(17))
#define gFontNumberLightSize(X)             [UIFont fontWithName:@"Helvetica-Light" size:(X)]
#define g_Font_Number_style_4               (gFontNumberLightSize(14))
#define g_Font_Number_style_5               (gFontNumberLightSize(13))

#define g_Color_loading                     [UIColor colorWithRed:199/255.0 green:199/255.0 blue:204.0/255.0 alpha:1.0]
#define g_Color_bg                          [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0]
#define g_Color_line                        [UIColor colorWithRed:199/255.0 green:199/255.0 blue:204.0/255.0 alpha:1.0]
#define g_Color_placeholder                 [UIColor colorWithRed:151/255.0 green:154/255.0 blue:160/255.0 alpha:1.0]
#define g_Color_tips                        [UIColor colorWithRed:90/255.0 green:100/255.0 blue:110/255.0 alpha:1.0]
#define g_Color_important                   [UIColor colorWithRed:56/255.0 green:58/255.0 blue:62/255.0 alpha:1.0]

#define g_Color_price                       [UIColor colorWithRed:255/255.0 green:80/255.0 blue:0/255.0 alpha:1]
/**    end added    **/


//----------方法简写-------
#define kAppDelegate                        (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define kKeyWindow                          [[UIApplication sharedApplication] keyWindow]
#define kUserDefaults                       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter                 [NSNotificationCenter defaultCenter]

    /// 读取本地图片文件包含图片的获取方式(不采用 imageName:xxx方式, 这种方式会一直驻留内存无法及时释放) (PS: 不支付Images.xcassets中的图片)
#define UIImageByPath(name, ext)            [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:ext]]
    /// 读取本地图片文件包含图片的获取方式(不采用 imageName:xxx方式, 这种方式会一直驻留内存无法及时释放) (PS: 不支付Images.xcassets中的图片)
#define LoadLocalImgByName(X)               ([UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[(X) stringByDeletingPathExtension] ofType:[(X) pathExtension]]])
    /// 加载图片
#define UIImageByName(name)                 [UIImage imageNamed:name]

//以tag读取View
#define UIViewByTag(parentView, tag, Class) (Class *)[parentView viewWithTag:tag]
//读取Xib文件的类
#define UIViewByNib(Class, owner)           [[[NSBundle mainBundle] loadNibNamed:Class owner:owner options:nil] lastObject]

//id对象与NSData之间转换
#define NSArchiverObjectToData(object)      [NSKeyedArchiver archivedDataWithRootObject:object]
#define NSUnarchiverDataToObject(data)      [NSKeyedUnarchiver unarchiveObjectWithData:data]

//度弧度转换
#define mDegreesToRadian(x)                 (M_PI * (x) / 180.0)
#define mRadianToDegrees(radian)            (radian*180.0) / (M_PI)

    //简单的以AlertView显示提示信息
#define mAlertView(title, msg) \
    if((msg).length)\
    {\
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:(title) message:(msg) delegate:nil \
        cancelButtonTitle:@"确定" otherButtonTitles:nil]; \
        [alert show];\
    }

    //简单的以AlertView显示提示信息
#define mAlertViewWithBtn(title, msg, btn) \
    if((msg).length)\
    {\
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:(title) message:(msg) delegate:nil \
        cancelButtonTitle:(btn) otherButtonTitles:nil]; \
        [alert show];\
    }



//----------页面设计相关-------

#define kNavBarHeight           44
#define kTabBarHeight           49
#define kScreenWidth            ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight           ([UIScreen mainScreen].bounds.size.height)


//----------设备系统相关---------
//#define kIsPad                  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//#define kIsiPhone               (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define kSystemVersion          ([[UIDevice currentDevice] systemVersion])
#define kCurrentLanguage        ([[NSLocale preferredLanguages] objectAtIndexSafe:0])
#define kAPPVersion             [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]



