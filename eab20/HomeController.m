//
//  HomeController.m
//  eab20
//
//  Created by zppro on 13-12-11.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import "HomeController.h"
#import "ContactActionController.h"
#import "JSBadgeView.h"
#import "ActiviateController.h"
#import "CContactInfo.h"
#import "CDirectoryInfo.h"
#import "ContactDetailView.h"

#define kNumContactsPerLoad (IS_IPHONE5?20:16)
#define kViewBackgroundColor [UIColor colorWithRed:0.357 green:0.757 blue:0.357 alpha:1]
#define kSquareSideLength 64.0f
#define kSquareCornerRadius 10.0f
#define kMarginBetweenSquares 10.0f
#define kSquareColor [UIColor colorWithRed:0.004 green:0.349 blue:0.616 alpha:1]

@interface HomeController ()
@property (nonatomic, retain) NSArray      *arrContacts;
@property (nonatomic, retain) UITableView  *myTableView;
@property (nonatomic) NSUInteger clickRow;
@property (nonatomic) NSUInteger clickIndexAtRow;
@end

@implementation HomeController

@synthesize myTableView;
@synthesize arrContacts;
@synthesize dsbCtl;
@synthesize asbCtl;
@synthesize clickRow;
@synthesize clickIndexAtRow;

- (void)dealloc {
    self.myTableView = nil;
    self.arrContacts = nil;
    self.dsbCtl = nil;
    self.asbCtl = nil;
    [super dealloc];
}

- (void)loadView
{
    [super loadView];
    
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 62.0f)];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    [headView release];
    
    UILabel *headTitleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 22.f, self.view.width, 40.0f)];
    headTitleView.textColor = MF_ColorFromRGB(16, 69, 144);
    headTitleView.textAlignment = UITextAlignmentCenter;
    headTitleView.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];//[UIFont systemFontOfSize:16];//
    headTitleView.text = APP_DISPLAY_NAME;
    [headView addSubview:headTitleView];
    [headTitleView release];
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 62.0f, self.view.width,self.view.height-62.0f)];
    myTableView.backgroundColor = MF_ColorFromRGB(16, 69, 144);
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableView];
    [myTableView release];
    /*
    [self createContactIn:self.view];
    */
    self.slideNavigationViewController.delegate = self;
    self.slideNavigationViewController.dataSource = self;
    
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if(!isActiviated){
        ActiviateController *activiateController = [[[ActiviateController alloc] init] autorelease];
        [self presentModalViewController:activiateController animated: YES];
    }
    else if(!isAuthorized){
        [self showWaitViewWithTitle:@"登录中..."];
        NSDictionary *body = [NSDictionary dictionaryWithObjectsAndKeys: (isDebug?NI(1):NI(0)),@"RunMode",appId,@"ApplicationIdFrom",invokeToAppId,@"ApplicationIdTo",appSession.du,@"DU",appSession.sdn,@"SDN",nil];
        HttpAppRequest *req = buildReq(body);
        [HttpAppAsynchronous httpPostWithUrl:[appSession getAuthUrl:AIT_Contact] req:req sucessBlock:^(id result) {
            DebugLog(@"ret:%@",((HttpAppResponse*)result).ret);
            NSDictionary *dict = ((HttpAppResponse*)result).ret;
            appSession.token = [dict objectForKey:@"Token"];
            appSession.apiUrl = [e0571DES base64DecodeString:[dict objectForKey:@"RedirectUrl"] Key:[moDevice.udid substringToIndex:8]];
            
            savS(APP_SETTING_AUTH_TOKEN_KEY, appSession.token);
            savS(APP_SETTING_API_URL_KEY, appSession.apiUrl);
            //自动登录
            
            [self fetchDataLocalBy:nil and:nil];
            
        } failedBlock:^(NSError *error) {
            //
            DebugLog(@"%@",error);
        } completionBlock:^{
            [self closeWaitView];
        }];
    }
    else{
        [self fetchDataLocalBy:nil and:nil];
    }
}

