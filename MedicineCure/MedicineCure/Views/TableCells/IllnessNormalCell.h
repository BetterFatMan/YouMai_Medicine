//
//  IllnessNormalCell.h
//  MedicineCure
//
//  Created by line0 on 15/7/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IllnessEntity.h"

@interface IllnessNormalCell : UITableViewCell

@property(nonatomic, strong) IllnessEntity *illEntity;

@property(nonatomic, copy)   void (^tapImageBlock)(IllnessEntity *entity);

+ (CGFloat)drawCellHeight;

@end



@interface IllnessTodayCell : UITableViewCell

@property(nonatomic, strong) IllnessEntity *illEntity;

+ (CGFloat)drawCellHeight;

@end