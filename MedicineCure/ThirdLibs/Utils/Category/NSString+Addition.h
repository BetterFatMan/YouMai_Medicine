//
//  NSString+HW.h
//  StringDemo
//
//  Created by 何 振东 on 12-10-11.
//  Copyright (c) 2012年 wsk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Addition)

/**
 *  计算字符串的字数。
 *  @param  string:输入字符串。
 *  return  返回输入字符串的字数。
 */
- (long)wordsCount;
- (long)unicodeCharLength;

- (NSString *)URLDecodedString;
- (NSString *)URLEncodedString;
- (NSString *)encodeStringWithUTF8;
- (NSUInteger)byteLengthWithEncoding:(NSStringEncoding)encoding;

- (BOOL)containsEmoji;

- (NSString *)trim;
    /// 是否是合法的手机号
- (BOOL)isMobilePhoneNum;

- (BOOL)isChinese:(unichar)c;
    /// 是否仅包含中文, 英文, ASCII码
- (BOOL)isOnlyContainCH_EN_ASCII;

@end
