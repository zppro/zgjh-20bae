//
//  CDirectoryInfo.h
//  eab20
//
//  Created by zppro on 13-12-17.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CDirectoryInfo : BaseModel

@property (nonatomic, retain) NSString * directoryId;
@property (nonatomic, retain) NSString * directoryName;
@property (nonatomic, retain) NSString * directoryPath;
@property (nonatomic, retain) NSString * parentId;
@property (nonatomic, retain) NSNumber * computeLevels;
@property (nonatomic, retain) NSNumber * orderNo;

+ (NSArray *)listDirectoryAsRoot;
+ (NSArray *)listDirectoryByLevels:(NSUInteger) level andParent:(NSString*) parentId;
+ (BOOL)updateAll:(NSArray *)data;
@end
