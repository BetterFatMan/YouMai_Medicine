//
//  HomeSearchCell.m
//  MedicineCure
//
//  Created by line0 on 15/8/17.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "HomeSearchCell.h"

@implementation HomeSearchCell

+ (CGFloat)drawCellHeight
{
    return 50;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _cellImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 40, 40)];
        [self.contentView addSubview:_cellImage];
        
        _searchLable = [[UILabel alloc] initWithFrame:CGRectMake(_cellImage.right + 10, 10, 250, 30)];
        _searchLable.backgroundColor = [UIColor clearColor];
        _searchLable.font = gFontSystemSize(15);
        _searchLable.textColor = kBBlackColor;
        _searchLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_searchLable];
        
        UIView *bbtomView = [[UIView alloc] initWithFrame:CGRectMake(8, 49.5, kKeyWindow.width - 9, 0.5)];
        bbtomView.backgroundColor = kLineGrayColor;
        [self.contentView addSubview:bbtomView];
    }
    return self;
}

@end
