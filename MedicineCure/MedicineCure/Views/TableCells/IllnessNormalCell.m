//
//  IllnessNormalCell.m
//  MedicineCure
//
//  Created by line0 on 15/7/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "IllnessNormalCell.h"

@implementation IllnessNormalCell
{
    UIImageView *_image;
    UILabel     *_timeLable;
    UILabel     *_contentLable;
}

+ (CGFloat)drawCellHeight
{
    return 100;
}

- (void)dealloc
{
    _tapImageBlock = nil;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle  = UITableViewCellSelectionStyleNone;
        
        CGFloat tempLeft = kKeyWindow.width/3.0;
        CGFloat height   = [IllnessNormalCell drawCellHeight];
        
        _image = [[UIImageView alloc] initWithFrame:CGRectMake(tempLeft - 25, (height - 50)/2, 50, 50)];
        [self.contentView addSubview:_image];
        
        _timeLable = [UILabel new];
        _timeLable.frame = CGRectMake(_image.left - 90, _image.top + 15, 82, 20);
        _timeLable.textAlignment = NSTextAlignmentRight;
        _timeLable.textColor = kBBlackColor;
        _timeLable.font      = gFontSystemSize(14);
        [self.contentView  addSubview:_timeLable];
        
        _contentLable = [UILabel new];
        _contentLable.frame = CGRectMake(_image.right + 25, _image.top + 15, kKeyWindow.width - (_image.right + 35), 20);
        _contentLable.textAlignment = NSTextAlignmentLeft;
        _contentLable.textColor = kLBBlackColor;
        _contentLable.font      = gFontSystemSize(16);
        [self.contentView  addSubview:_contentLable];
        
        [_image addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapIllnessImage:)]];
        _image.userInteractionEnabled = YES;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _image.image = UIImageByName(_illEntity.imageUrl);
    _timeLable.text = _illEntity.dayTime;
    _contentLable.text = _illEntity.content;
    
    _contentLable.textColor = [self setContentColor:_illEntity.imageType];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    _illEntity = nil;
//    _tapImageBlock = nil;
}

- (void)tapIllnessImage:(UITapGestureRecognizer *)gesture
{
    if (_tapImageBlock) {
        _tapImageBlock(_illEntity);
    }
}

- (UIColor *)setContentColor:(NSInteger)type
{
    switch (type) {
        case 0:
            return kLightBlueColor;
            break;
        case 1:
            return kLightGreenBtnColor;
            break;
        case 2:
            return kLightRedBtnColor;
            break;
        case 3:
            return kIconsYellowColor;
            break;
        case 4:
            return kAlertBlueColor;
            break;
            
        default:
            break;
    }
    return kLBBlackColor;
}

@end


@interface IllnessTodayCell ()
{
    UIImageView *_image;
    UILabel     *_timeLable;
    UILabel     *_contentLable;
    UILabel     *_detailContentLable;
}

@end

@implementation IllnessTodayCell

+ (CGFloat)drawCellHeight
{
    return 180;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = UICOLOR_RGB(255, 900, 10);
        self.selectionStyle  = UITableViewCellSelectionStyleNone;
        
        CGFloat tempLeft = kKeyWindow.width/3.0;
        CGFloat height   = [IllnessTodayCell drawCellHeight];
        
        _image = [[UIImageView alloc] initWithFrame:CGRectMake(tempLeft - 85, (height - 80)/2, 80, 80)];
        [self.contentView addSubview:_image];
        
        _timeLable = [UILabel new];
        _timeLable.frame = CGRectMake(tempLeft + 45, _image.top - 5, 200, 20);
        _timeLable.textAlignment = NSTextAlignmentLeft;
        _timeLable.textColor = kBBlackColor;
        _timeLable.font      = gFontSystemSize(16);
        [self.contentView  addSubview:_timeLable];
        
        _contentLable = [UILabel new];
        _contentLable.frame = CGRectMake(_timeLable.left, _timeLable.bottom + 15, _timeLable.width, 20);
        _contentLable.textAlignment = NSTextAlignmentLeft;
        _contentLable.textColor = kBBlackColor;
        _contentLable.font      = gFontSystemSize(14);
        [self.contentView  addSubview:_contentLable];
        
        _detailContentLable = [UILabel new];
        _detailContentLable.frame = CGRectMake(_timeLable.left, _contentLable.bottom + 15, _timeLable.width, 20);
        _detailContentLable.textAlignment = NSTextAlignmentLeft;
        _detailContentLable.textColor = kBBlackColor;
        _detailContentLable.font      = gFontSystemSize(14);
        [self.contentView  addSubview:_detailContentLable];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _image.image = UIImageByName(_illEntity.imageUrl);
    _timeLable.text = [_illEntity.dayTime stringByAppendingFormat:@"  %@", _illEntity.content];
    _contentLable.text = _illEntity.detailContent;
    _detailContentLable.text = _illEntity.doneThins;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    _illEntity = nil;
}

@end
