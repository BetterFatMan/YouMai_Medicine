//
//  ArticleEntity.h
//  MedicineCure
//
//  Created by line0 on 15/8/4.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "BaseEntity.h"

@interface ArticleEntity : BaseEntity

@property(nonatomic, assign) NSInteger  articleId;

@property(nonatomic, assign) NSInteger  status;

@property(nonatomic, strong) NSString  *articleUrl;

@property(nonatomic, strong) NSString  *imageUrl;

@property(nonatomic, strong) NSString  *title;

@end
/*"status": 1,
 
 "articleId": 1,
 
 "articleUrl": "www.baidu.com",//文章详情页
 
 "imageTitle":      "http:\/\/img7.line0.com\/static\/guanjiashop\/image\/logo\/1433828032267.jpeg",//文章图片
 
 "title": "乳腺癌预防"//title*/