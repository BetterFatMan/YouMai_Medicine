
#import "AppDelegate.h"
#import <UIKit/UIKit.h>

/*－－－－－－－－－－－－－－－－－－－－－－－－常用内联函数定义－－－－－－－－－－－－－－－－－－*/


//获取appDelegate实例。
UIKIT_STATIC_INLINE AppDelegate *appDelegate()
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

UIKIT_STATIC_INLINE CGSize getStringSize(NSString *str, UIFont *font, CGSize containSize)
{
    if (!str || !font || ![str isKindOfClass:[NSString class]])
    {
        return CGSizeMake(0, 0);
    }
    
    NSDictionary *attribute = @{NSFontAttributeName: font};
    NSStringDrawingOptions option = (NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading);
    CGSize size = [str boundingRectWithSize:containSize options:option attributes:attribute context:nil].size;
    return size;
}


UIKIT_STATIC_INLINE CGSize getStringSizeByBreakMode(NSString *str, UIFont *font, CGSize containSize, NSLineBreakMode lineBreakMode)
{
    if (!str || !font || ![str isKindOfClass:[NSString class]])
    {
        return CGSizeMake(0, 0);
    }
        //设置段落模式
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = lineBreakMode;

    NSDictionary *attribute = @{NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraph};
    NSStringDrawingOptions option = (NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading);
    CGSize size = [str boundingRectWithSize:containSize options:option attributes:attribute context:nil].size;
    
    return size;
}

    /// 加载网路图片，通过服务器裁剪图片尺寸
UIKIT_STATIC_INLINE NSString *trimImageSize(NSString *imageUrl)
{
    if (![imageUrl isKindOfClass:[NSString class]])
    {
        imageUrl = [NSString stringWithFormat:@"%@",imageUrl];
    }
    return [NSString stringWithFormat:@"%@_300x.jpg",imageUrl];
}

UIKIT_STATIC_INLINE NSDictionary *caculateHourMinSecStr(double timedate)
{
    NSString *secStr,*minStr,*hourStr;
    
    long hour = timedate/3600;
    long min  = timedate/60 - hour*60;
    long sec  = timedate - min*60 - hour*3600;
    
    if (sec < 10)
    {
        secStr = [NSString stringWithFormat:@"0%ld",sec];
    }
    else
    {
        secStr = [NSString stringWithFormat:@"%ld",sec];
    }
    if (min < 10)
    {
        minStr = [NSString stringWithFormat:@"0%ld",min];
    }
    else
    {
        minStr = [NSString stringWithFormat:@"%ld",min];
    }
    if (hour < 10)
    {
        hourStr = [NSString stringWithFormat:@"0%ld",hour];
    }
    else
    {
        hourStr = [NSString stringWithFormat:@"%ld", (hour > 23 ? 23 : hour)];
    }
    return @{@"hour" : hourStr, @"min" : minStr, @"sec" : secStr};
}


UIKIT_STATIC_INLINE NSDateFormatter *timeFormatter_HH()
{
    static NSDateFormatter *timeFormatter = nil;
    timeFormatter = timeFormatter ? : [NSDateFormatter new];
    timeFormatter.dateFormat       = @"HH";
    return timeFormatter;
}

UIKIT_STATIC_INLINE NSDateFormatter *timeFormatter_HHmm()
{
    static NSDateFormatter *timeFormatter = nil;
    timeFormatter = timeFormatter ? : [NSDateFormatter new];
    timeFormatter.dateFormat       = @"HH:mm";
    return timeFormatter;
}

UIKIT_STATIC_INLINE NSDateFormatter *dateFormatter_yyyyMMdd()
{
    static NSDateFormatter *dataFormatter = nil;
    dataFormatter = dataFormatter ? : [NSDateFormatter new];
    dataFormatter.dateFormat       = @"yyyy-MM-dd";
    return dataFormatter;
}

UIKIT_STATIC_INLINE NSDateFormatter *dateFormatter_MMdd()
{
    static NSDateFormatter *dataFormatter = nil;
    dataFormatter = dataFormatter ? : [NSDateFormatter new];
    dataFormatter.dateFormat       = @"MM-dd";
    return dataFormatter;
}

UIKIT_STATIC_INLINE NSDateFormatter *dateFormatter_MMddHHmm()
{
    static NSDateFormatter *dataFormatter = nil;
    dataFormatter = dataFormatter ? : [NSDateFormatter new];
    dataFormatter.dateFormat       = @"MM-dd HH:mm";
    return dataFormatter;
}

UIKIT_STATIC_INLINE NSDateFormatter *dateFormatter_yyyyMMddHHmm()
{
    static NSDateFormatter *dataFormatter = nil;
    dataFormatter = dataFormatter ? : [NSDateFormatter new];
    dataFormatter.dateFormat       = @"yyyy-MM-dd HH:mm";
    return dataFormatter;
}