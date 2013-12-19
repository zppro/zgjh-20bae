//
//  AppBaseController.m
//  iWedding
//
//  Created by 钟 平 on 12-7-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppBaseController.h"

@interface AppBaseController ()

@end

@implementation AppBaseController

- (void)dealloc {
    [super dealloc];
}

- (void)viewDidLoad{

    self.waitView = [[[MBProgressHUD alloc] init] autorelease];
    [self.waitView setFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    self.waitView.delegate = self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return FALSE;
}


- (void)showWaitView {
    [self showWaitViewWithTitle:@"" andCloseDelay:0 withAnimation:YES];
}

- (void)showWaitViewWithTitle:(NSString *)title {
    [self showWaitViewWithTitle:title andCloseDelay:0 withAnimation:YES];
}

- (void)showWaitViewWithTitle:(NSString *)title withAnimation:(BOOL) animated {
    [self showWaitViewWithTitle:title andCloseDelay:0 withAnimation:animated];
}

- (void)showWaitViewWithTitle:(NSString *)title andCloseDelay:(double) delayInSeconds {
    [self showWaitViewWithTitle:title andCloseDelay:delayInSeconds withAnimation:YES];
}

- (void)showWaitViewWithTitle:(NSString *)title andCloseDelay:(double) delayInSeconds withAnimation:(BOOL) animated {
    self.waitView.labelText = title;
    [self.view addSubview:self.waitView];
    [self.view bringSubviewToFront:self.waitView];
    [self.waitView show:animated];
    if(delayInSeconds > 0){
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if (self.waitView) {
                [self.waitView hide:YES];
            }
        });
    }
}


- (void)updateWaitViewWithTitle:(NSString *)title {
    self.waitView.labelText = title;
}

- (void)closeWaitView {
    if (self.waitView) {
        [self.waitView hide:YES];
    }
}

@end
