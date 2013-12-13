//
//  ContactActionController.m
//  eab20
//
//  Created by zppro on 13-12-12.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import "ContactActionController.h"

@interface ContactActionController ()

@end

@implementation ContactActionController

- (void)dealloc {
    [super dealloc];
}

- (void)loadView{
    [super loadView]; 
    self.view.backgroundColor = [UIColor colorWithPatternImage:MF_PngOfDefaultSkin(@"contact-action-bg.png")];
}

@end
