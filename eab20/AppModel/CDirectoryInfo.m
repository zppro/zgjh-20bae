//
//  CDirectoryInfo.m
//  eab20
//
//  Created by zppro on 13-12-17.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import "CDirectoryInfo.h"


@implementation CDirectoryInfo
@dynamic dPK;
@dynamic directoryId;
@dynamic directoryName;
@dynamic directoryPath;
@dynamic parentId;
@dynamic computeLevels;
@dynamic orderNo;
@synthesize children = _children;

- (void)dealloc {
    [_children release];
    [super dealloc];
}

+ (NSString*) localEntityKey{
    return @"dPK";
}
+ (NSString*) dataSourceKey{
    return @"DPK";
}

- (NSDictionary *)elementToPropertMappings
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"dPK", @"DPK",
            @"directoryId", @"DirectoryId",
            @"directoryName", @"DirectoryName",
            @"directoryPath", @"DirectoryPath",
            @"parentId", @"ParentId",
            @"computeLevels", @"ComputeLevels",
            @"orderNo", @"OrderNo",
            nil];
}


+ (NSArray *)listDirectoryAsRoot{
    return [CDirectoryInfo listDirectoryByLevels:1 andParent:nil];
}

+ (NSArray *)listDirectoryByLevels:(NSUInteger) level andParent:(NSString*) parentId{
    DKPredicateBuilder *builder = [[[DKPredicateBuilder alloc] init] autorelease];
    [builder where:@"computeLevels" equals:NI((int)level)];
    if ([parentId length]>0) {
        [builder where:@"parentId" equals:parentId];
    } 
    return [CDirectoryInfo fetchWithSortBy:@"orderNo" ascending:YES predicateWithFormat:builder.compoundPredicate.predicateFormat];
}

+ (CDirectoryInfo*) loadAsStaff:(NSString*) directoryId{
    DKPredicateBuilder *builder = [[[DKPredicateBuilder alloc] init] autorelease];
    [builder where:@"dPK" equals:JOIN(@"0-", directoryId)];
    NSArray * temp = [CDirectoryInfo fetchWithPredicateFormat:builder.compoundPredicate.predicateFormat];
    return [temp firstObject];
    /*
    if([temp count] ==1){
        return [temp firstObject];
    }
    */
}

+ (BOOL)updateAll:(NSArray *)data{
    return [CDirectoryInfo updateWithData:data EntityKey:[CDirectoryInfo localEntityKey] IEntityKey:[CDirectoryInfo dataSourceKey]];
}

- (NSArray*) children{
    if(_children == nil){
        NSString *parentId = nil;
        if([self.directoryId isEqualToString:@"DLine"] ||[self.directoryId isEqualToString:@"DLine"]){
            parentId = self.directoryId;
        }
        else{
            parentId = [self.directoryId uppercaseString];
        }
        _children = [CDirectoryInfo listDirectoryByLevels: [self.computeLevels intValue]+1 andParent:parentId];
    }
    return [_children retain];
}

@end
