//
//  ShareActivity.m
//  Line0new
//
//  Created by user on 14-9-1.
//  Copyright (c) 2014年 com.line0. All rights reserved.
//

#import "ShareActivity.h"
#define WINDOW_COLOR                            [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]
#define ANIMATE_DURATION                                          0.25f

#define CORNER_RADIUS                                      4


#define SHAREBUTTON_WIDTH                                  50
#define SHAREBUTTON_HEIGHT                                 50

#define SHARETITLE_WIDTH                                   50
#define SHARETITLE_HEIGHT                                  20

#define BUTTON_WIDTH                                        200


@interface ShareActivity ()

@property(nonatomic, strong) UIView *backView;
@property(nonatomic, assign) CGFloat ShareActivityHeight;
@property(nonatomic, weak) id<ShareActivityDelegate> delegate;

@end

@implementation ShareActivity

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id)initWithTitle:(NSString *)title delegate:(id<ShareActivityDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle ShareButtonTitles:(NSArray *)shareButtonTitlesArray withShareButtonImagesName:(NSArray *)shareButtonImagesNameArray;
{
    self = [super init];
    if (self) {
            //初始化背景视图，添加手势
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.backgroundColor = WINDOW_COLOR;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
        [self addGestureRecognizer:tapGesture];
        
        if (delegate) {
            self.delegate = delegate;
        }
        
        [self creatButtonsWithTitle:title cancelButtonTitle:cancelButtonTitle shareButtonTitles:shareButtonTitlesArray withShareButtonImagesName:shareButtonImagesNameArray];
        
    }
    return self;
}

- (void)showInView:(UIView *)view
{
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
}

- (void)showInView:(UIView *)view isSub:(BOOL)isAddSub
{
    if (isAddSub)
    {
        [view addSubview:self];
    }
    else
    {
        [self showInView:view];
    }
}

- (void)creatButtonsWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle shareButtonTitles:(NSArray *)shareButtonTitlesArray withShareButtonImagesName:(NSArray *)shareButtonImagesNameArray
{
    self.ShareActivityHeight = 0;
    
        ///生成ShareActionSheetView
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
    self.backView.backgroundColor = [UIColor whiteColor];
    
        ///给ShareActionSheetView添加响应事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
    [self.backView addGestureRecognizer:tapGesture];
    [self addSubview:self.backView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.backView.width, 40)];
    NSString *titleStr = [title stringByReplacingOccurrencesOfString:@" " withString:@""];
    CGSize titleLabelSize = getStringSize(titleStr, [UIFont systemFontOfSize:16.0f], CGSizeMake(self.backView.width, 40));
    titleLabel.font = [UIFont systemFontOfSize:16.0f];
    titleLabel.text = titleStr;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    self.ShareActivityHeight = titleLabelSize.height;
    [self.backView addSubview:titleLabel];
    
        ///微信好友分享
    UIButton *weChatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [weChatBtn setFrame:CGRectMake((self.backView.width - 145) / 2, titleLabel.bottom + 5, SHAREBUTTON_WIDTH, SHAREBUTTON_HEIGHT)];
   [weChatBtn setBackgroundImage:[UIImage imageNamed:[shareButtonImagesNameArray objectAtIndexSafe:0]] forState:UIControlStateNormal];
    weChatBtn.tag = 0;
    [weChatBtn addTarget:self action:@selector(didClickOnImageIndex:) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:weChatBtn];
    UILabel *wxChatTitle = [[UILabel alloc] initWithFrame:CGRectMake(weChatBtn.left, weChatBtn.bottom, SHARETITLE_WIDTH, SHARETITLE_HEIGHT)];
    [self createShareButtonTitles:[shareButtonTitlesArray objectAtIndexSafe:0] shareButtonLabel:wxChatTitle];
    
        ///朋友圈分享
    UIButton *weChatFriendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [weChatFriendBtn setFrame:CGRectMake(weChatBtn.right + 45, weChatBtn.top, SHAREBUTTON_WIDTH, SHAREBUTTON_HEIGHT)];
    [weChatFriendBtn setBackgroundImage:[UIImage imageNamed:[shareButtonImagesNameArray objectAtIndexSafe:1]] forState:UIControlStateNormal];
    weChatFriendBtn.tag = 1;
    [weChatFriendBtn addTarget:self action:@selector(didClickOnImageIndex:) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:weChatFriendBtn];
    UILabel *weixinTitle = [[UILabel alloc] initWithFrame:CGRectMake(weChatFriendBtn.left, weChatFriendBtn.bottom, SHARETITLE_WIDTH, SHARETITLE_HEIGHT)];
    [self createShareButtonTitles:[shareButtonTitlesArray objectAtIndexSafe:1] shareButtonLabel:weixinTitle];
    
        ///新浪微博分享
//    UIButton *weiboBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [weiboBtn setFrame:CGRectMake(weChatFriendBtn.right + 45, weChatFriendBtn.top, SHAREBUTTON_WIDTH, SHAREBUTTON_HEIGHT)];
//    [weiboBtn setBackgroundImage:[UIImage imageNamed:[shareButtonImagesNameArray objectAtIndexSafe:2]] forState:UIControlStateNormal];
//    weiboBtn.tag = 2;
//    [weiboBtn addTarget:self action:@selector(didClickOnImageIndex:) forControlEvents:UIControlEventTouchUpInside];
//    [self.backView addSubview:weiboBtn];
//    UILabel *weiboTitle = [[UILabel alloc] initWithFrame:CGRectMake(weiboBtn.left, weiboBtn.bottom, SHARETITLE_WIDTH, SHARETITLE_HEIGHT)];
//    [self createShareButtonTitles:[shareButtonTitlesArray objectAtIndexSafe:2] shareButtonLabel:weiboTitle];
    
        ///QQ好友
//    UIButton *qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [qqBtn setFrame:CGRectMake(40, weiboTitle.bottom + 10, 80, 30)];
//    qqBtn.tag = 3;
//    qqBtn.titleLabel.text = @"QQ好友";
//    [qqBtn addTarget:self action:@selector(didClickOnImageIndex:) forControlEvents:UIControlEventTouchUpInside];
//    [self.backView addSubview:qqBtn];
    
    
        ///取消分享btn
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setFrame:CGRectMake((self.backView.width - BUTTON_WIDTH) / 2, weixinTitle.bottom + 20, BUTTON_WIDTH, 39)];
    cancelBtn.backgroundColor = [UIColor red:151 green:154 blue:160 alpha:1];
    cancelBtn.layer.masksToBounds = YES;
    cancelBtn.layer.cornerRadius = CORNER_RADIUS;
    [cancelBtn setTitle:cancelButtonTitle forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(tappedCancel) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.tag = 10;
    [self.backView addSubview:cancelBtn];

    
    self.ShareActivityHeight = 200;
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-self.ShareActivityHeight, [UIScreen mainScreen].bounds.size.width, self.ShareActivityHeight)];
    } completion:^(BOOL finished) {
    }];
}

