//
//  CycleScrollView.m
//  CycleScrollDemo
//
//  Created by Weever Lu on 12-6-14.
//  Copyright (c) 2012年 linkcity. All rights reserved.
//

#import "CycleScrollView.h"

@implementation CycleScrollView
{
    UIScrollView        *scrollView;
    UIView              *currentView;
    
    int                 totalPage;
    int                 curPage;
    CGRect              scrollFrame;
        /// scrollView滚动的方向
    EnumCycleDirection  scrollDirection;
        /// 存放所有需要滚动的UIView
    NSArray             *cycleViewArr;
        /// 存放当前滚动的三个UIView
    NSMutableArray      *currentViews;
    
    NSTimer             *autoScrollTimer;
    NSMutableDictionary *mutlDict;
    UIView              *_bgView;
    UIPageControl       *_pageControl;
}


- (id)initWithFrame:(CGRect)frame cycleDirection:(EnumCycleDirection)direction cycleViews:(NSArray *)cycleViews bgView:(UIView *)bgView
{
    self = [super initWithFrame:frame];
    if(self)
    {
        mutlDict                = [NSMutableDictionary dictionary];

        self.backgroundColor    = [UIColor clearColor];
        scrollFrame             = frame;
        scrollDirection         = direction;
        totalPage               = (int)cycleViews.count;
            /// 显示的是图片数组里的第一张图片
        curPage                 = 1;
        currentViews            = [NSMutableArray array];
        cycleViewArr            = [NSArray arrayWithArray:cycleViews];
        _bgView                 = bgView;
        
        if(_bgView)
        {
            _bgView.center = self.center;
            [self addSubview:_bgView];
        }
        
        scrollView              = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        scrollView.pagingEnabled= YES;
        scrollView.delegate     = self;
        scrollView.backgroundColor                  = [UIColor blackColor];
        scrollView.showsHorizontalScrollIndicator   = NO;
        scrollView.showsVerticalScrollIndicator     = NO;
        [self addSubview:scrollView];
        
        if ([cycleViewArr count] > 1 )
        {
                // 在水平方向滚动
            if(scrollDirection == EnumCycleDirectionLandscape)
            {
                scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * 3, scrollView.frame.size.height);
            }
                // 在垂直方向滚动
            if(scrollDirection == EnumCycleDirectionPortait)
            {
                scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height * 3);
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

- (void)setIsShowUIPageControl:(BOOL)isShowUIPageControl
{
    _isShowUIPageControl = isShowUIPageControl;
    if (_isShowUIPageControl)
    {
        if (!_pageControl)
        {
            _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, scrollFrame.size.height - 25, 320, 20)];
        }
        _pageControl.numberOfPages  = [cycleViewArr count];
        _pageControl.currentPage    = curPage-1;
        _pageControl.pageIndicatorTintColor = kLineGrayColor;
        _pageControl.currentPageIndicatorTintColor = UICOLOR_RGB(248, 115, 115);
        [self addSubview:_pageControl];
    }
    else
    {
        [_pageControl removeFromSuperview];
    }
}

- (void)startTimer
{
    [self refreshScrollView];

    if (cycleViewArr && [cycleViewArr count] > 1)
    {
        if ([autoScrollTimer isValid])
        {
            [autoScrollTimer invalidate];
            autoScrollTimer = nil;
        }
        autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(autoScroll:) userInfo:nil repeats:YES];
    }
}


- (void)cleanUpTimerAndCache
{
    if ([autoScrollTimer isValid])
    {
        [autoScrollTimer invalidate];
        autoScrollTimer = nil;
    }

    if ([mutlDict count])
    {
        [mutlDict removeAllObjects];
    }

    for (UIView *v in scrollView.subviews)
    {
        [v removeFromSuperview];
    }
}


