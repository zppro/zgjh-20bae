//
//  DirectorySideBarController.m
//  eab20
//
//  Created by zppro on 13-12-12.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import "DirectorySideBarController.h"

@interface DirectorySideBarController ()

@end

@implementation DirectorySideBarController

- (void)dealloc {
    [super dealloc];
}

- (void)loadView{
    [super loadView];
    self.view.width = DirectorySideBarWidth;
    self.view.backgroundColor = [UIColor whiteColor];
    
}

 

@end
