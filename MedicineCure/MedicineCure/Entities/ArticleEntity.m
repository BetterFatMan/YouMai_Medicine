//
//  ArticleEntity.m
//  MedicineCure
//
//  Created by line0 on 15/8/4.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "ArticleEntity.h"

@implementation ArticleEntity

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super initWithDict:dict];
    if (self)
    {
        self.articleId   = [[dict safeBindStringValue:@"articleId"] integerValue];
        self.status      = [[dict safeBindStringValue:@"status"] integerValue];
        self.articleUrl  = [dict safeBindStringValue:@"articleUrl"];
        self.imageUrl    = [dict safeBindStringValue:@"imageTitle"];
        self.title       = [dict safeBindStringValue:@"title"];
        
    }
    return self;
}

@end

/*"status": 1,
 
 "articleId": 1,
 
 "articleUrl": "www.baidu.com",//文章详情页
 
 "imageTitle":      "http:\/\/img7.line0.com\/static\/guanjiashop\/image\/logo\/1433828032267.jpeg",//文章图片
 
 "title": "乳腺癌预防"//title*/