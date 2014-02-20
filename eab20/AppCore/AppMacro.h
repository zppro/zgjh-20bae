//
//  AppMacro.h
//  SmartLife
//
//  Created by zppro on 12-12-18.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#ifndef SmartLife_AppMacro_h
#define SmartLife_AppMacro_h

#define debugSite @"http://192.168.1.7"

#define baseURL  @"http://www.lifeblue.com.cn/WebService/Default.ashx"
#define baseURL2 @"http://www.lifeblue.com.cn/WebService/Upload.ashx"
#define baseURL3 @"www.lifeblue.com.cn/WebService/Upload/CallService" 
#define intranetSite @"42.120.6.22:8891" //@"42.120.6.22:8891" @"34.0.191.202:8888"
#define appId @"MM101"
#define invokeToAppId @"IP002"

#define isActiviated [AppSession whetherIsActiviated]
#define isAuthorized [AppSession whetherIsAuthorized]
#define isSynced [AppSession whetherIsSynced]
#define isDebug [AppSession whetherIsDebug]
#define whichAIT [AppSession whichAuthenticationInterfaceType]
#define isShowPortrait [AppSession whetherIsShowPortrait]

#define authUrl(x) [appSession getAuthUrl:x]
#define bizUrl(x,y) [appSession getBizUrl:x withAccessPoint:y]
#define logContent(x,y,s,f,c) [appSession logText:x ToService:y sucessBlock:s failedBlock:f completionBlock:c]

#define buildReq(body) [AppRequestBuilder createWithHead:nil andBody:body]
#define buildReq2(head) [AppRequestBuilder createWithHead:head andBody:nil]
#define buildReq3(head,body) [AppRequestBuilder createWithHead:head andBody:body]

#define nwCode(x) [appSession getNWCode:x]
#define localSoundDir JOINP(MF_DocumentFolder(),@"sound")


#endif
