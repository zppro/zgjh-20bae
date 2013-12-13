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
    //self.view.width = DirectorySideBarWidth;
    self.view.backgroundColor = [UIColor whiteColor];
    
    RNLongPressGestureRecognizer *longPress = [[RNLongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [self.view addGestureRecognizer:longPress];
    
}


- (void)handleLongPress:(UILongPressGestureRecognizer *)longPress {
    if (longPress.state == UIGestureRecognizerStateBegan) {
        [self showGridWithHeaderFromPoint:[longPress locationInView:self.view]];
    }
}

- (void)showGridWithHeaderFromPoint:(CGPoint)point {
    NSInteger numberOfOptions = 9;
    NSArray *items = @[
                       [RNGridMenuItem emptyItem],
                       [[RNGridMenuItem alloc] initWithImage: MF_PngOfDefaultSkin(@"attachment.png") title:@"Attach"],
                       [RNGridMenuItem emptyItem],
                       [[RNGridMenuItem alloc] initWithImage: MF_PngOfDefaultSkin(@"bluetooth.png")title:@"Bluetooth"],
                       [[RNGridMenuItem alloc] initWithImage: MF_PngOfDefaultSkin(@"cube.png") title:@"Deliver"],
                       [[RNGridMenuItem alloc] initWithImage: MF_PngOfDefaultSkin(@"download.png") title:@"Download"],
                       [RNGridMenuItem emptyItem],
                       [[RNGridMenuItem alloc] initWithImage: MF_PngOfDefaultSkin(@"file.png") title:@"Source Code"],
                       [RNGridMenuItem emptyItem]
                       ];
    
    RNGridMenu *av = [[RNGridMenu alloc] initWithItems:[items subarrayWithRange:NSMakeRange(0, numberOfOptions)]];
    av.delegate = self;
    av.bounces = NO;
    av.animationDuration = 0.2;
    //av.blurExclusionPath = [UIBezierPath bezierPathWithOvalInRect:self.imageView.frame];
    av.backgroundPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.f, 0.f, av.itemSize.width*3, av.itemSize.height*3)];
    
    UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    header.text = @"Example Header";
    header.font = [UIFont boldSystemFontOfSize:18];
    header.backgroundColor = [UIColor clearColor];
    header.textColor = [UIColor whiteColor];
    header.textAlignment = NSTextAlignmentCenter;
    // av.headerView = header;
    
    [av showInViewController:self center:point];
}

- (void)showGrid:(CGPoint)point {
    NSInteger numberOfOptions = 9;
    NSArray *items = @[
                       [[RNGridMenuItem alloc] initWithImage: MF_PngOfDefaultSkin(@"arrow.png") title:@"Next"],
                       [[RNGridMenuItem alloc] initWithImage: MF_PngOfDefaultSkin(@"attachment.png") title:@"Attach"],
                       [[RNGridMenuItem alloc] initWithImage: MF_PngOfDefaultSkin(@"block.png") title:@"Cancel"],
                       [[RNGridMenuItem alloc] initWithImage: MF_PngOfDefaultSkin(@"bluetooth.png")title:@"Bluetooth"],
                       [[RNGridMenuItem alloc] initWithImage: MF_PngOfDefaultSkin(@"cube.png") title:@"Deliver"],
                       [[RNGridMenuItem alloc] initWithImage: MF_PngOfDefaultSkin(@"download.png") title:@"Download"],
                       [[RNGridMenuItem alloc] initWithImage: MF_PngOfDefaultSkin(@"enter.png") title:@"Enter"],
                       [[RNGridMenuItem alloc] initWithImage: MF_PngOfDefaultSkin(@"file.png") title:@"Source Code"],
                       [[RNGridMenuItem alloc] initWithImage: MF_PngOfDefaultSkin(@"github.png") title:@"Github"]
                       ];
    
    RNGridMenu *av = [[RNGridMenu alloc] initWithItems:[items subarrayWithRange:NSMakeRange(0, numberOfOptions)]];
    av.delegate = self;
    //    av.bounces = NO;
    [av showInViewController:self center:CGPointMake(self.view.bounds.size.width/2.f, self.view.bounds.size.height/2.f)];
}

#pragma mark - RNGridMenuDelegate

- (void)gridMenu:(RNGridMenu *)gridMenu willDismissWithSelectedItem:(RNGridMenuItem *)item atIndex:(NSInteger)itemIndex {
    NSLog(@"Dismissed with item %d: %@", itemIndex, item.title);
}

@end
