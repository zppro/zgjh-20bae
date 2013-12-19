//
//  DirectorySideBarController.m
//  eab20
//
//  Created by zppro on 13-12-12.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import "DirectorySideBarController.h"
#import "CDirectoryInfo.h"

@interface DirectorySideBarController ()<RATreeViewDelegate, RATreeViewDataSource>
@property (retain, nonatomic) NSArray *data;
@property (retain, nonatomic) id expanded;
@property (retain, nonatomic) RATreeView *treeView;
@end

@implementation DirectorySideBarController
@synthesize data;
@synthesize expanded;
@synthesize treeView;

- (void)dealloc {
    self.data = nil;
    self.expanded = nil;
    self.treeView = nil;
    [super dealloc];
}

- (void)loadView{
    [super loadView];
    self.view.width = DirectorySideBarWidth;
    self.view.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark TreeView Delegate methods
- (CGFloat)treeView:(RATreeView *)treeView heightForRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo{
    return 20;
}

- (NSInteger)treeView:(RATreeView *)treeView indentationLevelForRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo{
    return 3 * treeNodeInfo.treeDepthLevel;
}

- (BOOL)treeView:(RATreeView *)treeView shouldExpandItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo{
    return YES;
}

- (BOOL)treeView:(RATreeView *)treeView shouldItemBeExpandedAfterDataReload:(id)item treeDepthLevel:(NSInteger)treeDepthLevel{
    if ([item isEqual:self.expanded]) {
        return YES;
    }
    return NO;
}

- (void)treeView:(RATreeView *)treeView willDisplayCell:(UITableViewCell *)cell forItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo{
    cell.backgroundColor = MF_ColorFromRGB(128, 128, 128);
}

#pragma mark TreeView Data Source
- (UITableViewCell *)treeView:(RATreeView *)treeView cellForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo{
    NSInteger numberOfChildren = [treeNodeInfo.children count];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Number of children %ld", (long)numberOfChildren];
    cell.textLabel.text = ((CDirectoryInfo *)item).directoryName;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (treeNodeInfo.treeDepthLevel == 0) {
        cell.detailTextLabel.textColor = [UIColor blackColor];
    }
    return cell;
}

- (NSInteger)treeView:(RATreeView *)treeView numberOfChildrenOfItem:(id)item{
    if (item == nil) {
        return [self.data count];
    }
    //RADataObject *data = item;
    //return [data.children count];
    return 1;
}

- (id)treeView:(RATreeView *)treeView child:(NSInteger)index ofItem:(id)item{
    //CDirectoryInfo *data = item;
    if (item == nil) {
        return [self.data objectAtIndex:index];
    }
    //
    //return [data.children objectAtIndex:index];
    return  nil;
}

@end