- (void) createContactIn:(UIView *)parentView{
    //self.view.backgroundColor = kViewBackgroundColor;
    
    //UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    //scrollView.alwaysBounceHorizontal = YES;
    //[parentView addSubview:scrollView];
    //[scrollView release];
    
    CGFloat viewWidth = self.view.frame.size.width;
    
    NSUInteger numberOfSquaresPerRow = floor(viewWidth / (kSquareSideLength + kMarginBetweenSquares));
    const CGFloat kInitialXOffset = (viewWidth - (numberOfSquaresPerRow * kSquareSideLength)) / (float)numberOfSquaresPerRow;
    CGFloat xOffset = kInitialXOffset;
    
    const CGFloat kInitialYOffset = kInitialXOffset;
    CGFloat yOffset = kInitialYOffset;
    
    CGRect rectangleBounds = CGRectMake(0.0f,
                                        0.0f,
                                        kSquareSideLength,
                                        kSquareSideLength+16);
    
    
    CGPathRef rectangleShadowPath = [UIBezierPath bezierPathWithRoundedRect:rectangleBounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(kSquareCornerRadius, kSquareCornerRadius+16)].CGPath;
     
    
    
    for (int i = 0; i < kNumContactsPerLoad; i++)
    {
        
        UIButton *contactSquare = [[UIButton alloc] initWithFrame:CGRectIntegral(CGRectMake(xOffset,
                                                                                    yOffset,
                                                                                    rectangleBounds.size.width,
                                                                                            rectangleBounds.size.height))];
        
        contactSquare.tag = i;
        contactSquare.userInteractionEnabled = YES;
        //contactSquare.backgroundColor = kSquareColor;
        //contactSquare.layer.backgroundColor = myTableView.backgroundColor.CGColor;
        
        contactSquare.layer.cornerRadius = kSquareCornerRadius;
        contactSquare.layer.shadowColor = [UIColor blackColor].CGColor;
        contactSquare.layer.shadowOffset = CGSizeMake(0.0f, 3.0f);
        contactSquare.layer.shadowOpacity = 0.4;
        contactSquare.layer.shadowRadius = 1.0;
        contactSquare.layer.shadowPath = rectangleShadowPath;
        /**/
        
        //UIImageView *iv = makeImageViewByFrame(CGRectMake((kSquareSideLength-48.f)/2, 4, 48.f, 48.f));
        [contactSquare setImage:MF_PngOfDefaultSkin(@"head-portrait.png") forState:UIControlStateNormal];
        //contactSquare.imageView.frame = CGRectMake((kSquareSideLength-48.f)/2, 4, 48.f, 48.f);
        contactSquare.imageView.layer.borderWidth = 2;
        contactSquare.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        contactSquare.imageView.layer.cornerRadius = CGRectGetHeight(contactSquare.imageView.bounds) / 2;
        contactSquare.imageView.clipsToBounds = YES;
        contactSquare.backgroundColor = [UIColor clearColor];
        
        //[contactSquare setTitle:@"联系人" forState:UIControlStateNormal];
        //[contactSquare setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
        //contactSquare.titleLabel.font = [UIFont systemFontOfSize:10.0f];
        
        UILabel *nameView = [[UILabel alloc] initWithFrame:CGRectMake(3, kSquareSideLength+2, kSquareSideLength-2*3, 12.0f)];
        nameView.backgroundColor = [UIColor clearColor];
        nameView.font = [UIFont systemFontOfSize:10.0f];
        nameView.textAlignment = NSTextAlignmentCenter;
        nameView.textColor = [UIColor whiteColor];
        nameView.text=@"联系人";
        [contactSquare addSubview:nameView];
        [nameView release];
        
        /*
        UIImageView *iv = makeImageViewByFrame(CGRectMake((kSquareSideLength-48.f)/2, 4, 48.f, 48.f));
        iv.image = MF_PngOfDefaultSkin(@"head-portrait.png");
        [contactSquare addSubview:iv];
        iv.layer.borderWidth = 2;
        iv.layer.borderColor = [UIColor whiteColor].CGColor;
        iv.layer.cornerRadius = CGRectGetHeight(iv.bounds) / 2;
        iv.clipsToBounds = YES;
        */
        
        /*
        CALayer *layer = [CALayer layer];
        layer.contentsGravity = kCAGravityCenter;
        layer.contents = (id)[MF_PngOfDefaultSkin(@"head-portrait.png") CGImage];
        layer.frame = CGRectMake((kSquareSideLength-48.f)/2, 0, 48.f, 48.f);
        */
        
        //创建圆形遮罩，把用户头像变成圆形
        /*
        UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(24, 24) radius:24 startAngle:0 endAngle:2*M_PI clockwise:YES];
        CAShapeLayer* shape = [CAShapeLayer layer];
        shape.path = path.CGPath;
        iv.layer.mask = shape;
        */
        
        //[rectangle.layer addSublayer:layer];
        
        /*
        UIColor *background = [[UIColor alloc] initWithPatternImage:MF_PngOfDefaultSkin(@"head-portrait.png")];
        rectangle.backgroundColor = background;
        [background release];
        */
        /*
         JSBadgeView *badgeView = [[JSBadgeView alloc] initWithParentView:rectangle alignment:JSBadgeViewAlignmentCenterLeft];
         badgeView.badgeText = [NSString stringWithFormat:@"%d", i];
         
        
        UITapGestureRecognizer * gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickContact:)];
        [contactSquare addGestureRecognizer:gr];
        [gr release];
        */
        [contactSquare addTarget:self action:@selector(clickContact:) forControlEvents:UIControlEventTouchUpInside];

        [parentView addSubview:contactSquare];
        [contactSquare release];
        //[scrollView sendSubviewToBack:rectangle];
        
        xOffset += kSquareSideLength + kMarginBetweenSquares;
        
        if (xOffset > self.view.frame.size.width - kSquareSideLength)
        {
            xOffset = kInitialXOffset;
            yOffset += kSquareSideLength + 2*kMarginBetweenSquares + 16;
        }
    }
    
    //scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, yOffset);
}


