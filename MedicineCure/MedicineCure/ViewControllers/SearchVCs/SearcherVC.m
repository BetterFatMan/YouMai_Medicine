//
//  SearcherVC.m
//  MedicineCure
//
//  Created by line0 on 15/8/1.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "SearcherVC.h"

#import "SXTitleLable.h"

@interface SearcherVC ()<UITextFieldDelegate, UIScrollViewDelegate>
{
    UITextField *_searchText;
}

/** 标题栏 */
@property (strong, nonatomic) UIScrollView *smallScrollView;

/** 下面的内容栏 */
@property (strong, nonatomic) UIScrollView *bigScrollView;

@end

@implementation SearcherVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addViewSubs];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_searchText resignFirstResponder];
}

#pragma mark - SubViews
- (void)addViewSubs
{
    [self addNaviBars];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.smallScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.bottom, kKeyWindow.width, 30)];
    self.smallScrollView.backgroundColor = [UIColor whiteColor];
    self.smallScrollView.showsHorizontalScrollIndicator = NO;
    self.smallScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_smallScrollView];
    
    self.bigScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.smallScrollView.bottom, kKeyWindow.width, kKeyWindow.height - self.smallScrollView.bottom)];
    self.bigScrollView.backgroundColor = kAppBgColor;
    self.bigScrollView.delegate = self;
    [self.view addSubview:_bigScrollView];
    
    [self addController];
    [self addLable];
    
    CGFloat contentX = self.childViewControllers.count * [UIScreen mainScreen].bounds.size.width;
    self.bigScrollView.contentSize = CGSizeMake(contentX, 0);
    self.bigScrollView.pagingEnabled = YES;
    
        // 添加默认控制器
    UIViewController *vc = [self.childViewControllers firstObject];
    vc.view.frame = self.bigScrollView.bounds;
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.bigScrollView addSubview:vc.view];
    SXTitleLable *lable = [self.smallScrollView.subviews firstObject];
    lable.scale = 1.0;
}

- (void)addNaviBars
{
    _searchText = [[UITextField alloc] initWithFrame:CGRectMake(70, 32, kKeyWindow.width - 135, 20)];
    _searchText.delegate = self;
    _searchText.backgroundColor = [UIColor clearColor];
    _searchText.textColor = kLBBlackColor;
    _searchText.textAlignment = NSTextAlignmentLeft;
    _searchText.font = gFontSystemSize(16);
    _searchText.placeholder = @"输入关键词，药名，治疗名";
    [self.navView addSubview:_searchText];
    
    UIButton *rightBtn        = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame            = CGRectMake(kKeyWindow.width - 44, 20, 44, 44);
    [rightBtn setImage:[UIImage imageNamed:@"main_icon_search_gray"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(clickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:rightBtn];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapVCViewGesture:)]];
}

#pragma mark - ******************** 添加方法

/** 添加子控制器 */
- (void)addController
{
    UIViewController *vc1 = [UIViewController new];
    vc1.title = @"手术";
    [self addChildViewController:vc1];
    UIViewController *vc2 = [UIViewController new];
    vc2.title = @"放疗";
    [self addChildViewController:vc2];
    UIViewController *vc3 = [UIViewController new];
    vc3.title = @"化疗";
    [self addChildViewController:vc3];
    UIViewController *vc4 = [UIViewController new];
    vc4.title = @"住院";
    [self addChildViewController:vc4];
    UIViewController *vc8 = [UIViewController new];
    vc8.title = @"靶向";
    [self addChildViewController:vc8];
    UIViewController *vc5 = [UIViewController new];
    vc5.title = @"检查";
    [self addChildViewController:vc5];
    UIViewController *vc6 = [UIViewController new];
    vc6.title = @"健康";
    [self addChildViewController:vc6];
    UIViewController *vc7 = [UIViewController new];
    vc7.title = @"康复";
    [self addChildViewController:vc7];
    UIViewController *vc9 = [UIViewController new];
    vc9.title = @"药品";
    [self addChildViewController:vc9];
}

/** 添加标题栏 */
- (void)addLable
{
    for (int i = 0; i < 9; i++) {
        CGFloat lblW = 70;
        CGFloat lblH = 30;
        CGFloat lblY = 0;
        CGFloat lblX = i * lblW;
        SXTitleLable *lbl1 = [[SXTitleLable alloc]init];
        UIViewController *vc = self.childViewControllers[i];
        lbl1.text =vc.title;
        lbl1.frame = CGRectMake(lblX, lblY, lblW, lblH);
        lbl1.font = [UIFont fontWithName:@"HYQiHei" size:17];
        [self.smallScrollView addSubview:lbl1];
        lbl1.tag = i;
        lbl1.userInteractionEnabled = YES;
        
        [lbl1 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lblClick:)]];
    }
    self.smallScrollView.contentSize = CGSizeMake(70 * 9, 0);
    
}

/** 标题栏label的点击事件 */
- (void)lblClick:(UITapGestureRecognizer *)recognizer
{
    SXTitleLable *titlelable = (SXTitleLable *)recognizer.view;
    
    CGFloat offsetX = titlelable.tag * self.bigScrollView.frame.size.width;
    
    CGFloat offsetY = self.bigScrollView.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    
    [self.bigScrollView setContentOffset:offset animated:YES];
    
    
}

#pragma mark - ******************** scrollView代理方法

/** 滚动结束后调用（代码导致） */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
        // 获得索引
    NSUInteger index = scrollView.contentOffset.x / self.bigScrollView.frame.size.width;
    
        // 滚动标题栏
    SXTitleLable *titleLable = (SXTitleLable *)self.smallScrollView.subviews[index];
    
    CGFloat offsetx = titleLable.center.x - self.smallScrollView.frame.size.width * 0.5;
    
    CGFloat offsetMax = self.smallScrollView.contentSize.width - self.smallScrollView.frame.size.width;
    if (offsetx < 0) {
        offsetx = 0;
    }else if (offsetx > offsetMax){
        offsetx = offsetMax;
    }
    
    CGPoint offset = CGPointMake(offsetx, self.smallScrollView.contentOffset.y);
    [self.smallScrollView setContentOffset:offset animated:YES];
        // 添加控制器
    UIViewController *newsVc = self.childViewControllers[index];
    
    [self.smallScrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx != index) {
            SXTitleLable *temlabel = self.smallScrollView.subviews[idx];
            temlabel.scale = 0.0;
        }
    }];
    
    if (newsVc.view.superview) return;
    
    newsVc.view.frame = scrollView.bounds;
    newsVc.view.backgroundColor = UICOLOR_RGB(arc4random()%255, arc4random()%255, arc4random()%255);
    [self.bigScrollView addSubview:newsVc.view];
}

/** 滚动结束（手势导致） */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/** 正在滚动 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
        // 取出绝对值 避免最左边往右拉时形变超过1
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1 - scaleRight;
    SXTitleLable *labelLeft = self.smallScrollView.subviews[leftIndex];
    labelLeft.scale = scaleLeft;
        // 考虑到最后一个板块，如果右边已经没有板块了 就不在下面赋值scale了
    if (rightIndex < self.smallScrollView.subviews.count) {
        SXTitleLable *labelRight = self.smallScrollView.subviews[rightIndex];
        labelRight.scale = scaleRight;
    }
    
}

#pragma mark - UIButton Actions
- (void)clickRightBtn:(id)sender
{
    
}

- (void)tapVCViewGesture:(UITapGestureRecognizer *)gesture
{
    [self.view endEditing:YES];
}

@end
