//
//  UserRegisterVC.m
//  MedicineCure
//
//  Created by line0 on 15/8/1.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "UserRegisterVC.h"
#import "UserFillInInfoVC.h"

#import "MCWordText.h"

#import "UserDataControl.h"
#import "DES3Util.h"
#import "RegularExpression.h"

@interface UserRegisterVC ()<UITextFieldDelegate>
{
    UIImageView *_backImage;
    UIView      *_registerView;
    
    MCWordText  *_phoneText;
//    MCWordText  *_shareText;///邀请码
    MCWordText  *_yanzhengText;///验证码
    MCWordText  *_passwordText;///密码
    UIButton    *_registerBtn;
    UIButton    *_getYzhmaBtn;
    
    NSTimer     *_registerTimer;
    NSInteger    _time;
    
    UserDataControl *_userDataControl;
}

@end

@implementation UserRegisterVC

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
    self.title = @"注册";
    
    [self addAllViewsSub];
}

#pragma mark - SubViews
- (void)addAllViewsSub
{
    _backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navView.bottom, kKeyWindow.width, 350*kKeyWindow.width/320)];
    _backImage.backgroundColor = kAppBgColor;
    _backImage.image = UIImageByName(@"login_back.jpg");
    [self.view addSubview:_backImage];
    
    _registerView = [self createLoginView];
    [self.view addSubview:_registerView];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapVCViewGesture:)]];
}

- (UIView *)createLoginView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kKeyWindow.height - 260, kKeyWindow.width, 260)];
    bgView.backgroundColor = [UIColor whiteColor];
    
    _phoneText = [[MCWordText alloc] initWithFrame:CGRectMake((kKeyWindow.width - 240)/2, 13, 240, 30)];
    _phoneText.nameImage.image = UIImageByName(@"icon_ph");
    _phoneText.wordTextField.keyboardType = UIKeyboardTypePhonePad;
    _phoneText.wordTextField.delegate = self;
    _phoneText.wordTextField.placeholder = @"您的手机号";
    [bgView addSubview:_phoneText];
    
        /// 获取验证码
    _getYzhmaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _getYzhmaBtn.frame = CGRectMake(15, _phoneText.bottom + 15, kKeyWindow.width - 30, 40);
    _getYzhmaBtn.backgroundColor    = kYMGreenColor;
    _getYzhmaBtn.layer.cornerRadius = 3.5;
    _getYzhmaBtn.clipsToBounds      = YES;
    [_getYzhmaBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getYzhmaBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _getYzhmaBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    _getYzhmaBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [_getYzhmaBtn addTarget:self action:@selector(clickGetYanzhengMaBtn:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:_getYzhmaBtn];
    
    _yanzhengText = [[MCWordText alloc] initWithFrame:CGRectMake(_phoneText.left, _getYzhmaBtn.bottom + 15, _phoneText.width, _phoneText.height)];
    _yanzhengText.nameImage.image = UIImageByName(@"icon_lk");
    _yanzhengText.wordTextField.delegate = self;
    _yanzhengText.wordTextField.placeholder = @"验证码";
    [bgView addSubview:_yanzhengText];
    
    _passwordText = [[MCWordText alloc] initWithFrame:CGRectMake(_phoneText.left, _yanzhengText.bottom + 13, _phoneText.width, _phoneText.height)];
    _passwordText.nameImage.image = UIImageByName(@"icon_pw");
    _passwordText.wordTextField.secureTextEntry = YES;
    _passwordText.wordTextField.delegate = self;
    _passwordText.wordTextField.placeholder = @"密码";
    [bgView addSubview:_passwordText];
    
    _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _registerBtn.frame = CGRectMake(_getYzhmaBtn.left, _passwordText.bottom + 15, _getYzhmaBtn.width, 40);
    _registerBtn.backgroundColor    = kYMLightRedColor;
    _registerBtn.layer.cornerRadius = 3.5;
    _registerBtn.clipsToBounds      = YES;
    [_registerBtn setTitle:@"完成注册" forState:UIControlStateNormal];
    [_registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _registerBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];;
    [_registerBtn addTarget:self action:@selector(clickRegisterBtn:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:_registerBtn];
    
//    bgView.height = _registerBtn.bottom + 10;
//    bgView.top    = kKeyWindow.height - bgView.height;
    return bgView;
}

- (void)tapVCViewGesture:(UITapGestureRecognizer *)gesture
{
    [self inforViewEndAnimation];
    [self.view endEditing:YES];
}

#pragma mark - UIButton Actions
- (void)clickRegisterBtn:(id)sender
{
    [self tapVCViewGesture:nil];
    
    UIButton *btn = (UIButton *)sender;
        //    btn.enabled = NO;
    NSString *username = _phoneText.wordTextField.text;
    NSString *password = _passwordText.wordTextField.text;
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
    
    [self requestRegister:@{@"mobile": username, @"password" : [DES3Util encrypt:password]}];
}

- (void)clickGetYanzhengMaBtn:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if (!_registerTimer) {
        _registerTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerChangeSecond:) userInfo:btn repeats:YES];
        btn.enabled = NO;
        
        _time = 60;
    }
}

- (void)timerChangeSecond:(id)sender
{
    if (_time > 1) {
        _time--;
        
        [_getYzhmaBtn setTitle:[NSString stringWithFormat:@"重新获取(%ld)", _time] forState:UIControlStateNormal];;
    } else {
        if ([_registerTimer isValid]) {
            [_registerTimer invalidate];
            _registerTimer = nil;
        }
        [_getYzhmaBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getYzhmaBtn.enabled = YES;
    }
}

#pragma mark - Requests
- (void)requestRegister:(NSDictionary *)params
{
    [[LWaittingView sharedInstance] showWaittingView];
    __weak typeof(self) _wself = self;
    [_userDataControl userRegister:params withCompleteBlock:^(BOOL isSuccess, UserEntity *entity, NSError *error) {
        [[LWaittingView sharedInstance] hideWaittingView];
        if (isSuccess)
        {
//            [UserDefaultControl shareInstance].cacheLoginedUserEntity = entity;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [_wself.navigationController pushViewController:[UserFillInInfoVC new] animated:YES];
            });
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
    if (_registerView.top == kKeyWindow.height - 260) {
        [UIView animateWithDuration:0.35 animations:^{
            _registerView.top -= 250;
        }];
    }
}

- (void)inforViewEndAnimation
{
    if (_registerView.top != kKeyWindow.height - 260) {
        [UIView animateWithDuration:0.35 animations:^{
            _registerView.top += 250;
        }];
    }
}

@end
