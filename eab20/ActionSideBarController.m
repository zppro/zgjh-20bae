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
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setFrame:CGRectMake((self.view.width - 48.f)/2.f,80.f, 48.f, 48.f)];
    [searchBtn setImage:MF_PngOfDefaultSkin(@"search.png") forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(doSearch:) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:searchBtn];
    
    UIButton *syncBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [syncBtn setFrame:CGRectMake((self.view.width - 48.f)/2.f,160.f, 48.f, 48.f)];
    [syncBtn setImage:MF_PngOfDefaultSkin(@"sync.png") forState:UIControlStateNormal];
    [syncBtn addTarget:self action:@selector(doSync:) forControlEvents:UIControlEventTouchUpInside];
    [syncBtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:syncBtn];
    
    UIButton *gearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [gearBtn setFrame:CGRectMake((self.view.width - 48.f)/2.f,240.f, 48.f, 48.f)];
    [gearBtn setImage:MF_PngOfDefaultSkin(@"gear.png") forState:UIControlStateNormal];
    [gearBtn addTarget:self action:@selector(doSettings:) forControlEvents:UIControlEventTouchUpInside];
    [gearBtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:gearBtn];
    
    UIButton *infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [infoBtn setFrame:CGRectMake((self.view.width - 48.f)/2.f,320.f, 48.f, 48.f)];
    [infoBtn setImage:MF_PngOfDefaultSkin(@"info-2.png") forState:UIControlStateNormal];
    [infoBtn addTarget:self action:@selector(doInfo:) forControlEvents:UIControlEventTouchUpInside];
    [infoBtn setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:infoBtn];
}

- (void) doSearch:(id) sender{
    
}

- (void) doSync:(id) sender{
    
}

- (void) doSettings:(id) sender{
    
}

- (void) doInfo:(id) sender{
    
}

@end
