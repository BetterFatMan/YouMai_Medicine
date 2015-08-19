//
//  CycleScrollTable.m
//  Line0new
//
//  Created by line0 on 15/1/27.
//  Copyright (c) 2015年 com.line0. All rights reserved.
//

#import "CycleScrollTable.h"

#define kLastWidth      10
#define kSpaceWidth     10


@implementation CycleScrollTable
{
    UIScrollView        *_scrollView;
    UIView              *currentView;
    
    int                 totalPage;
    CGRect              scrollFrame;
        /// scrollView滚动的方向
    EnumCycleDirection  scrollDirection;
        /// 存放所有需要滚动的UIView
    NSMutableArray      *cycleViewArr;
    
    NSMutableDictionary *mutlDict;
    UIView              *_bgView;
    CGFloat             scrollOffsetX;
}


- (id)initWithFrame:(CGRect)frame cycleDirection:(EnumCycleDirection)direction cycleViews:(NSArray *)cycleViews bgView:(UIView *)bgView
{
    self = [super initWithFrame:frame];
    if(self)
    {
        mutlDict                = [NSMutableDictionary dictionary];
        
        self.backgroundColor    = kAppBgColor;
        scrollFrame             = frame;
        scrollDirection         = direction;
        totalPage               = (int)cycleViews.count;
            /// 显示的是图片数组里的第一张图片
        _curPage                 = 0;
        cycleViewArr            = [NSMutableArray arrayWithArray:cycleViews];
        _bgView                 = bgView;
        
        if(_bgView)
        {
            _bgView.center = self.center;
            [self addSubview:_bgView];
        }
        
        _scrollView              = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//        _scrollView.pagingEnabled= YES;
        _scrollView.delegate     = self;
        _scrollView.backgroundColor                  = kAppBgColor;
        _scrollView.showsHorizontalScrollIndicator   = NO;
        _scrollView.showsVerticalScrollIndicator     = NO;
        [self addSubview:_scrollView];
        
        if ([cycleViewArr count] > 1 )
        {
                // 在水平方向滚动
            if(scrollDirection == EnumCycleDirectionLandscape)
            {
                _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * 3, _scrollView.frame.size.height);
            }
            
            [self startTimer];
        }
        else
        {
            [self refreshScrollView];
        }
    }
    
    return self;
}

- (void)startTimer
{
    [self refreshScrollView];
}

- (void)cleanUpTimerAndCache
{
    if ([mutlDict count])
    {
        [mutlDict removeAllObjects];
    }
    
    for (UIView *v in _scrollView.subviews)
    {
        [v removeFromSuperview];
    }
}

- (void)resetSubViewArr:(NSArray *)viewArr
{
    [cycleViewArr removeAllObjects];
    [cycleViewArr addObjectsFromArray:viewArr];
    
    [self cleanUpTimerAndCache];
    [self refreshScrollView];
}

- (void)refreshScrollView
{
    if (!cycleViewArr || [cycleViewArr count] < 1)
        return;
    
    for (UIView *v in _scrollView.subviews)
    {
        [v removeFromSuperview];
    }
    
    CGFloat spaceLeft    = kLastWidth + kSpaceWidth/2;
    CGFloat scrollWidth  = scrollFrame.size.width - spaceLeft*2;
    CGFloat scrollHeight = scrollFrame.size.height;
    for (int i = 0; i < [cycleViewArr count]; i++)
    {
        @autoreleasepool
        {
            UIView *displayView = [cycleViewArr objectAtIndexSafe:i];
            displayView.frame = CGRectMake(0, 0, scrollWidth, scrollHeight);
            [_scrollView addSubview:displayView];
            if (![mutlDict.allValues containsObject:displayView])
            {
                UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
                [displayView addGestureRecognizer:singleTap];
                
                [mutlDict setObject:displayView forKey:@(i).stringValue];
            }
                // 水平滚动
            if(scrollDirection == EnumCycleDirectionLandscape)
            {
                displayView.frame = CGRectOffset(displayView.frame, spaceLeft, 0);
            }

            spaceLeft += scrollWidth;
        }
    }
    
    if ([cycleViewArr count] > 1)
    {
        if (scrollDirection == EnumCycleDirectionLandscape)
        {
            [_scrollView setContentSize:CGSizeMake(spaceLeft + kLastWidth + kSpaceWidth/2, 0)];
            _curPage = 0;
            
            scrollOffsetX = 0;
        }
    }
}

- (void)scrollToPage:(int)page
{
    _curPage = page;
    CGFloat spaceLeft    = kLastWidth + kSpaceWidth/2;
    CGFloat scrollWidth  = scrollFrame.size.width - spaceLeft*2;
    _scrollView.contentOffset = CGPointMake(page * scrollWidth, 0);
    scrollOffsetX = page * scrollWidth;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat contentX = scrollView.contentOffset.x;
    CGFloat lastX    = scrollOffsetX;
    
    CGFloat scrollWidth  = scrollFrame.size.width - (kLastWidth*2 + kSpaceWidth);
    
    if (contentX > lastX)
    {
        if (contentX - lastX > 15)
        {
            _curPage  ++;
            if (_curPage > cycleViewArr.count - 1)
            {
                _curPage = (int)cycleViewArr.count - 1;
            }
        }
    }
    else
    {
        if (lastX - contentX > 15)
        {
            _curPage  --;
            if (_curPage < 0)
            {
                _curPage = 0;
            }
        }
    }
    
    scrollOffsetX = _curPage * scrollWidth;
    [scrollView setContentOffset:CGPointMake(scrollOffsetX, 0) animated:YES];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
//    CGFloat contentX = scrollView.contentOffset.x;
//    CGFloat lastX    = scrollOffsetX;
//    
//    CGFloat scrollWidth  = scrollFrame.size.width - (kLastWidth*2 + kSpaceWidth);
//    
//    if (contentX > lastX)
//    {
//        if (contentX - lastX > 15)
//        {
//            _curPage  ++;
//            if (_curPage > cycleViewArr.count - 1)
//            {
//                _curPage = (int)cycleViewArr.count - 1;
//            }
//        }
//    }
//    else
//    {
//        if (lastX - contentX > 15)
//        {
//            _curPage  --;
//            if (_curPage < 0)
//            {
//                _curPage = 0;
//            }
//        }
//    }
//    
//    scrollOffsetX = _curPage * scrollWidth;
    [scrollView setContentOffset:CGPointMake(scrollOffsetX, 0) animated:YES];
}
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView

- (void)handleTap:(UITapGestureRecognizer *)tap
{
    
}

- (void)dealloc
{
    _bgView = nil;
}

@end

