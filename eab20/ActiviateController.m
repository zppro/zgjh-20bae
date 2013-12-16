//
//  ActiviateController.m
//  eab20
//
//  Created by zppro on 13-12-16.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import "ActiviateController.h"

@interface ActiviateController ()
@property (retain, nonatomic) BZGFormField *mobileField;
@property (retain, nonatomic) BZGFormField *mobileConfirmField;
@end

@implementation ActiviateController
@synthesize mobileField = _mobileField;
@synthesize mobileConfirmField = _mobileConfirmField;


- (void)dealloc {
    [_mobileField release];
    [_mobileConfirmField release];
    [super dealloc];
}

- (void)loadView
{
    [super loadView];
    [self.navigationController setNavigationBarHidden:YES];
    
    //判断硬件设备
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"Default@2x.png"]];
    
    _mobileField = [[BZGFormField alloc] initWithFrame:CGRectMake((self.view.width - 200)/2.f, 50.f, 200.f, 38.f)];
    _mobileField.textField.font = [UIFont systemFontOfSize:18];
    _mobileField.textField.keyboardType = UIKeyboardTypeNumberPad;
    _mobileField.textField.keyboardAppearance = UIKeyboardAppearanceDefault;
    _mobileField.textField.backgroundColor = [UIColor whiteColor];
    _mobileField.textField.placeholder = @"请输入手机号码";
    _mobileField.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_mobileField setTextValidationBlock:^BOOL(NSString *text) {
        NSString *mobileRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
        NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileRegex];
        if (![mobileTest evaluateWithObject:text]) {
            self.mobileField.alertView.title = @"无效的手机号码，请重新输入";
            return NO;
        } else {
            return YES;
        }
    }];
    _mobileField.delegate = self;
    [self.view addSubview:_mobileField];
    
    _mobileConfirmField = [[BZGFormField alloc] initWithFrame:CGRectMake((self.view.width - 200)/2.f, 100.f, 200.f, 38.f)];
    _mobileConfirmField.textField.font = [UIFont systemFontOfSize:18];
    _mobileConfirmField.textField.keyboardType = UIKeyboardTypeNumberPad;
    _mobileConfirmField.textField.keyboardAppearance = UIKeyboardAppearanceDefault;
    _mobileConfirmField.textField.backgroundColor = [UIColor whiteColor];
    _mobileConfirmField.textField.placeholder = @"再次输入手机号码";
    _mobileConfirmField.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_mobileConfirmField setTextValidationBlock:^BOOL(NSString *text) {
        NSString *mobileRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
        NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileRegex];
        if (![mobileTest evaluateWithObject:text]) {
            self.mobileConfirmField.alertView.title = @"无效的手机号码，请重新输入";
            return NO;
        } else {
            if([self.mobileField.textField.text isEqualToString:  self.mobileConfirmField.textField.text]){
                self.mobileConfirmField.alertView.title = @"两次输入手机号码不一致";
                return NO;
            }
            return YES;
        }
    }];
    _mobileConfirmField.delegate = self;
    [self.view addSubview:_mobileConfirmField];
    
    UIButton *btnLogout = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLogout setFrame:CGRectMake((self.view.width-548/2.f)/2.f,200.f,548/2.f, 82/2.f)];
    //[btnLogout setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [btnLogout setBackgroundImage:MF_PngOfDefaultSkin(@"btnActiviate.png") forState:UIControlStateNormal];
    [btnLogout addTarget:self action:@selector(doActiviate:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLogout];
    
}

- (void)doActiviate:(id)sender{
    
}

#pragma mark - BZGFormFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

@end