#pragma mark - data 
- (void)fetchDataLocalBy:(NSString*) directoryPath and:(NSString*) keyword{
    self.arrContacts = [CContactInfo listContactByDirectoryPath:directoryPath andKeyword:keyword];
    if(!isSynced){
        self.asbCtl = [[[ActionSideBarController alloc] init] autorelease];
        self.asbCtl.delegate = self;
        [self.asbCtl doSyncFirst];
    }
    [myTableView reloadData];
}

#pragma mark - UITableView delegate 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrContacts count]/kNumContactsPerLoad +1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.height-62.0f;
}
 
static NSString *aCell=@"myCell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:aCell];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:aCell] autorelease];
        [self createContactIn:cell.contentView];
        //cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    [[cell.contentView subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([self.arrContacts count]>0 && idx<[self.arrContacts count]) {
            ((UIView*)obj).backgroundColor = kSquareColor;
            CContactInfo *dataItem = [arrContacts objectAtIndex:kNumContactsPerLoad*(indexPath.row)+idx];
            ((UILabel*)[[(UIView*)obj subviews] objectAtIndex:1]).text = dataItem.contactName;
        }
        else{
            ((UIView*)obj).backgroundColor = MF_ColorFromRGB(200, 200, 200);
            ((UILabel*)[[(UIView*)obj subviews] objectAtIndex:1]).text = @"";
        }
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DebugLog(@"didSelect %ld",(long)indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Actions
- (void) clickContact:(id)sender {
    UIButton *btn = sender;
    UITableViewCell *cell = (UITableViewCell*)[btn superviewWithClass:[UITableViewCell class]];
    NSIndexPath *indexPath = [myTableView indexPathForCell:cell];
    //DebugLog(@"indexPath.row:%d,btn.tag:%d",indexPath.row,btn.tag);
    clickRow = indexPath.row;
    clickIndexAtRow = btn.tag;
    
    CGPoint point = btn.center;
    //DebugLog(@"%@",NSStringFromCGPoint(point));
    NSInteger numberOfOptions = 9;
    NSArray *items = @[
                       [RNGridMenuItem emptyItem],
                       [[[RNGridMenuItem alloc] initWithImage: MF_PngOfDefaultSkin(@"phone.png") title:@"打电话"] autorelease],
                       [RNGridMenuItem emptyItem],
                       [[[RNGridMenuItem alloc] initWithImage: MF_PngOfDefaultSkin(@"message.png")title:@"发短信"] autorelease],
                       [[[RNGridMenuItem alloc] initWithImage: MF_PngOfDefaultSkin(@"person.png")title:@"详情"] autorelease],
                       [[[RNGridMenuItem alloc] initWithImage: MF_PngOfDefaultSkin(@"mail.png") title:@"发邮件"] autorelease],
                       [RNGridMenuItem emptyItem],
                       [[[RNGridMenuItem alloc] initWithImage: MF_PngOfDefaultSkin(@"star.png") title:@"本地通讯录"] autorelease],
                       [RNGridMenuItem emptyItem]
                       ];
    
    RNGridMenu *av = [[[RNGridMenu alloc] initWithItems:[items subarrayWithRange:NSMakeRange(0, numberOfOptions)]] autorelease];
    av.delegate = self;
    av.bounces = NO;
    av.animationDuration = 0.07;
    av.blurExclusionPath = [UIBezierPath bezierPathWithOvalInRect:btn.frame];
    av.backgroundPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.f, 0.f, av.itemSize.width*3, av.itemSize.height*3)];
        // av.headerView = header;
    
    [av showInViewController:self center:point];
}

