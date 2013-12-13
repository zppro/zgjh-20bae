//
//  HomeController.m
//  eab20
//
//  Created by zppro on 13-12-11.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import "HomeController.h"
#import "DirectorySideBarController.h"
#import "ActionSideBarController.h"
#import "ContactActionController.h"
#import "JSBadgeView.h"

#define kNumContactsPerLoad 24
#define kViewBackgroundColor [UIColor colorWithRed:0.357 green:0.757 blue:0.357 alpha:1]
#define kSquareSideLength 64.0f
#define kSquareCornerRadius 10.0f
#define kMarginBetweenSquares 10.0f
#define kSquareColor [UIColor colorWithRed:0.004 green:0.349 blue:0.616 alpha:1]

@interface HomeController ()
@property (nonatomic, retain) NSArray      *arrContacts;
@property (nonatomic, retain) UITableView  *myTableView;
@end

@implementation HomeController

@synthesize myTableView;
@synthesize arrContacts;

- (void)dealloc {
    self.myTableView = nil;
    self.arrContacts = nil;
    [super dealloc];
}

- (void)loadView
{
    [super loadView];
    
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width,self.view.height)];
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

- (void) createContactIn:(UIView *)parentView{
    self.view.backgroundColor = kViewBackgroundColor;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    //scrollView.alwaysBounceHorizontal = YES;
    [parentView addSubview:scrollView];
    [scrollView release];
    
    CGFloat viewWidth = self.view.frame.size.width;
    
    NSUInteger numberOfSquaresPerRow = floor(viewWidth / (kSquareSideLength + kMarginBetweenSquares));
    const CGFloat kInitialXOffset = (viewWidth - (numberOfSquaresPerRow * kSquareSideLength)) / (float)numberOfSquaresPerRow;
    CGFloat xOffset = kInitialXOffset;
    
    const CGFloat kInitialYOffset = kInitialXOffset;
    CGFloat yOffset = kInitialYOffset;
    
    CGRect rectangleBounds = CGRectMake(0.0f,
                                        0.0f,
                                        kSquareSideLength,
                                        kSquareSideLength);
    
    
    CGPathRef rectangleShadowPath = [UIBezierPath bezierPathWithRoundedRect:rectangleBounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(kSquareCornerRadius, kSquareCornerRadius)].CGPath;
     
    
    
    for (int i = 0; i < kNumContactsPerLoad; i++)
    {
        UIView *contactSquare = [[UIView alloc] initWithFrame:CGRectIntegral(CGRectMake(xOffset,
                                                                                    yOffset,
                                                                                    rectangleBounds.size.width,
                                                                                    rectangleBounds.size.height))];
        contactSquare.userInteractionEnabled = YES;
        contactSquare.backgroundColor = kSquareColor;
        contactSquare.layer.cornerRadius = kSquareCornerRadius;
        contactSquare.layer.shadowColor = [UIColor blackColor].CGColor;
        contactSquare.layer.shadowOffset = CGSizeMake(0.0f, 3.0f);
        contactSquare.layer.shadowOpacity = 0.4;
        contactSquare.layer.shadowRadius = 1.0;
        contactSquare.layer.shadowPath = rectangleShadowPath;
        contactSquare.layer.shadowColor = [UIColor blackColor].CGColor;
        contactSquare.layer.shadowOffset = CGSizeMake(3.0f, 3.0f);
        contactSquare.layer.shadowOpacity = 0.4;
        contactSquare.layer.shadowRadius = 1.0;
        contactSquare.layer.shadowPath = rectangleShadowPath;
        
        
        
        UILabel *nameView = [[UILabel alloc] initWithFrame:CGRectMake(3, kSquareSideLength - 12, kSquareSideLength-2*3, 12.0f)];
        nameView.backgroundColor = [UIColor clearColor];
        nameView.font = [UIFont systemFontOfSize:10.0f];
        nameView.textAlignment = NSTextAlignmentCenter;
        nameView.textColor = [UIColor whiteColor];
        nameView.text=@"联系人";
        [contactSquare addSubview:nameView];
        [nameView release];
        
        
        UIImageView *iv = makeImageViewByFrame(CGRectMake((kSquareSideLength-48.f)/2, 4, 48.f, 48.f));
        iv.image = MF_PngOfDefaultSkin(@"head-portrait.png");
        [contactSquare addSubview:iv];
        iv.layer.borderWidth = 2;
        iv.layer.borderColor = [UIColor whiteColor].CGColor;
        iv.layer.cornerRadius = CGRectGetHeight(iv.bounds) / 2;
        iv.clipsToBounds = YES;
        
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
         */
        
        UITapGestureRecognizer * gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickContact:)];
        [contactSquare addGestureRecognizer:gr];
        [gr release];
        
        [scrollView addSubview:contactSquare];
        //[scrollView sendSubviewToBack:rectangle];
        
        xOffset += kSquareSideLength + kMarginBetweenSquares;
        
        if (xOffset > self.view.frame.size.width - kSquareSideLength)
        {
            xOffset = kInitialXOffset;
            yOffset += kSquareSideLength + kMarginBetweenSquares;
        }
    }
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, yOffset);
}


