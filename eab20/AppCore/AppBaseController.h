//
//  AppBaseController.h
//  iWedding
//
//  Created by 钟 平 on 12-7-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AppBaseController : BaseController

- (void)showWaitView;
- (void)showWaitViewWithTitle:(NSString *)title;
- (void)showWaitViewWithTitle:(NSString *)title withAnimation:(BOOL) animated;
- (void)showWaitViewWithTitle:(NSString *)title andCloseDelay:(double) delayInSeconds;
- (void)showWaitViewWithTitle:(NSString *)title andCloseDelay:(double) delayInSeconds withAnimation:(BOOL) animated;
- (void)updateWaitViewWithTitle:(NSString *)title;
- (void)closeWaitView;

@end
