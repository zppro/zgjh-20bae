//
//  ContactDetailView.h
//  eab20
//
//  Created by zppro on 13-12-29.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import "BaseView.h"
@class CContactInfo;

@interface ContactDetailView : BaseView<UITableViewDataSource, UITableViewDelegate>

- (id)initWithFrame:(CGRect)frame andData:(CContactInfo*) dataItem;

@end
