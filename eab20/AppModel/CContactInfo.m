//
//  CContactInfo.m
//  eab20
//
//  Created by zppro on 13-12-17.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import "CContactInfo.h"


@implementation CContactInfo

@dynamic contactId;
@dynamic contactCode;
@dynamic uAAPNo;
@dynamic contactName;
@dynamic aliasName;
@dynamic title;
@dynamic doorNo;
@dynamic dTel;
@dynamic dTelShort;
@dynamic mobile;
@dynamic mobileShort;
@dynamic remark;
@dynamic inputCode1;
@dynamic inputCode2;
@dynamic directoryPath;
@dynamic directoryLevels;
@dynamic directoryOrderNo;
@dynamic contactOrderNo;
@dynamic updateSourceType;

+ (NSString*) localEntityKey{
    return @"contactId";
}
+ (NSString*) dataSourceKey{
    return @"ContactId";
}

- (NSDictionary *)elementToPropertMappings
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"contactId", @"ContactId",
            @"contactCode", @"ContactCode",
            @"uAAPNo", @"UAAPNo",
            @"contactName", @"ContactName",
            @"aliasName", @"AliasName",
            @"title", @"Title",
            @"doorNo", @"DoorNo",
            @"dTel", @"DTel",
            @"dTelShort", @"DTelShort",
            @"mobile", @"Mobile",
            @"mobileShort", @"MobileShort",
            @"remark", @"Remark",
            @"inputCode1", @"InputCode1",
            @"inputCode2", @"InputCode2",
            @"directoryPath", @"DirectoryPath",
            @"directoryLevels", @"DirectoryLevels",
            @"directoryOrderNo", @"DirectoryOrderNo",
            @"contactOrderNo", @"ContactOrderNo",
            @"updateSourceType", @"UpdateSourceType",
            nil];
}

+ (NSArray *)listContactByDirectoryPath:(NSString*) directoryPath{
    NSArray* sorts = [NSArray arrayWithObjects:
                      [NSSortDescriptor sortDescriptorWithKey:@"directoryLevels" ascending:YES],
                      [NSSortDescriptor sortDescriptorWithKey:@"directoryOrderNo" ascending:YES],
                      [NSSortDescriptor sortDescriptorWithKey:@"contactOrderNo" ascending:YES],
                      nil];
    if(directoryPath == nil){
        return [CContactInfo fetchAllSortWith:sorts];
    }
    else{
        DKPredicateBuilder *builder = [[[DKPredicateBuilder alloc] init] autorelease];
        [builder where:@"directoryPath" like:directoryPath];
        return [CContactInfo fetchWithSort:sorts predicateWithFormat:builder.compoundPredicate.predicateFormat];
    }
}

+ (BOOL)updateWithData:(NSArray *)data ByType:(UpdateSourceType) type{
    DKPredicateBuilder *builder = [[[DKPredicateBuilder alloc] init] autorelease];
    [builder where:@"updateSourceType" equals:NI(type)];
    return [CContactInfo updateWithData:data EntityKey:[CContactInfo localEntityKey] IEntityKey:[CContactInfo dataSourceKey] fethchFormat:builder.compoundPredicate.predicateFormat];
}

@end
