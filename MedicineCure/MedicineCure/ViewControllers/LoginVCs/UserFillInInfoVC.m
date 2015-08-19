//
//  UserFillInInfoVC.m
//  MedicineCure
//
//  Created by line0 on 15/8/1.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "UserFillInInfoVC.h"

#import "MCTextField.h"

@interface UserFillInInfoVC ()
{
    UIButton  *_completeBtn;
    
    NSArray   *_positionList;
    NSArray   *_careList;
}

@end

@implementation UserFillInInfoVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _positionList = @[@"病人", @"家属", @"健康人"];
        _careList     = @[@"乳腺癌", @"肺癌", @"宫颈癌", @"胃癌", @"鼻咽癌", @"直肠癌"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"用户信息";
    
    [self addAllViewsSub];
}

#pragma mark - SubViews
- (void)addAllViewsSub
{
        ///////////////
    UILabel *nameLable1 = [[UILabel alloc ] initWithFrame:CGRectMake((kKeyWindow.width - 280)/2, self.navView.bottom + 35, 55, 20)];
    nameLable1.textAlignment = NSTextAlignmentCenter;
    nameLable1.textColor     = kBBlackColor;
    nameLable1.font          = gFontSystemSize(15);
    nameLable1.text          = @"身份";
    [self.view addSubview:nameLable1];
    
    CGFloat top1 = nameLable1.top - 7;
    CGFloat left1 = nameLable1.right + 25;
    CGFloat width = 60;
    CGFloat height = 35;
    for (int i = 0; i < _positionList.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(left1, top1, width, height);
        btn.layer.borderColor = kLineGrayColor.CGColor;
        btn.layer.borderWidth = 0.5;
        [btn setTitle:[_positionList objectAtIndexSafe:i] forState:UIControlStateNormal];
        [btn setTitleColor:kLBBlackColor forState:UIControlStateNormal];
        btn.titleLabel.font = gFontSystemSize(15);
        [btn setTitle:[_positionList objectAtIndexSafe:i] forState:UIControlStateSelected];
        [btn setTitleColor:kAppNormalBgColor forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(clickPositionBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        left1 += width + 5;
    }
    
    UILabel *nameLable2 = [[UILabel alloc ] initWithFrame:CGRectMake((kKeyWindow.width - 280)/2, nameLable1.bottom + 30, 55, 20)];
    nameLable2.textAlignment = NSTextAlignmentCenter;
    nameLable2.textColor     = kBBlackColor;
    nameLable2.font          = gFontSystemSize(15);
    nameLable2.text          = @"性别";
    [self.view addSubview:nameLable2];
    
    CGFloat left2 = nameLable2.right + 25;
    CGFloat top2  = nameLable2.top - 7;
    for (int i = 0; i < 2; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(left2, top2, width, height);
        btn.backgroundColor = kLightGreenBtnColor;
        btn.layer.borderColor = kLineGrayColor.CGColor;
        btn.layer.borderWidth = 0.5;
        [btn setTitle:(i == 0 ? @"男" : @"女") forState:UIControlStateNormal];
        [btn setTitleColor:kLBBlackColor forState:UIControlStateNormal];
        btn.titleLabel.font = gFontSystemSize(15);
        
        [btn addTarget:self action:@selector(clickUserSexBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        left2 += width + 5;
    }
    
    UILabel *nameLable3 = [[UILabel alloc ] initWithFrame:CGRectMake((kKeyWindow.width - 280)/2, nameLable2.bottom + 30, 55, 20)];
    nameLable3.textAlignment = NSTextAlignmentCenter;
    nameLable3.textColor     = kBBlackColor;
    nameLable3.font          = gFontSystemSize(15);
    nameLable3.text          = @"关注";
    [self.view addSubview:nameLable3];
    
    CGFloat left3 = nameLable3.right + 25;
    CGFloat top3  = nameLable3.top - 7;
    for (int i = 0; i < _careList.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(left3, top3, width, height);
        btn.layer.borderColor = kLineGrayColor.CGColor;
        btn.layer.borderWidth = 0.5;
        [btn setTitle:[_careList objectAtIndexSafe:i] forState:UIControlStateNormal];
        [btn setTitleColor:kLBBlackColor forState:UIControlStateNormal];
        btn.titleLabel.font = gFontSystemSize(15);
        [btn setTitle:[_careList objectAtIndexSafe:i] forState:UIControlStateSelected];
        [btn setTitleColor:kAppNormalBgColor forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(clickCollectionBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        left3 += width + 5;
        if (i == 2) {
            top3 += height + 8;
            left3 = nameLable3.right + 25;
        }
    }
    
    UILabel *nameLable4 = [[UILabel alloc ] initWithFrame:CGRectMake((kKeyWindow.width - 280)/2, nameLable3.bottom + 70, 55, 20)];
    nameLable4.textAlignment = NSTextAlignmentCenter;
    nameLable4.textColor     = kBBlackColor;
    nameLable4.font          = gFontSystemSize(15);
    nameLable4.text          = @"年龄";
    [self.view addSubview:nameLable4];
    
    MCTextField *ageText = [[MCTextField alloc] initWithFrame:CGRectMake(nameLable4.right + 25, nameLable4.top - 8, 200, 38)];
    [self.view addSubview:ageText];
    
    _completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _completeBtn.frame = CGRectMake((kKeyWindow.width - 180)/2, kKeyWindow.height - 110, 180, 40);
    _completeBtn.layer.borderColor = kAppNormalBgColor.CGColor;
    _completeBtn.layer.borderWidth = 0.5;
    _completeBtn.layer.cornerRadius = 3.5;
    _completeBtn.clipsToBounds      = YES;
    [_completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [_completeBtn setTitleColor:kAppNormalBgColor forState:UIControlStateNormal];
    _completeBtn.titleLabel.font = gFontSystemSize(15);
    [_completeBtn addTarget:self action:@selector(clickCompleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_completeBtn];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapVCViewGesture:)]];
}

- (void)tapVCViewGesture:(UITapGestureRecognizer *)gesture
{
    [self.view endEditing:YES];
}

#pragma mark - UIButton Actions
- (void)clickCompleteBtn:(id)sender
{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickPositionBtn:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
}

- (void)clickUserSexBtn:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
}

- (void)clickCollectionBtn:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
}

@end
