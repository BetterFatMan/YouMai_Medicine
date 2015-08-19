//
//  NSString+HW.m
//  StringDemo
//
//  Created by 何 振东 on 12-10-11.
//  Copyright (c) 2012年 wsk. All rights reserved.
//

#import "NSString+Addition.h"
#import "RegularExpression.h"

@implementation NSString (Addition)

- (long)wordsCount
{
    long i,n = [self length], l = 0, a = 0, b = 0;
    unichar c;
    for(i = 0;i < n; i++)
    {
        c = [self characterAtIndex:i];
        if(isblank(c))
        {
            b++;
        }else if(isascii(c))
        {
            a++;
        }else{
            l++;
        }
    }
    if(a == 0 && l == 0) return 0;
    return l + (int)ceilf((float)(a + b) / 2.0);
}


    //一般用于 每行最多显示x个汉字（2x个英文），超过的用…显示
- (long)unicodeCharLength
{
    NSInteger nicknameLength = 0;
    for (int i = 0; i < self.length; i++)
    {
        unichar c = [self characterAtIndex:i];
        if (c < 19968 + 20902 && c > 19968)
        {
            nicknameLength += 2;
        }
        else
        {
            nicknameLength ++;
        }
    }
    
    return nicknameLength;
}


- (NSString *)URLEncodedString
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (CFStringRef)self,
                                                                           NULL,
                                                                           CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                           kCFStringEncodingUTF8));
    return result;
}

- (NSString *)URLDecodedString
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                           (CFStringRef)self,
                                                                                           CFSTR(""),
                                                                                           kCFStringEncodingUTF8));
    return result;
}

- (NSString *)encodeStringWithUTF8
{
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin1);
//    const char *c =  [self cStringUsingEncoding:encoding];
    NSString *str = [[NSString alloc] initWithCString:[self cStringUsingEncoding:encoding] encoding:NSUTF8StringEncoding];
//    NSString *str = [NSString stringWithCString:[self cStringUsingEncoding:encoding] encoding:NSUTF8StringEncoding];

    return str;
}

- (NSUInteger)byteLengthWithEncoding:(NSStringEncoding)encoding
{
    if (!self)
    {
        return 0;
    }
    
    const char *byte = [self cStringUsingEncoding:encoding];
    return strlen(byte);
}

-(BOOL)containsEmoji
{
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop)
    {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff)
         {
             if (substring.length > 1)
             {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f)
                 {
                     returnValue = YES;
                 }
             }
         }
         else if (substring.length > 1)
         {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3)
             {
                 returnValue = YES;
             }
             
         }
         else
         {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff)
             {
                 returnValue = YES;
             }
             else if (0x2B05 <= hs && hs <= 0x2b07)
             {
                 returnValue = YES;
             }
             else if (0x2934 <= hs && hs <= 0x2935)
             {
                 returnValue = YES;
             }
             else if (0x3297 <= hs && hs <= 0x3299)
             {
                 returnValue = YES;
             }
             else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50)
             {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}

- (NSString *)trim
{
    NSString *temp = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return temp;
}

- (BOOL)isMobilePhoneNum
{
    return [RegularExpression isMobileNumber:self];
}


- (BOOL)isChinese:(unichar)c
{
    if (c < 19968 + 20902 && c > 19968)
    {
        return YES;
    }
    return NO;
}
- (BOOL)isOnlyContainCH_EN_ASCII
{
    unichar dig0 = '0', dig9 = '9', chra = 'a', chrz = 'z', chrA = 'A', chrZ = 'Z', chO1 = '-', chO2 = '+';
    for (int i = 0; i < self.length; i++)
    {
        unichar c = [self characterAtIndex:i];
        if (!((c < 19968 + 20902 && c > 19968) ||
              (c  <= 0x9FFF &&  c >= 0x4E00) ||
              (dig0<=c && dig9 >=c) ||
              (chra<=c && chrz >=c) ||
              (chrA<=c && chrZ >=c) ||
              (chO1 == c || c == chO2)
             )
            )
        {
            return NO;
        }
    }
    return YES;
}



@end
