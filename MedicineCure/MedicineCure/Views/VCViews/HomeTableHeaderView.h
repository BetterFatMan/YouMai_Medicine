//
//  HomeTableHeaderView.h
//  MedicineCure
//
//  Created by line0 on 15/7/31.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableHeaderView : UIView

@property(nonatomic, strong) NSMutableArray *medicineList;

@property(nonatomic, copy)  void (^getSearcherVCBlock)();

@property(nonatomic, copy)  void (^addMedicineBlock)();

@end
