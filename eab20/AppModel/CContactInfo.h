//
//  CContactInfo.h
//  eab20
//
//  Created by zppro on 13-12-17.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef enum {
    UpdateSourceType_BySelf,
    UpdateSourceType_ByDLine,
    UpdateSourceType_BySELine
}UpdateSourceType;

@interface CContactInfo : BaseModel

@property (nonatomic, retain) NSString * contactId;
@property (nonatomic, retain) NSString * contactCode;
@property (nonatomic, retain) NSString * uAAPNo;
@property (nonatomic, retain) NSString * contactName;
@property (nonatomic, retain) NSString * aliasName;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * doorNo;
@property (nonatomic, retain) NSString * dTel;
@property (nonatomic, retain) NSString * dTelShort;
@property (nonatomic, retain) NSString * hTel;
@property (nonatomic, retain) NSString * eMail;
@property (nonatomic, retain) NSString * mobile;
@property (nonatomic, retain) NSString * mobileShort;
@property (nonatomic, retain) NSString * remark;
@property (nonatomic, retain) NSString * inputCode1;
@property (nonatomic, retain) NSString * inputCode2;
@property (nonatomic, retain) NSString * directoryPath;
@property (nonatomic, retain) NSNumber * directoryLevels;
@property (nonatomic, retain) NSNumber * directoryOrderNo;
@property (nonatomic, retain) NSNumber * contactOrderNo;
@property (nonatomic, retain) NSNumber * updateSourceType;


+ (NSArray *)listContactByDirectoryPath:(NSString*) directoryPath andKeyword:(NSString*) keyword;
+ (NSUInteger)countContactByDirectoryPath:(NSString*) directoryPath;
+ (NSArray *) loadByContactId:(NSString*) contactId;
+ (BOOL)updateWithData:(NSArray *)data ByType:(UpdateSourceType) type;

@end
