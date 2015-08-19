//
//  HomeSearchCell.h
//  MedicineCure
//
//  Created by line0 on 15/8/17.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeSearchCell : UITableViewCell

@property(nonatomic, strong) UIImageView *cellImage;
@property(nonatomic, strong) UILabel     *searchLable;

+ (CGFloat)drawCellHeight;

@end
