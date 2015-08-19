//
//  HomeCureItemCell.h
//  MedicineCure
//
//  Created by line0 on 15/8/1.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CureItemEntity;
@interface HomeCureItemCell : UITableViewCell

@property(nonatomic, strong) CureItemEntity *entity;
@property(nonatomic, strong) UIView *topLine;

+ (CGFloat)drawCellHeight;

@end


@interface HomeEditItemCell : UITableViewCell

@end
