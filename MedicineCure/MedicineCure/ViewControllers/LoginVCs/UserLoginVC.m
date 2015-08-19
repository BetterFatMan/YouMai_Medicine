//
//  UserLoginVC.m
//  MedicineCure
//
//  Created by line0 on 15/8/1.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "UserLoginVC.h"
#import "UserRegisterVC.h"
#import "UserFillInInfoVC.h"
#import "UpdatePassWordVC.h"

#import "MCTextField.h"
#import "MCWordText.h"

#import "DES3Util.h"
#import "RegularExpression.h"
#import "UserDataControl.h"

@interface UserLoginVC ()<UITextFieldDelegate>
{
    UIImageView *_backImage;
    UIView      *_loginView;
    MCWordText *_nameText;
    MCWordText *_passWord;
    
    UserDataControl *_userDataControl;
}

@end

@implementation UserLoginVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _userDataControl = [UserDataControl new];
    }
    return self;
}

- (void)dealloc
{
    [_userDataControl cancelOperation];
    _userDataControl = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"登录";
    
    [self addAllViewsSub];
}

#pragma mark - SubViews
- (void)addAllViewsSub
{
    [self addNaviBars];
    
    
    UIImage *image = [UIImage imageNamed:@"login_back.jpg"];
    _backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navView.bottom, kKeyWindow.width, 350*kKeyWindow.width/320)];
    _backImage.backgroundColor = kAppBgColor;
    _backImage.image = image;
    [self.view addSubview:_backImage];
    
    _loginView = [self createLoginView];
    [self.view addSubview:_loginView];
    
}

- (UIView *)createLoginView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kKeyWindow.height - 260, kKeyWindow.width, 260)];
    bgView.backgroundColor = [UIColor whiteColor];
    
    _nameText = [[MCWordText alloc] initWithFrame:CGRectMake(35, 15, kKeyWindow.width - 150, 38)];
    _nameText.nameImage.image = UIImageByName(@"icon_user");
    _nameText.wordTextField.placeholder   = @"用户名";
    _nameText.wordTextField.delegate      = self;
    [bgView addSubview:_nameText];
    
    _passWord = [[MCWordText alloc] initWithFrame:CGRectMake(_nameText.left, _nameText.bottom + 15, _nameText.width, 38)];
    _passWord.nameImage.image  = UIImageByName(@"icon_pw");
    _passWord.wordTextField.placeholder   = @"密码";
    _passWord.wordTextField.secureTextEntry = YES;
    _passWord.wordTextField.delegate      = self;
    [bgView addSubview:_passWord];
    
    UIButton *newUserBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    newUserBtn.frame = CGRectMake(_nameText.right + 9, _nameText.top + 3, 75, 40);
    [newUserBtn setTitle:@"新用户" forState:UIControlStateNormal];
    [newUserBtn setTitleColor:kYMLoginRedColor forState:UIControlStateNormal];
    newUserBtn.titleLabel.font = gFontSystemSize(15);
    [newUserBtn addTarget:self action:@selector(createNewUser:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:newUserBtn];
    
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetBtn.frame = CGRectMake(_passWord.right + 9, _passWord.top + 3, 75, 40);
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:kYMLoginRedColor forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = gFontSystemSize(15);
    [forgetBtn addTarget:self action:@selector(forGetUserPassWord:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:forgetBtn];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(15, _passWord.bottom + 25, kKeyWindow.width - 30, 45);
    loginBtn.backgroundColor    = kYMLightRedColor;
    loginBtn.layer.cornerRadius = 3.5;
    loginBtn.clipsToBounds      = YES;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = gBoldFontSysSize(18);
    [loginBtn addTarget:self action:@selector(userLoginNormal:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:loginBtn];
    
    UIButton *weixinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    weixinBtn.frame = CGRectMake(loginBtn.left, loginBtn.bottom + 19, loginBtn.width, 45);
//    weixinBtn.layer.borderColor = kAppNormalBgColor.CGColor;
//    weixinBtn.layer.borderWidth = 0.5;
//    weixinBtn.layer.cornerRadius = 3.5;
//    weixinBtn.clipsToBounds      = YES;
    [weixinBtn setImage:UIImageByName(@"weixin_login") forState:UIControlStateNormal];
//    [weixinBtn setTitle:@"使用微信账号授权登录" forState:UIControlStateNormal];
//    [weixinBtn setTitleColor:kLBBlackColor forState:UIControlStateNormal];
//    weixinBtn.titleLabel.font = gFontSystemSize(15);
    [weixinBtn addTarget:self action:@selector(userLoginWithWeiXin:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:weixinBtn];
    
    return bgView;
}

- (void)addNaviBars
{
    UIButton *leftBtn        = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame            = CGRectMake(0, 20, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(clickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapVCViewGesture:)]];
}

#pragma mark - UIButton Actions
- (void)clickLeftBtn:(id)sender
{
    if (![UserDefaultControl shareInstance].cacheLoginedUserEntity)
    {
        return;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)userLoginNormal:(id)sender
{
    [self tapVCViewGesture:nil];
    UIButton *btn = (UIButton *)sender;
//    btn.enabled = NO;
    NSString *username = _nameText.wordTextField.text;
    NSString *password = _passWord.wordTextField.text;
    if (![RegularExpression isMobileNumber:username])
    {
        mAlertView(@"提示", @"您输入的用户名不合法\n请重新输入");
        btn.enabled = YES;
        return;
    }
    else if (![RegularExpression isValidatePassword:password])
    {
        mAlertView(@"提示", @"请确认密码为6－16位，并且只含字符、数字和下划线！");
        btn.enabled = YES;
        return;
    }
    
    [self requestLogin:@{@"mobile": username, @"password" : [DES3Util encrypt:password]}];
}

- (void)userLoginWithWeiXin:(id)sender
{
    mAlertView(@"提示", @"暂未申请企业微信ID");
}

- (void)createNewUser:(id)sender
{
    [self.navigationController pushViewController:[UserRegisterVC new] animated:YES];
}

- (void)forGetUserPassWord:(id)sender
{
    [self.navigationController pushViewController:[UpdatePassWordVC new] animated:YES];
}

- (void)tapVCViewGesture:(UITapGestureRecognizer *)gesture
{
    [self inforViewEndAnimation];
    [self.view endEditing:YES];
}

#pragma mark - Requests
- (void)requestLogin:(NSDictionary *)params
{
    [[LWaittingView sharedInstance] showWaittingView];
    __weak typeof(self) _wself = self;
    [_userDataControl userLogin:params withCompleteBlock:^(BOOL isSuccess, UserEntity *entity, NSError *error) {
        [[LWaittingView sharedInstance] hideWaittingView];
        if (isSuccess)
        {
            [UserDefaultControl shareInstance].cacheLoginedUserEntity = entity;
            
            [_wself clickLeftBtn:nil];
        }
        else
        {
            mAlertView(@"提示", error.errMsg);
        }
    }];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self inforViewBeginAnimation];
    return YES;
}

    ////======================////
- (void)inforViewBeginAnimation
{
    if (_loginView.top == kKeyWindow.height - 260) {
        [UIView animateWithDuration:0.35 animations:^{
            _loginView.top -= 256;
        }];
    }
}

- (void)inforViewEndAnimation
{
    if (_loginView.top != kKeyWindow.height - 260) {
        [UIView animateWithDuration:0.35 animations:^{
            _loginView.top += 256;
        }];
    }
}

@end