- (void)createShareButtonTitles:(NSString *)title shareButtonLabel:(UILabel *)shareButtonLabel
{
    NSString *shareButtonTitleStr = [title stringByReplacingOccurrencesOfString:@" " withString:@""];
    CGSize shareButtonTitleSize = getStringSize(shareButtonTitleStr, [UIFont systemFontOfSize:10.0f], CGSizeMake(SHARETITLE_WIDTH, SHARETITLE_HEIGHT));
    shareButtonLabel.text = shareButtonTitleStr;
    shareButtonLabel.font = [UIFont systemFontOfSize:10.0f];
    shareButtonLabel.textAlignment = NSTextAlignmentCenter;
    shareButtonLabel.textColor = [UIColor blackColor];
    self.ShareActivityHeight = shareButtonTitleSize.height;
    [self.backView addSubview:shareButtonLabel];
}

- (void)didClickOnImageIndex:(UIButton *)button
{
    if (self.delegate)
    {
        if ([self.delegate respondsToSelector:@selector(didClickOnImageIndex:)] == YES)
        {
            [self.delegate didClickOnImageIndex:button.tag];
        }
    }
    [self tappedCancel];
}

- (void)tappedCancel
{
    __weak typeof(self) _wself = self;
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [_wself.backView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
        _wself.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished)
        {
            [_wself removeFromSuperview];
        }
    }];
    
    
}

@end
