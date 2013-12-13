//
//  ActionSideBarController.m
//  eab20
//
//  Created by zppro on 13-12-12.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import "ActionSideBarController.h"

@interface ActionSideBarController ()

@end

@implementation ActionSideBarController
- (void)dealloc { 
    [super dealloc];
}

- (void)loadView{
    [super loadView];
    self.view.width = ActionSideBarWidth;
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
