//
//  HomeController.h
//  eab20
//
//  Created by zppro on 13-12-11.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import "AppBaseController.h"
#import "DirectorySideBarController.h"
#import "ActionSideBarController.h"
 

@interface HomeController : AppBaseController<UIScrollViewDelegate,UITableViewDataSource, UITableViewDelegate,MWFSlideNavigationViewControllerDelegate, MWFSlideNavigationViewControllerDataSource,RNGridMenuDelegate,
    DirectorySideBarDelegate,ActionSideBarDelegate,CInputAssistViewDelgate>


@property (nonatomic, retain) DirectorySideBarController * dsbCtl;
@property (nonatomic, retain) ActionSideBarController * asbCtl;

@end
