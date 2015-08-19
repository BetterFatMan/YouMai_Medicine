//
//  HomeCureItemCell.m
//  MedicineCure
//
//  Created by line0 on 15/8/1.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "HomeCureItemCell.h"

#import "CureItemEntity.h"

@interface HomeCureItemCell ()
{
    UIImageView *_image;
    UILabel     *_cureLable;
    UILabel     *_contentLable;
    UIButton    *_editBtn;
}

@end

@implementation HomeCureItemCell

+ (CGFloat)drawCellHeight
{
    return 60;
}

- (void)dealloc
{
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _image = [[UIImageView alloc] initWithFrame:CGRectMake(15, 7, 46, 46)];
        [self.contentView addSubview:_image];
        
        _cureLable = [[UILabel alloc] initWithFrame:CGRectMake(_image.right + 8, 8, kKeyWindow.width - _image.right - 75, 20)];
        _cureLable.textAlignment = NSTextAlignmentLeft;
        _cureLable.textColor = kLLBBlackColor;
        _cureLable.font      = gFontSystemSize(16);
        [self.contentView addSubview:_cureLable];
        
        _contentLable = [[UILabel alloc]initWithFrame:CGRectMake(_cureLable.left, _cureLable.bottom + 6, _cureLable.width, 22)];
        _contentLable.textAlignment = NSTextAlignmentLeft;
        _contentLable.textColor = kBBlackColor;
        _contentLable.font      = gFontSystemSize(20);
        [self.contentView addSubview:_contentLable];
        
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _editBtn.frame = CGRectMake((kKeyWindow.width - 56), 7, 45, 45);
        _editBtn.layer.borderColor = kLBBlackColor.CGColor;
        _editBtn.layer.borderWidth = 0.5;
        _editBtn.layer.cornerRadius = 22.5;
        _editBtn.clipsToBounds      = YES;
        [_editBtn setTitle:@"化疗\n结束" forState:UIControlStateNormal];
        [_editBtn setTitleColor:kLBBlackColor forState:UIControlStateNormal];
        _editBtn.titleLabel.font = gFontSystemSize(15);
        _editBtn.titleLabel.numberOfLines = 2;
        [self.contentView addSubview:_editBtn];
        
        _topLine = [[UIView alloc] initWithFrame:CGRectMake(1, 0, kKeyWindow.width - 2, 0.5)];
        _topLine.backgroundColor = kAppNormalBgColor;
        [self.contentView addSubview:_topLine];
        
        UIView *bbtomView = [[UIView alloc] initWithFrame:CGRectMake(20, 59.5, kKeyWindow.width - 21, 0.5)];
        bbtomView.backgroundColor = kAppNormalBgColor;
        [self.contentView addSubview:bbtomView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _image.image = UIImageByName(@"icon_main_chinese-meal");
    
    NSString *tem = @"出院后的注意事项";
    NSString *ttem = @" 出院后第一天";
    
    UIColor *tempColor = UICOLOR_RGB(arc4random()%255, arc4random()%255, arc4random()%255);
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:[tem stringByAppendingFormat:@"%@", ttem]];
    [attri addAttribute:NSForegroundColorAttributeName value:tempColor range:NSMakeRange(0, tem.length)];
    _cureLable.attributedText = attri;
    
    [_editBtn setTitleColor:tempColor forState:UIControlStateNormal];
    
    _editBtn.hidden = arc4random()%4 > 1 ? YES : NO;
    _contentLable.text = @"药用说明书";
    
    if (_entity) {
        
    }
}

- (void)prepareForReuse
{
    [super prepareForReuse];
}

@end



@interface HomeEditItemCell ()
{
    UILabel *_editLable;
}

@end

@implementation HomeEditItemCell

+ (CGFloat)drawCellHeight
{
    return 60;
}

- (void)dealloc
{
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, kKeyWindow.width - 10, 50)];
        bgView.backgroundColor = kPaysRedColor;
        [self.contentView addSubview:bgView];
        
        _editLable = [[UILabel alloc]initWithFrame:CGRectMake(85, 5, 200, 50)];
        _editLable.textAlignment = NSTextAlignmentLeft;
        _editLable.textColor = [UIColor whiteColor];
        _editLable.font      = gFontSystemSize(22);
        [self.contentView addSubview:_editLable];
        
        UIImageView *temp = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, kKeyWindow.width, 55)];
        [self.contentView addSubview:temp];
        temp.image = UIImageByName(@"home_tempbn");
        
        UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(1, 59.5, kKeyWindow.width - 2, 0.5)];
        bottom.backgroundColor = kAppNormalBgColor;
        [self.contentView addSubview:bottom];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    _editLable.text = @"添加一次放疗治疗";
}

- (void)prepareForReuse
{
    [super prepareForReuse];
}

@end


