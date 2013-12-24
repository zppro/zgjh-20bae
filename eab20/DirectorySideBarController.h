//
//  DirectorySideBarController.h
//  eab20
//
//  Created by zppro on 13-12-12.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DirectorySideBarWidth 230

@protocol DirectorySideBarDelegate<NSObject>

- (void)filter:(id)filterInfo and:(BOOL) autoBack;

@end

@interface DirectorySideBarController : UIViewController
@property (nonatomic, assign) id<DirectorySideBarDelegate>   delegate;
@end