- (void) _slide:(MWFSlideDirection)direction {
    [self.slideNavigationViewController slideWithDirection:direction];
}
- (void) close:(id)sender {
    [self _slide:MWFSlideDirectionNone];
}
#pragma mark - MWFSlideNavigationViewControllerDelegate

#define VIEWTAG_OVERLAY 1100
- (void) slideNavigationViewController:(MWFSlideNavigationViewController *)controller willPerformSlideFor:(UIViewController *)targetController withSlideDirection:(MWFSlideDirection)slideDirection distance:(CGFloat)distance orientation:(UIInterfaceOrientation)orientation {
    
    if (slideDirection == MWFSlideDirectionNone) {
        
        UIView * overlay = [self.view viewWithTag:VIEWTAG_OVERLAY];
        [overlay removeFromSuperview];
        
    } else if(slideDirection == MWFSlideDirectionRight || slideDirection == MWFSlideDirectionLeft){
        
        UIView * overlay = [[UIView alloc] initWithFrame:self.view.bounds];
        overlay.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        overlay.tag = VIEWTAG_OVERLAY;
        UITapGestureRecognizer * gr1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close:)];
        [overlay addGestureRecognizer:gr1];
        [gr1 release];
        
        
        __block MWFSlideDirection _panningDirection;
        UIPanGestureRecognizer * gr2 = [[UIPanGestureRecognizer alloc] initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
            
            switch (state) {
                case UIGestureRecognizerStateBegan:
                {
                    _panningDirection = MWFSlideDirectionNone;
                }
                    break;
                case UIGestureRecognizerStateChanged:
                {
                    if (_panningDirection == MWFSlideDirectionNone){
                        CGPoint p = [(UIPanGestureRecognizer*)sender translationInView:self.view];
                        
                        if (fabsf(p.y) > fabsf(p.x))
                        {
                            if (p.y < 0)
                            {
                                _panningDirection = MWFSlideDirectionUp;
                            }
                            else
                            {
                                _panningDirection = MWFSlideDirectionDown;
                            }
                        }
                        else
                        {
                            if (p.x < 0)
                            {
                                _panningDirection = MWFSlideDirectionLeft;
                            }
                            else
                            {
                                _panningDirection = MWFSlideDirectionRight;
                            }
                        }
                    }                 }
                    break;
                case UIGestureRecognizerStateEnded:
                {
                    if((slideDirection== MWFSlideDirectionRight && _panningDirection == MWFSlideDirectionLeft)
                       || (slideDirection== MWFSlideDirectionLeft && _panningDirection == MWFSlideDirectionRight)
                       ){
                        [self close:sender];
                    }
                    
                }
                    break;
                default:
                    break;
            }
        }];
        [overlay addGestureRecognizer:gr2];
        [gr2 release];
        
        overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:overlay];
        [overlay release];
        
    }
}
- (void) slideNavigationViewController:(MWFSlideNavigationViewController *)controller animateSlideFor:(UIViewController *)targetController withSlideDirection:(MWFSlideDirection)slideDirection distance:(CGFloat)distance orientation:(UIInterfaceOrientation)orientation
{
    UIView * overlay = [self.view viewWithTag:VIEWTAG_OVERLAY];
    if (slideDirection == MWFSlideDirectionNone)
    {
        overlay.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    }
    else
    {
        overlay.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }
}
- (NSInteger) slideNavigationViewController:(MWFSlideNavigationViewController *)controller distanceForSlideDirecton:(MWFSlideDirection)direction portraitOrientation:(BOOL)portraitOrientation
{
    if(direction ==MWFSlideDirectionRight){
        return DirectorySideBarWidth;
    }
    else if(direction ==MWFSlideDirectionLeft){
        return ActionSideBarWidthForShow;
    }
    return 0;
}
#pragma mark - MWFSlideNavigationViewControllerDataSource
- (UIViewController *) slideNavigationViewController:(MWFSlideNavigationViewController *)controller viewControllerForSlideDirecton:(MWFSlideDirection)direction
{
    if(direction == MWFSlideDirectionRight){
        if(self.dsbCtl==nil){
            self.dsbCtl = [[[DirectorySideBarController alloc] init] autorelease];
            self.dsbCtl.delegate = self;
        }
        return self.dsbCtl;
    }
    else if(direction == MWFSlideDirectionLeft){
        if(self.asbCtl==nil){
            self.asbCtl = [[[ActionSideBarController alloc] init] autorelease];
            self.asbCtl.delegate = self;
        }
        return self.asbCtl;
    }
    return  nil;
}