- (void)refreshScrollView 
{
    if (!cycleViewArr || [cycleViewArr count] < 1)
        return;
    
    for (UIView *v in scrollView.subviews)
    {
        [v removeFromSuperview];
    }

    [self getDisplayViewWithCurpage:curPage];
    
    for (int i = 0; i < 3 && [currentViews count] > i; i++) 
    {
        @autoreleasepool
        {
            UIView *displayView = [currentViews objectAtIndexSafe:i];
            displayView.frame = CGRectMake(0, 0, scrollFrame.size.width, scrollFrame.size.height);
            [scrollView addSubview:displayView];
            if (![mutlDict.allValues containsObject:displayView])
            {
                UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
                [displayView addGestureRecognizer:singleTap];
                
                [mutlDict setObject:displayView forKey:@(curPage).stringValue];
            }
                // 水平滚动
            if(scrollDirection == EnumCycleDirectionLandscape)
            {
                displayView.frame = CGRectOffset(displayView.frame, scrollFrame.size.width * i, 0);
            }
                // 垂直滚动
            if(scrollDirection == EnumCycleDirectionPortait)
            {
                displayView.frame = CGRectOffset(displayView.frame, 0, scrollFrame.size.height * i);
            }
        }
    }
    
    if ([currentViews count] > 1)
    {
        if (scrollDirection == EnumCycleDirectionLandscape)
        {
            [scrollView setContentOffset:CGPointMake(scrollFrame.size.width, 0)];
        }
        
        if (scrollDirection == EnumCycleDirectionPortait)
        {
            [scrollView setContentOffset:CGPointMake(0, scrollFrame.size.height)];
        }
    }
}

- (NSArray *)getDisplayViewWithCurpage:(int)page
{
    if(!cycleViewArr || [cycleViewArr count] == 0)
        return nil;
    
    if([cycleViewArr count] == 1)
    {
        if([currentViews count] != 0) [currentViews removeAllObjects];
        [currentViews addObject:[cycleViewArr objectAtIndexSafe:curPage-1]];
        return currentViews;
    }
    
    int pre = [self validPageValue:curPage-1];
    int last = [self validPageValue:curPage+1];
    
    if([currentViews count] != 0) [currentViews removeAllObjects];
    
    [currentViews addObject:[cycleViewArr objectAtIndexSafe:pre-1]];
    [currentViews addObject:[cycleViewArr objectAtIndexSafe:curPage-1]];
    [currentViews addObject:[cycleViewArr objectAtIndexSafe:last-1]];
    
    return currentViews;
}

- (int)validPageValue:(int)value
{
        /// value＝1为第一张，value = 0为前面一张
    if(value == 0) value = totalPage;
    if(value == totalPage + 1) value = 1;
    
    return value;
}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView 
{
    int x = aScrollView.contentOffset.x;
    int y = aScrollView.contentOffset.y;
    
    // 水平滚动
    if(scrollDirection == EnumCycleDirectionLandscape)
    {
        // 往下翻一张
        if(x >= (2*scrollFrame.size.width)) 
        { 
            curPage = [self validPageValue:curPage+1];
            [self refreshScrollView];
        }
        
        if(x <= 0) 
        {
            curPage = [self validPageValue:curPage-1];
            [self refreshScrollView];
        }
    }
    
        /// 垂直滚动
    if(scrollDirection == EnumCycleDirectionPortait)
    {
            /// 往下翻一张
        if(y >= 2 * (scrollFrame.size.height))
        { 
            curPage = [self validPageValue:curPage+1];
            [self refreshScrollView];
        }
        
        if(y <= 0) 
        {
            curPage = [self validPageValue:curPage-1];
            [self refreshScrollView];
        }
    }
    
    if ([_delegate respondsToSelector:@selector(cycleScrollViewDelegate:didScrollView:)])
    {
        [_delegate cycleScrollViewDelegate:self didScrollView:curPage];
    }
    
    if (_isShowUIPageControl)
    {
        _pageControl.currentPage = curPage-1;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView
{
    if (scrollDirection == EnumCycleDirectionLandscape)
    {
        [scrollView setContentOffset:CGPointMake(scrollFrame.size.width, 0) animated:YES];
    }
    
    if (scrollDirection == EnumCycleDirectionPortait)
    {
        [scrollView setContentOffset:CGPointMake(0, scrollFrame.size.height) animated:YES];
    }
}

#pragma mark - GestureRecognizer
- (void)handleTap:(UITapGestureRecognizer *)tap
{
    if ([_delegate respondsToSelector:@selector(cycleScrollViewDelegate:didSelectView:)])
    {
        [_delegate cycleScrollViewDelegate:self didSelectView:curPage];
    }
}

- (void)autoScroll:(NSTimer *)timer
{
    if (scrollDirection == EnumCycleDirectionLandscape)
    {
        [scrollView scrollRectToVisible:CGRectMake(2 * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:YES];
    }
    
    if (scrollDirection == EnumCycleDirectionPortait)
    {
        [scrollView scrollRectToVisible:CGRectMake(0, 2 * self.frame.size.height, self.frame.size.width, self.frame.size.height) animated:YES];
    }
}


- (void)dealloc
{
    autoScrollTimer = nil;
    _bgView = nil;
}

@end
