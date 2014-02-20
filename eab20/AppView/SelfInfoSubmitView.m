//
//  SelfInfoSubmitView.m
//  eab20
//
//  Created by zppro on 14-1-16.
//  Copyright (c) 2014年 zppro. All rights reserved.
//

#import "SelfInfoSubmitView.h"

@interface SelfInfoSubmitView ()
@property (nonatomic, retain) UITableView  *myTableView;
@end

@implementation SelfInfoSubmitView

- (void)dealloc {
    self.myTableView = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