#pragma mark - RNGridMenuDelegate

- (void)gridMenu:(RNGridMenu *)gridMenu willDismissWithSelectedItem:(RNGridMenuItem *)item atIndex:(NSInteger)itemIndex {
    CContactInfo *dataItem = [arrContacts objectAtIndex:kNumContactsPerLoad*(clickRow)+clickIndexAtRow];
    DebugLog(@"%d",itemIndex);
    
    if(itemIndex == 1 || itemIndex == 3){
        //打电话 
        NSArray *joined = JOINARR4(mt_Tel(dataItem.dTel),mt_phone_short(dataItem.dTelShort),mt_Tel(dataItem.hTel),mt_mobile(dataItem.mobile),mt_phone_short(dataItem.mobileShort));
        /*
        DebugLog(@"dTel with item:%@", dTels);
        DebugLog(@"dTelShort with item:%@", dTelShort);
        DebugLog(@"mobile with item:%@",mobile);
        DebugLog(@"mobileShort with item:%@",mobileShort);
        DebugLog(@"joined with item:%@",joined);
        */
        if([joined count] == 1){
            //直接拨号
            if(itemIndex==1){
                call([joined firstObject]);
            }
            else{
                sms([joined firstObject],self);
            }
        }
        else if([joined count] >1){
            NSString *sheetTitle = itemIndex == 1 ? @"请选择一个号码拨号":@"请选择一个号码发送短信";
            UIActionSheet *phoneSheet = [UIActionSheet sheetWithTitle:sheetTitle];
            
            [joined each:^(id sender) {
                NSString *phoneNo = sender;
                [phoneSheet addButtonWithTitle:phoneNo handler:^void() {
                    if(itemIndex==1){
                        call(phoneNo);
                    }
                    else{
                        sms(phoneNo,self);
                    }
                }];
            }];
            [phoneSheet setCancelButtonWithTitle:@"取消" handler:^void() {}];
            [phoneSheet showInView:self.view];
        }
        else{
            ShowError(@"没有找到任何号码");
        }
    }
    else if (itemIndex == 4){
        //个人详细信息
        UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        maskView.backgroundColor = MF_ColorFromRGBA(0, 0, 0,0.5);
        [self.view addSubview:maskView];
        [maskView release];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMaskView:)];
        [maskView addGestureRecognizer:tapGesture];
        [tapGesture release];
        
        ContactDetailView *cdv = [[ContactDetailView alloc] initWithFrame:CGRectMake((maskView.width-227.f)/2.f, (maskView.height-332.f)/2.f, 227.f, 332.f) andData:dataItem];
        [maskView addSubview:cdv];
        [cdv release];
        
    }
    else if(itemIndex == 5){
        NSArray *mails = mt_mail(dataItem.eMail);
        if([mails count] > 0){
            mail(mails,self);
        }
        else{
            ShowError(@"没有找到任何邮箱地址");
        }
    }
    else if(itemIndex  == 7){
        
        if(canAccessAB){
            UIActionSheet *phoneSheet = [UIActionSheet sheetWithTitle:@"添加到本地通讯录"];
           
            [phoneSheet addButtonWithTitle:@"新建联系人" handler:^void() {
                [self showWaitViewWithTitle:@"添加联系人..."];
                ABAddressBookRef addressBook = [ABAddressBook sharedAddressBook].addressBookRef; // create address book record
                //ABAddressBookRef addressBook = ABAddressBookCreate(); // create address book record
                ABRecordRef person = ABPersonCreate(); // create a person
                
                [self saveAB:dataItem as:person in:addressBook complete:^void() {
                    ABAddressBookAddRecord(addressBook, person, nil); //add the new person to the record
                    ABAddressBookSave(addressBook, nil); //save the record
                    CFRelease(person); // relase the ABRecordRef  variable
                    [self closeWaitView];
                }];
                
                
            }];
            [phoneSheet addButtonWithTitle:@"添加到现有联系人" handler:^void() {
                
                ABAddressBook *addressBook = [ABAddressBook sharedAddressBook]; // create address book record
                
                ABPeoplePickerNavigationController *peoplePicker = [[ABPeoplePickerNavigationController alloc] init];
                NSNumber* firstNameProp = [NSNumber numberWithInt:kABPersonFirstNameProperty];
                NSNumber* lastNameProp = [NSNumber numberWithInt:kABPersonLastNameProperty];
                [peoplePicker setAddressBook:addressBook.addressBookRef];
                peoplePicker.displayedProperties = [NSArray arrayWithObjects:firstNameProp,lastNameProp, nil];
                [peoplePicker setPeoplePickerDelegate:self];
                [self presentModalViewController:peoplePicker animated:YES];
                [peoplePicker release];
            }];
            [phoneSheet setCancelButtonWithTitle:@"取消" handler:^void() {}];
            [phoneSheet showInView:self.view];
            
        }
        else{
            ShowError(@"当前程序不允许访问本地通讯录，请到设置里开通");
        }
    }
    
}

