//
//  ThreeItemsSelectView.h
//  MedicineCure
//
//  Created by line0 on 15/8/4.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThreeItemsSelectView : UIView

@property(nonatomic, strong) NSArray *itemsList;

@property(nonatomic, weak)   id delegate;

@end
