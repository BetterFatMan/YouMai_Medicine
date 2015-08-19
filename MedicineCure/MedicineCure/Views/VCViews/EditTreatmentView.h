//
//  EditTreatmentView.h
//  MedicineCure
//
//  Created by line0 on 15/8/5.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "MCBaseView.h"

@interface EditTreatmentView : MCBaseView

@property(nonatomic, assign) NSInteger treatmentId;
@property(nonatomic, strong) NSString *ttitle;

@property(nonatomic, copy) void (^completeBlock)();

- (void)beginViewAnimation;
- (void)endViewAnimation;

@end


@interface TreatDayTimeView : UIView

@property(nonatomic, strong) UIImageView  *image;
@property(nonatomic, strong) UILabel      *timeLable;
@property(nonatomic, strong) UILabel      *instructeLable;

@end