#pragma mark - UITableView delegate 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.height;
}
 
static NSString *aCell=@"myCell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:aCell];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:aCell] autorelease];
        [self createContactIn:cell.contentView];
    }
    NSArray *arrViewOfContactRectangles =[[[cell.contentView subviews] objectAtIndex:0] subviews];
    //DebugLog(@"%@",arrViewOfContactRectangles);
    [arrViewOfContactRectangles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        //DebugLog(@"row:%d,%d",idx,24*(indexPath.row)+idx);
        //DebugLog(@"text:%@",JOIN3(@"联系人:", SI(indexPath.row), @",", SI(24*(indexPath.row)+idx)));
        if(idx <24){
            //((UILabel*)[[(UIView*)obj subviews] objectAtIndex:0]).text = JOIN3(@"联系人:", SI(indexPath.row), @",", SI(24*(indexPath.row)+idx));
        }
    }];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DebugLog(@"didSelect %d",indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Actions
- (void) clickContact:(UIGestureRecognizer *)gestureRecognizer {

    CGPoint point = [gestureRecognizer locationInView:self.view];
    DebugLog(@"%@",NSStringFromCGPoint(point));
    NSInteger numberOfOptions = 9;
    NSArray *items = @[
                       [RNGridMenuItem emptyItem],
                       [[[RNGridMenuItem alloc] initWithImage: MF_PngOfDefaultSkin(@"attachment.png") title:@"Attach"] autorelease],
                       [RNGridMenuItem emptyItem],
                       [[[RNGridMenuItem alloc] initWithImage: MF_PngOfDefaultSkin(@"bluetooth.png")title:@"Bluetooth"] autorelease],
                       [[[RNGridMenuItem alloc] initWithImage: MF_PngOfDefaultSkin(@"cube.png") title:@"Deliver"] autorelease],
                       [[[RNGridMenuItem alloc] initWithImage: MF_PngOfDefaultSkin(@"download.png") title:@"Download"] autorelease],
                       [RNGridMenuItem emptyItem],
                       [[[RNGridMenuItem alloc] initWithImage: MF_PngOfDefaultSkin(@"file.png") title:@"Source Code"] autorelease],
                       [RNGridMenuItem emptyItem]
                       ];
    
    RNGridMenu *av = [[RNGridMenu alloc] initWithItems:[items subarrayWithRange:NSMakeRange(0, numberOfOptions)]];
    av.delegate = self;
    av.bounces = NO;
    av.animationDuration = 0.2;
    //av.blurExclusionPath = [UIBezierPath bezierPathWithOvalInRect:self.imageView.frame];
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
        return ActionSideBarWidth;
    }
    return 0;
}
#pragma mark - MWFSlideNavigationViewControllerDataSource
- (UIViewController *) slideNavigationViewController:(MWFSlideNavigationViewController *)controller viewControllerForSlideDirecton:(MWFSlideDirection)direction
{
    if(direction == MWFSlideDirectionRight){
        return [[[DirectorySideBarController alloc] init] autorelease];
    }
    else if(direction == MWFSlideDirectionLeft){
        return [[[ActionSideBarController alloc] init] autorelease];
    }
    return  nil;
}

#pragma mark - RNGridMenuDelegate

- (void)gridMenu:(RNGridMenu *)gridMenu willDismissWithSelectedItem:(RNGridMenuItem *)item atIndex:(NSInteger)itemIndex {
    NSLog(@"Dismissed with item %d: %@", itemIndex, item.title);
}

@end
