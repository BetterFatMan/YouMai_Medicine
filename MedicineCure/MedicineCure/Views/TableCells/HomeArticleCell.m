//
//  HomeArticleCell.m
//  MedicineCure
//
//  Created by line0 on 15/8/1.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "HomeArticleCell.h"

#import "ArticleEntity.h"

@interface HomeArticleCell ()
{
    UIImageView *_image;
    UILabel     *_cureLable;
    UILabel     *_contentLable;
    UILabel     *_detailLable;
}
@end

@implementation HomeArticleCell

+ (CGFloat)drawCellHeight
{
    return 100;
}

- (void)dealloc
{
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _image = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 80, 80)];
        _image.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_image];
        
        _cureLable = [[UILabel alloc] initWithFrame:CGRectMake(_image.right + 8, 13, kKeyWindow.width - _image.right - 25, 15)];
        _cureLable.textAlignment = NSTextAlignmentLeft;
        _cureLable.textColor = kLLBBlackColor;
        _cureLable.font      = gFontSystemSize(13);
        [self.contentView addSubview:_cureLable];
        
        _contentLable = [[UILabel alloc]initWithFrame:CGRectMake(_cureLable.left, _cureLable.bottom + 8, _cureLable.width, 22)];
        _contentLable.textAlignment = NSTextAlignmentLeft;
        _contentLable.textColor = kBBlackColor;
        _contentLable.font      = gFontSystemSize(16);
        [self.contentView addSubview:_contentLable];
        
        _detailLable = [[UILabel alloc]initWithFrame:CGRectMake(_cureLable.left, _contentLable.bottom + 8, _cureLable.width, 20)];
        _detailLable.textAlignment = NSTextAlignmentLeft;
        _detailLable.textColor = kLLBBlackColor;
        _detailLable.font      = gFontSystemSize(15);
        [self.contentView addSubview:_detailLable];
        
        UIView *bbtomView = [[UIView alloc] initWithFrame:CGRectMake(20, 99.5, kKeyWindow.width - 21, 0.5)];
        bbtomView.backgroundColor = kLineGrayColor;
        [self.contentView addSubview:bbtomView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    UIColor *tempColor = UICOLOR_RGB(arc4random()%255, arc4random()%255, arc4random()%255);
    
    _cureLable.textColor = tempColor;
    _cureLable.text = @"每日食谱";
    
    _contentLable.text = @"最强水果在这里！";
    _detailLable.text  = @"每天每夜夏天夏天你太疯狂疯狂咖啡开始师大世界经济的等待";
    
    if (_entity) {
        [_image sd_setImageWithURL:[NSURL URLWithString:_entity.imageUrl] placeholderImage:nil];
        
        _cureLable.text = _entity.title;
    }
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    _entity = nil;
}

@end
