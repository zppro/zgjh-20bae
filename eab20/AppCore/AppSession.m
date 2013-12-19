//
//  AppSession.m
//  SmartLife
//
//  Created by zppro on 12-12-18.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import "AppSession.h"
#import "AppSetting.h"

@implementation AppSession
SYNTHESIZE_LESSER_SINGLETON_FOR_CLASS(AppSession);
@synthesize networkStatus;
@synthesize mobile;
@synthesize contactId;
@synthesize contactName;
@synthesize du;
@synthesize sdn;
@synthesize token;
@synthesize apiUrl;


+ (BOOL)whetherIsActiviated {
    NSNumber *_isActiviated = AppSetting(APP_SETTING_IS_ACTIVIATED_KEY);
    if (_isActiviated) {
        return [_isActiviated boolValue];
    }
    return NO;
}

+ (BOOL)whetherIsAuthorized {
    NSString *_authToken = AppSetting(APP_SETTING_AUTH_TOKEN_KEY);
    if (_authToken!=nil) {
        return YES;
    }
    return NO;
}

+ (BOOL)whetherIsDebug {
    NSNumber *_isDebug = AppSetting(SETTING_DEBUG_KEY);
    if (_isDebug) {
        return [_isDebug boolValue];
    }
    return NO;
}

+ (void)readSettings{
    appSession.mobile = AppSetting(APP_SETTING_ACTIVIATED_MOBILE_KEY);
    appSession.contactId = AppSetting(APP_SETTING_ACTIVIATED_CONTACT_ID_KEY);
    appSession.contactName = AppSetting(APP_SETTING_ACTIVIATED_CONTACT_NAME_KEY);
    appSession.du = AppSetting(APP_SETTING_AUTH_DU_KEY);
    appSession.sdn = AppSetting(APP_SETTING_AUTH_SDN_KEY);
    appSession.token = AppSetting(APP_SETTING_AUTH_TOKEN_KEY);
    appSession.apiUrl = AppSetting(APP_SETTING_API_URL_KEY);
}

+ (AuthenticationInterfaceType) whichAuthenticationInterfaceType{
    AuthenticationInterfaceType type = [AppSetting(APP_SETTING_AUTHENENTICATION_INTERFACE_TYPE_KEY) intValue];
    return type;
}

- (NSString*) getActiviateUrl{
    NSString *_activiateUrl;
    NSString *baseActiviateUrl = isDebug ?  JOIN(debugSite, @"/EAB.Cert") :AppSetting(APP_SETTING_AUTH_BASE_URL_KEY);
    NSRange r = [baseActiviateUrl rangeOfString:@"http://"];
    if(r.length>0 && r.location==0){
        
    }
    else{
        baseActiviateUrl = JOIN(@"http://",baseActiviateUrl);
    }
    _activiateUrl = JOIN(baseActiviateUrl, @"/v2/Activiate/ActiviateMobile");
    return _activiateUrl;
}

- (NSString*) getAuthUrl:(AuthenticationInterfaceType) aType{
    NSString *_authUrl;
    NSString *baseAuthUrl = isDebug ?  JOIN(debugSite, @"/EAB.Cert") :AppSetting(APP_SETTING_AUTH_BASE_URL_KEY);
    NSRange r = [baseAuthUrl rangeOfString:@"http://"];
    if(r.length>0 && r.location==0){
        
    }
    else{
        baseAuthUrl = JOIN(@"http://",baseAuthUrl);
    }
    switch (aType) {
        case AIT_Contact:{
            _authUrl = JOIN(baseAuthUrl, @"/v2/IOS/AuthenticateContact");
            break;
        }
        default:
            _authUrl = baseAuthUrl;
        break;
    }
    return _authUrl;
}

- (NSString*) getBizUrl:(BizInterfaceType) aType{
    NSString *_bizUrl;
    NSString *baseBizUrl = isDebug ?  JOIN(debugSite, @"/EAB.API") :appSession.apiUrl;
    switch (aType) {
        case BIT_SyncDirectory:{
            _bizUrl = JOIN(baseBizUrl, @"/Sync/IOS/SyncDirectory");
            break;
        }
        case BIT_SyncContactBySelf:{
            _bizUrl = JOIN(baseBizUrl, @"/Sync/IOS/SyncContactBySelf");
            break;
        }
        case BIT_SyncContactByDLine:{
            _bizUrl = JOIN(baseBizUrl, @"/Sync/IOS/SyncContactByDLine");
            break;
        }
        case BIT_SyncContactBySELine:{
            _bizUrl = JOIN(baseBizUrl, @"/Sync/IOS/SyncContactBySELine");
            break;
        }
        default:
            _bizUrl = baseBizUrl;
            break;
    }
    return _bizUrl;
}
 

@end
