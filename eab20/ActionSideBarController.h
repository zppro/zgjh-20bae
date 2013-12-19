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

@end

@interface ActionSideBarController : AppBaseController
@property (nonatomic, assign) id<ActionSideBarDelegate>   delegate;
@end
