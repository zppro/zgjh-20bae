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
@synthesize authId;
@synthesize authName;
@synthesize authToken;
@synthesize authType;
@synthesize authNodeInfos; 

+ (BOOL)whetherIsActiviated {
    NSNumber *_isActiviated = AppSetting(APP_SETTING_IS_ACTIVIATED_KEY);
    if (_isActiviated) {
        return [_isActiviated boolValue];
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

- (NSString*) getBizUrl:(BizInterfaceType) aType withAccessPoint:(NSString*) accessPoint{
    NSString *_bizUrl;
    NSString *baseBizUrl = isDebug ?  JOIN(debugSite, @"/SmartLife.CertManage.MobileServices") :accessPoint;
    switch (aType) {
        case BIT_GetRelationNamesWithOldMan:{
            _bizUrl = JOIN(baseBizUrl, @"/Oca/FamilyMemberService.IPhone/GetRelationNamesWithOldMan");
            break;
        }
        case BIT_GetEmergencyServices:{
            _bizUrl = JOIN(baseBizUrl, @"/Oca/CallService.IPhone/GetEmergency");
            break;
        }
        case BIT_GetServiceLogs:{
            _bizUrl = JOIN(baseBizUrl, @"/Oca/CallService.IPhone/GetServiceLog");
            break;
        }
        case BIT_ResponseByFamilyMember:{
            _bizUrl = JOIN(baseBizUrl, @"/Oca/CallService.IPhone/ResponseByFamilyMember");
            break;
        }
        case BIT_LogByFamilyMember:{
            _bizUrl = JOIN(baseBizUrl, @"/Oca/CallService.IPhone/LogByFamilyMember");
            break;
        }
        case BIT_GetCallByOldMan:{
            _bizUrl = JOIN(baseBizUrl, @"/Oca/CallService.IPhone/GetCallByOldMan");
            break;
        }
        default:
            _bizUrl = baseBizUrl;
            break;
    }
    return _bizUrl;
}


- (NSInteger)getNWCode:(BizInterfaceType2) biz {
    NSInteger NWCode = -1;
    switch (biz) {
        case Login:{
            NWCode = 1;
            break;
        }
        case ReadListOfEmergencyService:
        {
            switch (authType) {
                case AOT_Contact:
                {
                    NWCode = 2;
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case ReadListOfCommunityService:
        {
            switch (authType) {
                case AOT_Contact:
                {
                    NWCode = 4;
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case ReadListOfLifeService:
        {
            switch (authType) {
                case AOT_Contact:
                {
                    NWCode = 3;
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case ReadListOfProcessing:
        {
            NWCode = 12;
            break;
        }
        case ReadListOfCamera:
        {
            NWCode = 5;
            break;
        }
        case DoResponse:
        {
            NWCode = 108;
            break;
        }
        case RegisterDevice:{
            NWCode = 101;
            break;
        }
        case SendServiceLog:{
            NWCode = 106;
            break;
        }
        default:
            break;
    }
    
    return NWCode;
}

- (void) abandon{
    self.authId = nil;
    self.authName = nil;
    self.authType = AOT_None;
}

@end
