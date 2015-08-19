//
//  HomeArticleCell.h
//  MedicineCure
//
//  Created by line0 on 15/8/1.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ArticleEntity;
@interface HomeArticleCell : UITableViewCell

+ (CGFloat)drawCellHeight;

@property(nonatomic, strong) ArticleEntity *entity;

@end
