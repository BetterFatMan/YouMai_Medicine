//
//  BaseEntity.m
//  Line0new
//
//  Created by line0_dev on 14-7-29.
//  Copyright (c) 2014年 trojan. All rights reserved.
//

#import "BaseEntity.h"

@implementation NSObject (entity)

- (id)safeBindValue:(NSString *)key
{
    NSLog(@"错误对象调用 safeBindValue 调用路径 %@", [NSThread callStackSymbols]);
    return nil;
}

- (NSString *)safeBindStringValue:(NSString *)key
{
    NSLog(@"错误对象调用 safeBindStringValue 调用路径 %@", [NSThread callStackSymbols]);
    return nil;
}


@end


@implementation NSDictionary (entity)

- (id)safeBindValue:(NSString *)key
{
    id result = nil;
    if ([self.allKeys containsObject:key])
    {
        result = [self objectForKey:key];
        result = [result isKindOfClass:[NSNull class]] ? nil : result;
    }
    return result;
}

- (NSString *)safeBindStringValue:(NSString *)key
{
    id result = [self safeBindValue:key];
    if (result)
    {
        return [NSString stringWithFormat:@"%@", result];
    }
    return nil;
}


@end


@implementation NSArray(entity)

- (id)objectAtIndexSafe:(NSUInteger)index
{
    if ([self count] > index)
    {
        return [self objectAtIndex:index];
    }
    return nil;
}

@end



@implementation BaseEntity

+ (NSArray *)makeEntitiesByDictArr:(NSArray *)arr
{
    if (arr && [arr isKindOfClass:[NSArray class]] && [arr count])
    {
        NSMutableArray *entityArr = [NSMutableArray array];
        for (int i = 0; i < [arr count]; i++)
        {
            id entity = [[self alloc] initWithDict:[arr objectAtIndex:i]];
            if (entity)
            {
                [entityArr addObject:entity];
            }
        }
        return entityArr;
    }
    return nil;
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if ([dict isKindOfClass:[NSNull class]] || ![dict isKindOfClass:[NSDictionary class]] || ![dict count])
    {
        return nil;
    }
    
    self = [super init];
    if (self)
    {
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    NSArray *properties = [self serializeProperties];
    for (NSString *propertyName in properties)
    {
        if ([self respondsToSelector:NSSelectorFromString(propertyName)])
        {
            id value = [self valueForKey:propertyName];
            if (value)
            {
                    //兼容short, ushort, char, uchar, int, uint, long, ulong, long long, unsinged long long, enum, NSInteger, Class
                    //float, double 等基础类型属性
                [aCoder encodeObject:value forKey:propertyName];
            }
        }
        else
        {
            NSLog(@"encodeWithCoder error %@", propertyName);
        }
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder;
{
    self = [super init];
    if (self)
    {
        if (aDecoder)
        {
            NSArray *properties = [self serializeProperties];
            for (NSString *propertyName in properties)
            {
                if ([self respondsToSelector:NSSelectorFromString(propertyName)])
                {
                        //兼容short, ushort, char, uchar, int, uint, long, ulong, long long, unsinged long long, enum, NSInteger, Class
                        //float, double 等基础类型属性
                    id value = [aDecoder decodeObjectForKey:propertyName];
                    if (value)
                    {
                        [self setValue:value forKey:propertyName];
                    }
                }
                else
                {
                    NSLog(@"initWithCoder error %@", propertyName);
                }
            }
        }
    }
    return self;
}

- (NSArray *)serializeProperties
{
    return nil;
}

@end
