//
//  MedicineArticleVC.m
//  MedicineCure
//
//  Created by line0 on 15/8/1.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "MedicineArticleVC.h"

#import "TYAttributedLabel.h"
#import "TYImageStorage.h"
#import "TYTextStorage.h"
#import "RegexKitLite.h"

#import "ArticleEntity.h"

@interface MedicineArticleVC ()<TYAttributedLabelDelegate>

@property (nonatomic,weak) TYAttributedLabel *label1;
@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation MedicineArticleVC

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
    self.title = @"文章详情";
    
    [self addScrollView];
    
        // addAttributedText
    if (_articleEntity) {
        UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, self.navView.bottom, kKeyWindow.width, kKeyWindow.height - 64)];
        [self.view addSubview:web];
        
        [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@", _articleEntity.articleUrl]]]];
        self.title = _articleEntity.title;
    } else {
        [self addTextAttributedLabel2];
    }
    
}

- (void)addScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.top = self.navView.bottom;
    scrollView.height = kKeyWindow.height - 64;
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
}
    // addAttributedText
- (void)addTextAttributedLabel2
{
        //使用 RegexKitLite，添加 -fno-objc-arc，同时添加 libicucore.dylib
        //其实所有漂泊的人，不过是为了有一天能够不再漂泊，能用自己的力量撑起身后的家人和自己爱的人。
    TYAttributedLabel *label = [[TYAttributedLabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_label1.frame) + 0, CGRectGetWidth(self.view.frame), 0)];
    [_scrollView addSubview:label];
    label.delegate = self;
    NSString *text = @"[CYLoLi,320,180]其实所有漂泊的人，[haha,15,15]不过是为了有一天能够不再漂泊，[haha,15,15]能用自己的力量撑起身后的家人和自己爱的人。[avatar,60,60][CYLoLi,320,180]其实所有漂泊的人，[haha,15,15]不过是为了有一天能够不再漂泊，[haha,15,15]能用自己的力量撑起身后的家人和自己爱的人。[avatar,60,60][CYLoLi,320,180]其实所有漂泊的人，[haha,15,15]不过是为了有一天能够不再漂泊，[haha,15,15]能用自己的力量撑起身后的家人和自己爱的人。[avatar,60,60]";
    
        // 属性文本生成器
    TYTextContainer *attStringCreater = [[TYTextContainer alloc]init];
    attStringCreater.text = text;
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    CGFloat scanPlus = kKeyWindow.width/320;
        // 正则匹配图片信息
    [text enumerateStringsMatchedByRegex:@"\\[(\\w+?),(\\d+?),(\\d+?)\\]" usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        
        if (captureCount > 3) {
                // 图片信息储存
            TYImageStorage *imageStorage = [[TYImageStorage alloc]init];
            imageStorage.imageName = capturedStrings[1];
            imageStorage.range = capturedRanges[0];
            imageStorage.size = CGSizeMake([capturedStrings[2]intValue]*scanPlus, [capturedStrings[3]intValue]*scanPlus);
            
            [tmpArray addObject:imageStorage];
        }
    }];
    
        // 添加图片信息数组到label
    [attStringCreater addTextStorageArray:tmpArray];
    
    TYTextStorage *textStorage = [[TYTextStorage alloc]init];
    textStorage.range = [text rangeOfString:@"[CYLoLi,320,180]其实所有漂泊的人，"];
    textStorage.textColor = UICOLOR_RGBA(213, 0, 0, 1);
    textStorage.font = [UIFont systemFontOfSize:16];
    [attStringCreater addTextStorage:textStorage];
    
    textStorage = [[TYTextStorage alloc]init];
    textStorage.range = [text rangeOfString:@"不过是为了有一天能够不再漂泊，"];
    textStorage.textColor = UICOLOR_RGBA(0, 155, 0, 1);
    textStorage.font = [UIFont systemFontOfSize:18];
    [attStringCreater addTextStorage:textStorage];
    
    [attStringCreater createTextContainerWithTextWidth:CGRectGetWidth(self.view.frame)];
    
    [label setTextContainer:attStringCreater];
    
    [label sizeToFit];
    
    [_scrollView setContentSize:CGSizeMake(0, CGRectGetMaxY(label.frame)+10)];
}

#pragma mark - deleagte

- (void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageClicked:(id<TYTextStorageProtocol>)textStorage atPoint:(CGPoint)point
{
    NSLog(@"textStorageClickedAtPoint");
}

- (void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageLongPressed:(id<TYTextStorageProtocol>)textStorage onState:(UIGestureRecognizerState)state atPoint:(CGPoint)point
{
    NSLog(@"textStorageLongPressed");
}

@end