- (void) saveAB:(CContactInfo *)dataItem as:(ABRecordRef)person in:(ABAddressBookRef) addressBook complete:(dispatch_block_t) c{
    
    __block NSString * lastName = substring(dataItem.contactName,0,1);
    __block NSString * firstName = substring(dataItem.contactName,1,[dataItem.contactName length]-1);
    __block NSArray *mails = mt_mail(dataItem.eMail);
    __block NSArray *joined = JOINARR4(mt_Tel(dataItem.dTel),mt_phone_short(dataItem.dTelShort),mt_Tel(dataItem.hTel),mt_mobile(dataItem.mobile),mt_phone_short(dataItem.mobileShort));
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        
        ABRecordSetValue(person, kABPersonFirstNameProperty, firstName , nil); // first name of the new person
        ABRecordSetValue(person, kABPersonLastNameProperty, lastName, nil); // his last name
        
        
        if([joined count]>0){
            //Phone number is a list of phone number, so create a multivalue
            ABMutableMultiValueRef phoneNumberMultiValue = ABMultiValueCreateMutable(kABPersonPhoneProperty);
            [joined each:^(id sender) {
                DebugLog(@"add phone:%@",sender);
                ABMultiValueAddValueAndLabel(phoneNumberMultiValue ,sender,kABPersonPhoneMobileLabel, NULL);
            }];
            ABRecordSetValue(person, kABPersonPhoneProperty, phoneNumberMultiValue, nil); // set the phone number property
            CFRelease(phoneNumberMultiValue);
        }
        
        if([mails count]>0){
            ABMutableMultiValueRef emailMultiValue = ABMultiValueCreateMutable(kABPersonEmailProperty);
            [mails each:^(id sender) {
                ABMultiValueAddValueAndLabel(emailMultiValue ,sender,kABWorkLabel, NULL);
            }];
            ABRecordSetValue(person, kABPersonEmailProperty, emailMultiValue, nil);
            CFRelease(emailMultiValue);
        }
        
        //ABRecordRef group = ABGroupCreate(); //create a group
        //ABRecordSetValue(group, kABGroupNameProperty,@"My Group", nil); // set group's name
        //ABGroupAddMember(group, person, nil); // add the person to the group
        //ABAddressBookAddRecord(addressBook, group, nil); // add the group
        
        dispatch_async(dispatch_get_main_queue(), c);
    });
    
    
}

