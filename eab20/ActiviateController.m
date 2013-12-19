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
    _mobileField.textField.text= @"18668001381";
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
    _mobileConfirmField.textField.text= @"18668001381";
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
    
    UIButton *btnActiviate = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnActiviate setFrame:CGRectMake((self.view.width-548/2.f)/2.f,150.f,548/2.f, 82/2.f)];
    [btnActiviate setBackgroundImage:MF_PngOfDefaultSkin(@"btnActiviate.png") forState:UIControlStateNormal];
    [btnActiviate addTarget:self action:@selector(doActiviate:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnActiviate];
    
    UIButton *btnQuit = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnQuit setFrame:CGRectMake((self.view.width-548/2.f)/2.f,210.f,548/2.f, 82/2.f)];
    [btnQuit setBackgroundImage:MF_PngOfDefaultSkin(@"btnQuit.png") forState:UIControlStateNormal];
    [btnQuit addTarget:self action:@selector(doQuit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnQuit];
}

- (void)doActiviate:(id)sender{
    [self.mobileField.textField resignFirstResponder];
    [self.mobileConfirmField.textField resignFirstResponder];
    [self showWaitViewWithTitle:@"激活中..."];
    NSString *key = [moDevice.udid substringToIndex:8];
    
    appSession.du = [moDevice.udid reverseString];
    appSession.sdn = [e0571DES base64EncodeString:JOIN2(self.mobileField.textField.text,@"|",moDevice.udid) Key:key];
    savS(APP_SETTING_AUTH_DU_KEY, appSession.du);
    savS(APP_SETTING_AUTH_SDN_KEY, appSession.sdn);
    
    NSDictionary *body = [NSDictionary dictionaryWithObjectsAndKeys:self.mobileField.textField.text,@"MobileNo",appSession.du,@"DU",appSession.sdn,@"SDN",nil];
    HttpAppRequest *req = buildReq(body);
     
    [HttpAppAsynchronous httpPostWithUrl:[appSession getActiviateUrl] req:req sucessBlock:^(id result) {
        //DebugLog(@"ret:%@",((HttpAppResponse*)result).ret);
        NSDictionary *dict = ((HttpAppResponse*)result).ret;
        appSession.mobile = self.mobileField.textField.text;
        appSession.contactId = [dict objectForKey:@"ContactId"];
        appSession.contactName = [dict objectForKey:@"ContactName"];
        
        savB(APP_SETTING_IS_ACTIVIATED_KEY, TRUE);
        savS(APP_SETTING_ACTIVIATED_MOBILE_KEY, appSession.mobile);
        savS(APP_SETTING_ACTIVIATED_CONTACT_ID_KEY, appSession.contactId);
        savS(APP_SETTING_ACTIVIATED_CONTACT_NAME_KEY, appSession.contactName);
        
        [self updateWaitViewWithTitle:@"登录中..."];
        //自动登录
        NSDictionary *body2 = [NSDictionary dictionaryWithObjectsAndKeys: (isDebug?NI(1):NI(0)),@"RunMode",appId,@"ApplicationIdFrom",invokeToAppId,@"ApplicationIdTo",appSession.du,@"DU",appSession.sdn,@"SDN",nil];
        HttpAppRequest *req2 = buildReq(body2);
        [HttpAppAsynchronous httpPostWithUrl:[appSession getAuthUrl:AIT_Contact] req:req2 sucessBlock:^(id result) {
            DebugLog(@"ret:%@",((HttpAppResponse*)result).ret);
            NSDictionary *dict = ((HttpAppResponse*)result).ret;
            appSession.token = [dict objectForKey:@"Token"];
            appSession.apiUrl = [e0571DES base64DecodeString:[dict objectForKey:@"RedirectUrl"] Key:key];
            
            savS(APP_SETTING_AUTH_TOKEN_KEY, appSession.token);
            savS(APP_SETTING_API_URL_KEY, appSession.apiUrl);
            
            //自动登录
            
            [self dismissModalViewControllerAnimated:YES];
            
        } failedBlock:^(NSError *error) {
            //
            DebugLog(@"%@",error);
        } completionBlock:^{
            [self closeWaitView];
        }];
        
        
    } failedBlock:^(NSError *error) {
        //
        DebugLog(@"%@",error);
    } completionBlock:^{
        [self closeWaitView];
    }];

}

- (void)doQuit:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - BZGFormFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

@end
