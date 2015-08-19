//
//  UpdatePassWordVC.m
//  MedicineCure
//
//  Created by line0 on 15/8/1.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "UpdatePassWordVC.h"

#import "MCWordText.h"

#import "DES3Util.h"
#import "RegularExpression.h"

@interface UpdatePassWordVC ()<UITextFieldDelegate>
{
    UIView      *_updateView;
    
    MCWordText  *_phoneText;
    MCWordText  *_yanzhengText;///验证码
    MCWordText  *_passwordText;///密码
    MCWordText  *_sureMimaText;
    UIButton    *_registerBtn;
    UIButton    *_getYzhmaBtn;
    
    NSTimer     *_registerTimer;
    NSInteger    _time;
}
@end

@implementation UpdatePassWordVC

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
    self.title = @"忘记密码";
    
    [self addAllViewsSub];
}

#pragma mark - SubViews
- (void)addAllViewsSub
{
    _updateView = [self createLoginView];
    [self.view addSubview:_updateView];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapVCViewGesture:)]];
}

- (UIView *)createLoginView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.bottom, kKeyWindow.width, 260)];
    bgView.backgroundColor = [UIColor whiteColor];
    
    _phoneText = [[MCWordText alloc] initWithFrame:CGRectMake((kKeyWindow.width - 240)/2, 10, 200, 30)];
//    _phoneText.nameLable.text = @"手机号";
    _phoneText.wordTextField.keyboardType = UIKeyboardTypePhonePad;
    _phoneText.wordTextField.delegate = self;
    [bgView addSubview:_phoneText];
    
        /// 获取验证码
    _getYzhmaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _getYzhmaBtn.frame = CGRectMake(_phoneText.right + 5, _phoneText.top, 80, 30);
    _getYzhmaBtn.layer.borderColor = kAppNormalBgColor.CGColor;
    _getYzhmaBtn.layer.borderWidth = 0.5;
    _getYzhmaBtn.layer.cornerRadius = 2.5;
    _getYzhmaBtn.clipsToBounds      = YES;
    [_getYzhmaBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getYzhmaBtn setTitleColor:kAppNormalBgColor forState:UIControlStateNormal];
    _getYzhmaBtn.titleLabel.font = gFontSystemSize(13);
    _getYzhmaBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [_getYzhmaBtn addTarget:self action:@selector(clickGetYanzhengMaBtn:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:_getYzhmaBtn];
    
    _yanzhengText = [[MCWordText alloc] initWithFrame:CGRectMake(_phoneText.left, _phoneText.bottom + 9, _phoneText.width, _phoneText.height)];
//    _yanzhengText.nameLable.text = @"验证码";
    _yanzhengText.wordTextField.delegate = self;
    [bgView addSubview:_yanzhengText];
    
    _passwordText = [[MCWordText alloc] initWithFrame:CGRectMake(_phoneText.left, _yanzhengText.bottom + 9, _phoneText.width, _phoneText.height)];
//    _passwordText.nameLable.text = @"新密码";
    _passwordText.wordTextField.secureTextEntry = YES;
    _passwordText.wordTextField.delegate = self;
    [bgView addSubview:_passwordText];
    
    _sureMimaText = [[MCWordText alloc] initWithFrame:CGRectMake(_phoneText.left, _passwordText.bottom + 9, _phoneText.width, _phoneText.height)];
//    _sureMimaText.nameLable.text = @"确认密码";
    _sureMimaText.wordTextField.delegate = self;
    [bgView addSubview:_sureMimaText];
    
    _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _registerBtn.frame = CGRectMake((kKeyWindow.width - 180)/2, _sureMimaText.bottom + 26, 180, 40);
    _registerBtn.layer.borderColor = kAppNormalBgColor.CGColor;
    _registerBtn.layer.borderWidth = 0.5;
    _registerBtn.layer.cornerRadius = 3.5;
    _registerBtn.clipsToBounds      = YES;
    [_registerBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_registerBtn setTitleColor:kAppNormalBgColor forState:UIControlStateNormal];
    _registerBtn.titleLabel.font = gFontSystemSize(15);
    [_registerBtn addTarget:self action:@selector(clickRegisterBtn:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:_registerBtn];
    
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
    
    [self requestUpdatePassword:@{@"mobile": username, @"password" : [DES3Util encrypt:password]}];
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
- (void)requestUpdatePassword:(NSDictionary *)params
{
    [[LWaittingView sharedInstance] showWaittingView];
    __weak typeof(self) _wself = self;
    
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
//    if (_updateView.top == kKeyWindow.height - 260) {
//        [UIView animateWithDuration:0.35 animations:^{
//            _updateView.top -= 250;
//        }];
//    }
}

- (void)inforViewEndAnimation
{
//    if (_updateView.top != kKeyWindow.height - 260) {
//        [UIView animateWithDuration:0.35 animations:^{
//            _updateView.top += 250;
//        }];
//    }
}

@end
