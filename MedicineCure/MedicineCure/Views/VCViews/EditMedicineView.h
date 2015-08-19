//
//  EditMedicineView.h
//  MedicineCure
//
//  Created by line0 on 15/8/8.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "MCBaseView.h"

@interface EditMedicineView : MCBaseView

@property(nonatomic, copy) void (^medicineSuccessBlock)();

- (void)beginViewAnimation;
- (void)endViewAnimation;

@end
