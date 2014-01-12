//
//  AppSession.h
//  SmartLife
//
//  Created by zppro on 12-12-18.
//  Copyright (c) 2012年 zppro. All rights reserved.
//

#import <Foundation/Foundation.h>
#define appSession [AppSession sharedInstance]

typedef enum {
    AOT_None,
    AOT_User,
    AOT_Contact
}AuthenticationObjectType;


typedef enum {
    AIT_User,
    AIT_Contact
}AuthenticationInterfaceType;

typedef enum {
    BIT_SyncSelfInfo,
    BIT_SyncDirectory,
    BIT_SyncContact,
    BIT_SyncContactBySelf,
    BIT_SyncContactByDLine,
    BIT_SyncContactBySELine
}BizInterfaceType;

 

@class CCallService;

@interface AppSession : NSObject
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(AppSession);

@property (nonatomic) NetworkStatus networkStatus;

@property (nonatomic, retain) NSString *mobile;
@property (nonatomic, retain) NSString *contactId;
@property (nonatomic, retain) NSString *contactName;
@property (nonatomic, retain) NSString *mappingDirectoryId;
@property (nonatomic, retain) NSString *directoryIdOfLevel2;
@property (nonatomic, retain) NSString *directoryIdOfLevel3;
@property (nonatomic, assign) BOOL isSE;
@property (nonatomic, retain) NSString *contactProperty;
@property (nonatomic, retain) NSString *du;
@property (nonatomic, retain) NSString *sdn;
@property (nonatomic, retain) NSString *token;
@property (nonatomic, retain) NSString *apiUrl;
@property (nonatomic, retain) NSString *selectedDirectoryId;
+ (BOOL)whetherIsActiviated;
+ (BOOL)whetherIsAuthorized;
+ (BOOL)whetherIsDebug;
+ (BOOL)whetherIsSynced;

+ (void)readSettings;

+ (AuthenticationInterfaceType) whichAuthenticationInterfaceType;

- (NSString*) getActiviateUrl;

- (NSString*) getAuthUrl:(AuthenticationInterfaceType) aType;

- (NSString*) getBizUrl:(BizInterfaceType) aType; 
 

@end
