//
//  DirectorySideBarController.m
//  eab20
//
//  Created by zppro on 13-12-12.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import "DirectorySideBarController.h"
#import "CDirectoryInfo.h"
#import "CContactInfo.h"

@interface DirectorySideBarController ()<RATreeViewDelegate, RATreeViewDataSource>
@property (retain, nonatomic) NSArray *directoryInfos;
@property (retain, nonatomic) id expanded;
@property (retain, nonatomic) RATreeView *treeView;
@property (retain, nonatomic) NSMutableDictionary *countOfContactForDirectoryPath;
@end

@implementation DirectorySideBarController
@synthesize directoryInfos=_directoryInfos;
@synthesize expanded;
@synthesize treeView = _treeView;
@synthesize countOfContactForDirectoryPath = _countOfContactForDirectoryPath;

- (void)dealloc {
    [_directoryInfos release];
    self.expanded = nil;
    [_treeView release];
    [_countOfContactForDirectoryPath release];
    [super dealloc];
}

- (void)loadView{
    [super loadView];
    self.view.width = DirectorySideBarWidth;
    self.view.backgroundColor = [UIColor whiteColor];
    _countOfContactForDirectoryPath = [[NSMutableDictionary alloc] init];
    
    _treeView = [[RATreeView alloc] initWithFrame:CGRectMake(0, 10, self.view.width, self.view.height-10)];
    _treeView.delegate = self;
    _treeView.dataSource = self;
    _treeView.separatorStyle = RATreeViewCellSeparatorStyleSingleLine;
    
    [self.view addSubview:_treeView];
    [_treeView release];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    _directoryInfos = [CDirectoryInfo listDirectoryAsRoot];
    [_treeView reloadData];
}
#pragma mark TreeView Delegate methods
- (CGFloat)treeView:(RATreeView *)treeView heightForRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo{
    return 40;
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
    else if(treeDepthLevel==0){
        return YES;
    }
    return NO;
}

- (void)treeView:(RATreeView *)treeView willDisplayCell:(UITableViewCell *)cell forItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo{
    NSInteger numberOfChildren = [treeNodeInfo.children count];
    if(numberOfChildren==0){
        cell.imageView.image = MF_PngOfDefaultSkin(@"minus.png");
    }
    else{
        if(treeNodeInfo.expanded){
            //因为第一层自动打开
            cell.imageView.image = MF_PngOfDefaultSkin(@"minus.png");
        }
        else{
            cell.imageView.image = MF_PngOfDefaultSkin(@"plus.png");
        }
    }
}


- (NSString *)treeView:(RATreeView *)treeView titleForDeleteConfirmationButtonForRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo{
    return @"筛选";
}

- (void)treeView:(RATreeView *)treeView willExpandRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo{
    //NSInteger numberOfChildren = [treeNodeInfo.children count];
    //DebugLog(@"Expand:%@",((CDirectoryInfo*)item).directoryName);
    UITableViewCell * cell = [treeView cellForItem:item];
    if(cell != nil){
        cell.imageView.image = MF_PngOfDefaultSkin(@"minus.png");
    }
}

- (void)treeView:(RATreeView *)treeView willCollapseRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo{
    NSInteger numberOfChildren = [treeNodeInfo.children count];
    //DebugLog(@"Collapse:%@",((CDirectoryInfo*)item).directoryName);
    UITableViewCell * cell = [treeView cellForItem:item];
    if(cell != nil){
        if(numberOfChildren==0){
            cell.imageView.image = MF_PngOfDefaultSkin(@"minus.png");
        }
        else{
            cell.imageView.image = MF_PngOfDefaultSkin(@"plus.png");
        }
    }
}

- (void)treeView:(RATreeView *)treeView didSelectRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo{
    //DebugLog(@"didSelect:%@",((CDirectoryInfo*)item).directoryName);
    if(self.delegate != nil){
        [self.delegate filter:item and:NO];
    }
}

#pragma mark TreeView Data Source
- (UITableViewCell *)treeView:(RATreeView *)treeView cellForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo{
    //NSInteger numberOfChildren = [treeNodeInfo.children count];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    CDirectoryInfo * directoryInfo = ((CDirectoryInfo *)item);
    NSNumber *countOfDirectoryPath = [_countOfContactForDirectoryPath objectForKey:directoryInfo.directoryPath];
    if(countOfDirectoryPath==nil){
        countOfDirectoryPath = NI((int)[CContactInfo countContactByDirectoryPath:directoryInfo.directoryPath]);
        [_countOfContactForDirectoryPath setValue:countOfDirectoryPath forKey:directoryInfo.directoryPath];
    }
    
    //cell.detailTextLabel.text = MF_SWF(@"%@个联系人", countOfDirectoryPath);
    cell.textLabel.text = MF_SWF(@"%@(%@)",directoryInfo.directoryName,countOfDirectoryPath);

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    /*
    if (treeNodeInfo.treeDepthLevel == 0) {
        cell.detailTextLabel.textColor = [UIColor blackColor];
    }
    */
    return cell;
}

- (NSInteger)treeView:(RATreeView *)treeView numberOfChildrenOfItem:(id)item{
    if (item == nil) {
        return [_directoryInfos count];
    }
    CDirectoryInfo *directoryInfo = item;
    return [directoryInfo.children count];
}

- (id)treeView:(RATreeView *)treeView child:(NSInteger)index ofItem:(id)item{
    if (item == nil) {
        return [_directoryInfos objectAtIndex:index];
    }
    CDirectoryInfo *directoryInfo = item;
    return [directoryInfo.children objectAtIndex:index];
}


- (void)treeView:(RATreeView *)treeView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        if(self.delegate != nil){
            [self.delegate filter:item and:YES];
        }
    }
}
@end