// Called after the user has pressed cancel
// The delegate is responsible for dismissing the peoplePicker
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}

// Called after a person has been selected by the user.
// Return YES if you want the person to be displayed.
// Return NO  to do nothing (the delegate is responsible for dismissing the peoplePicker).
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person{
    [self showWaitViewWithTitle:@"更新联系人..."];
    
    CContactInfo *dataItem = [arrContacts objectAtIndex:kNumContactsPerLoad*(clickRow)+clickIndexAtRow];
    [self saveAB:dataItem as:person in:peoplePicker.addressBook complete:^{
        ABAddressBookAddRecord(peoplePicker.addressBook, person, nil); //add the new person to the record
        ABAddressBookSave(peoplePicker.addressBook, nil); //save the record
        [self closeWaitView];
        [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    }];
    
    return NO;
}
// Called after a value has been selected by the user.
// Return YES if you want default action to be performed.
// Return NO to do nothing (the delegate is responsible for dismissing the peoplePicker).
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    return YES;
}

#pragma mark - ActionSideBarDelegate
- (void) clickSearchBtn{
    
    [self _slide:MWFSlideDirectionNone];
    
    UIView *maskView = makeView(0, 0, self.view.width, self.view.height);
    maskView.backgroundColor = MF_ColorFromRGBA(0, 0, 0,0.5);
    [self.view addSubview:maskView];

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMaskView:)];
    [maskView addGestureRecognizer:tapGesture];
    [tapGesture release];
    
    UITextField *searchField = [[UITextField alloc] initWithFrame:CGRectMake((maskView.width-280)/2.f,100.f,280.f, 40.f)];
    searchField.font = [UIFont systemFontOfSize:18];
    searchField.keyboardType = UIKeyboardTypeDefault;
    searchField.keyboardAppearance = UIKeyboardAppearanceDefault;
    searchField.backgroundColor = MF_ColorFromRGB(175, 175, 175);
    searchField.placeholder = @"请输入关键字";
    searchField.textAlignment = UITextAlignmentCenter;
    searchField.inputAccessoryView = [CInputAssistView createWithDelegate:self target:searchField style:CInputAssistViewCancelAndDone];
    searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [maskView addSubview:searchField];
    [searchField release];
    
    [searchField becomeFirstResponder];
}

- (void)tapMaskView:(UIGestureRecognizer *)gestureRecognizer {
    [gestureRecognizer.view removeFromSuperview];
}

- (void) beginSync:(NSString*) title{
    savB(APP_SETTING_IS_SYNCED_KEY, TRUE);
    [self _slide:MWFSlideDirectionNone];
    [self showWaitViewWithTitle:title];
}

- (void) updateSync:(NSString *)title{
    [self updateWaitViewWithTitle:title];
}

- (void) endSync{
    [self closeWaitView];
    [self fetchDataLocalBy:nil and:nil];
}

#pragma mark - DirectorySideBarDelegate
- (void)filter:(id)filterInfo and:(BOOL) autoBack{
    
    [self fetchDataLocalBy:((CDirectoryInfo*)filterInfo).directoryPath and:nil];
    if(autoBack==YES){
        [self _slide:MWFSlideDirectionNone];
    }
}

#pragma mark - CInputAssistViewDelgate Method
-(void)inputAssistViewPerviousTapped:(UITextField*)aTextFiled{
}
-(void)inputAssistViewNextTapped:(UITextField*)aTextFiled{
}
-(void)inputAssistViewCancelTapped:(UITextField*)aTextFiled{
    [aTextFiled resignFirstResponder];
    [aTextFiled.superview removeFromSuperview];
}

-(void)inputAssistViewDoneTapped:(UITextField*)aTextFiled{
    [self fetchDataLocalBy:nil and:aTextFiled.text];
    [aTextFiled resignFirstResponder];
    [aTextFiled.superview removeFromSuperview];
}

@end
