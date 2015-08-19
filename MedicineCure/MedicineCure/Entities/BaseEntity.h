//
//  BaseEntity.h
//  Line0new
//
//  Created by line0_dev on 14-7-29.
//  Copyright (c) 2014年 trojan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kNilWhenNSNull(obj)          ((obj) == [NSNull null] ? nil : (obj))

    /// 之所以在NSObject中添加safeBindValue方法是为了在使用时错误的对象实例调用该方法引起crash
@interface NSObject (entity)

- (id)safeBindValue:(NSString *)key;
- (NSString *)safeBindStringValue:(NSString *)key;

@end


@interface NSDictionary (entity)

- (id)safeBindValue:(NSString *)key;
- (NSString *)safeBindStringValue:(NSString *)key;

@end

@interface NSArray (entity)

- (id)objectAtIndexSafe:(NSUInteger)index;

@end


@interface BaseEntity : NSObject<NSCoding>

+ (NSArray *)makeEntitiesByDictArr:(NSArray *)arr;

- (instancetype)initWithDict:(NSDictionary *)dict;

    //返回需要序列化与反序列化的当前对象的属性列表
- (NSArray *)serializeProperties;


@end


