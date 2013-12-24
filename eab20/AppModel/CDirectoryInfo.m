//
//  CDirectoryInfo.m
//  eab20
//
//  Created by zppro on 13-12-17.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import "CDirectoryInfo.h"


@implementation CDirectoryInfo

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
    return @"directoryId";
}
+ (NSString*) dataSourceKey{
    return @"DirectoryId";
}

- (NSDictionary *)elementToPropertMappings
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
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

+ (BOOL)updateAll:(NSArray *)data{
    return [CDirectoryInfo updateWithData:data EntityKey:[CDirectoryInfo localEntityKey] IEntityKey:[CDirectoryInfo dataSourceKey]];
}

- (NSArray*) children{
    if(_children == nil){
        
        _children = [CDirectoryInfo listDirectoryByLevels: [self.computeLevels intValue]+1 andParent:[self.directoryId uppercaseString]];
    }
    return [_children retain];
}

@end
