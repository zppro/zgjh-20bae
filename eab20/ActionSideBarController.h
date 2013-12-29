//
//  ActionSideBarController.h
//  eab20
//
//  Created by zppro on 13-12-12.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ActionSideBarWidthForShow 50

@protocol ActionSideBarDelegate<NSObject>

- (void)clickSearchBtn;

- (void)beginSync:(NSString*) title;

- (void)updateSync:(NSString*) title;

- (void)endSync;

@end

@interface ActionSideBarController : AppBaseController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) id<ActionSideBarDelegate>   delegate;
- (void) doSyncFirst;
@end
