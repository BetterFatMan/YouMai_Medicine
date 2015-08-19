//
//  CycleScrollTable.h
//  Line0new
//
//  Created by line0 on 15/1/27.
//  Copyright (c) 2015年 com.line0. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
//    EnumCycleDirectionPortait,          // 垂直滚动
    EnumCycleDirectionLandscape         // 水平滚动
}EnumCycleDirection;

//@protocol CycleScrollTableDelegate;

@interface CycleScrollTable : UIView <UIScrollViewDelegate>

//@property(nonatomic, weak) id<CycleScrollTableDelegate>        scrollTableDelegate;
@property(nonatomic, assign) int curPage;

- (id)initWithFrame:(CGRect)frame cycleDirection:(EnumCycleDirection)direction cycleViews:(NSArray *)cycleViews bgView:(UIView *)bgView;

- (void)refreshScrollView;

- (void)startTimer;

- (void)resetSubViewArr:(NSArray *)viewArr;

- (void)cleanUpTimerAndCache;

- (void)scrollToPage:(int)page;

@end



//@protocol CycleScrollTableDelegate <NSObject>
//
//@optional
//- (void)cycleScrollViewDelegate:(CycleScrollTable *)cycleScrollView didSelectView:(int)index;
//
//- (void)cycleScrollViewDelegate:(CycleScrollTable *)cycleScrollView didScrollView:(int)index;
//
//@end



