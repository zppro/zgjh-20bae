//
//  ActionSideBarController.m
//  eab20
//
//  Created by zppro on 13-12-12.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import "ActionSideBarController.h"
#import "CDirectoryInfo.h"
#import "CContactInfo.h"

@interface ActionSideBarController ()
@property (nonatomic, retain) UITableView  *myTableView;
@end

@implementation ActionSideBarController
@synthesize myTableView;

- (void)dealloc {
    self.myTableView = nil;
    [super dealloc];
}

- (void)loadView{
    [super loadView];
    self.view.width = ActionSideBarWidthForShow;
    self.view.backgroundColor= MF_ColorFromRGB(38, 38, 38);
    
    /*
    self.waitView.frame =CGRectMake(ActionSideBarWidthForShow - [UIScreen mainScreen].bounds.size.width,0,[UIScreen mainScreen].bounds.size.width,self.view.height);
    */
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 35.0f, self.view.width,self.view.height-35.0f)];
    myTableView.backgroundColor = MF_ColorFromRGB(52, 53, 53);
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableView];
    [myTableView release];
    
    /*
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
    */
}

#pragma mark - UITableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 58;
}

static NSString *aCell=@"myCell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:aCell];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:aCell] autorelease];
        UIImageView *splitView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 58-2.5, myTableView.width, 2.5)];
        splitView.image = MF_PngOfDefaultSkin(@"cellSplit.png");
        [cell addSubview:splitView];
        [splitView release];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((myTableView.width-30.f)/2.f, (58-30.f)/2.f, 30.f, 30.f)];
        
        [cell addSubview:imgView];
        [imgView release];
        
        if(indexPath.row==0){
            imgView.image = MF_PngOfDefaultSkin(@"search.png");
            /*
            UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [searchBtn setFrame:CGRectMake((cell.contentView.width - 48.f)/2.f,(cell.contentView.height - 48.f)/2.f, 48.f, 48.f)];
            [searchBtn setImage:MF_PngOfDefaultSkin(@"search.png") forState:UIControlStateNormal];
            [searchBtn addTarget:self action:@selector(doSearch:) forControlEvents:UIControlEventTouchUpInside];
            [searchBtn setBackgroundColor:[UIColor clearColor]];
            [cell.contentView addSubview:searchBtn];
            */
        }
        else if(indexPath.row==1){
            imgView.image = MF_PngOfDefaultSkin(@"sync.png");
            /*
            UIButton *syncBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [syncBtn setFrame:CGRectMake((cell.contentView.width - 48.f)/2.f,(cell.contentView.height - 48.f)/2.f, 48.f, 48.f)];
            [syncBtn setImage:MF_PngOfDefaultSkin(@"sync.png") forState:UIControlStateNormal];
            [syncBtn addTarget:self action:@selector(doSync:) forControlEvents:UIControlEventTouchUpInside];
            [syncBtn setBackgroundColor:[UIColor clearColor]];
            [cell.contentView addSubview:syncBtn];
            */
        }
        else if (indexPath.row == 2){
            imgView.image = MF_PngOfDefaultSkin(@"gear.png");
            /*
            UIButton *gearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [gearBtn setFrame:CGRectMake((cell.contentView.width - 48.f)/2.f,(cell.contentView.height - 48.f)/2.f, 48.f, 48.f)];
            [gearBtn setImage:MF_PngOfDefaultSkin(@"gear.png") forState:UIControlStateNormal];
            [gearBtn addTarget:self action:@selector(doSettings:) forControlEvents:UIControlEventTouchUpInside];
            [gearBtn setBackgroundColor:[UIColor clearColor]];
            [cell.contentView addSubview:gearBtn];
            */
        }
        else if (indexPath.row == 3){
            imgView.image = MF_PngOfDefaultSkin(@"info-2.png");
            /*
            UIButton *infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [infoBtn setFrame:CGRectMake((cell.contentView.width - 48.f)/2.f,(cell.contentView.height - 48.f)/2.f, 48.f, 48.f)];
            [infoBtn setImage:MF_PngOfDefaultSkin(@"info-2.png") forState:UIControlStateNormal];
            [infoBtn addTarget:self action:@selector(doInfo:) forControlEvents:UIControlEventTouchUpInside];
            [infoBtn setBackgroundColor:[UIColor clearColor]];
            [cell.contentView addSubview:infoBtn];
            */
        }
        cell.backgroundColor = [UIColor clearColor];
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DebugLog(@"didSelect %ld",(long)indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row==0){
        [self doSearch:nil];
    }
    else if(indexPath.row==1){
        [self doSync:nil];
    }
    else if (indexPath.row == 2){
        [self doSettings:nil];
    }
    else if (indexPath.row == 3){
        [self doInfo:nil];
    }
}

- (void) doSearch:(id) sender{
    /*
    
     */
    if(self.delegate != nil){
        [(id)_delegate performSelector:@selector(clickSearchBtn)];
    }
}

- (void) doSyncFirst{
    [self doSync:nil];
}

- (void) doSync:(id) sender{
    if(isActiviated && isAuthorized){
        
        NSDictionary *head = [NSDictionary dictionaryWithObjectsAndKeys:appSession.token,@"Token",invokeToAppId,@"ApplicationIdTo",appSession.du,@"DU",appSession.sdn,@"SDN",nil];
        HttpAppRequest *req = buildReq2(head);
        
        if(self.delegate != nil){
            [(id)_delegate performSelector:@selector(beginSync:) withObject:@"同步自身信息..."];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [HttpAppAsynchronous httpGetWithUrl:[appSession getBizUrl:BIT_SyncSelfInfo] req:req sucessBlock:^(id result) {
                
                DebugLog(@"IsSE:%@",[((HttpAppResponse*)result).ret objectForKey:@"IsSE"]);
                appSession.mappingDirectoryId = [((HttpAppResponse*)result).ret objectForKey:@"MappingDirectoryId"];
                appSession.directoryIdOfLevel2 = [((HttpAppResponse*)result).ret objectForKey:@"DirectoryIdOfLevel2"];
                appSession.directoryIdOfLevel3 = [((HttpAppResponse*)result).ret objectForKey:@"DirectoryIdOfLevel3"];
                appSession.isSE = [[((HttpAppResponse*)result).ret objectForKey:@"IsSE"] boolValue];
                appSession.contactProperty = [((HttpAppResponse*)result).ret objectForKey:@"ContactProperty"];
                
                savS(APP_SETTING_MAPPING_DIRECTORY_ID_KEY, appSession.mappingDirectoryId);
                savS(APP_SETTING_DIRECTORY_ID_OF_LEVEL2_KEY, appSession.directoryIdOfLevel2);
                savS(APP_SETTING_DIRECTORY_ID_OF_LEVEL3_KEY, appSession.directoryIdOfLevel3);
                savB(APP_SETTING_IS_SE_KEY, appSession.isSE);
                savS(APP_SETTING_CONTACT_PROPERTY_KEY, appSession.contactProperty);
                
                if(self.delegate != nil){
                    [(id)_delegate performSelector:@selector(beginSync:) withObject:@"同步机构目录..."];
                }
                //dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                
                //dispatch_get_main_queue()
                dispatch_async(dispatch_get_main_queue(), ^{
                    [HttpAppAsynchronous httpGetWithUrl:[appSession getBizUrl:BIT_SyncDirectory] req:req sucessBlock:^(id result) {
                        if([CDirectoryInfo updateAll:(NSArray*)((HttpAppResponse*)result).rows]){
                            /** 读取联系人(基础) start **/
                            if(self.delegate != nil){
                                [(id)_delegate performSelector:@selector(updateSync:) withObject:@"同步联系人..."];
                            }
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                [HttpAppAsynchronous httpGetWithUrl:[appSession getBizUrl:BIT_SyncContact] req:req sucessBlock:^(id result) {
                                    
                                    if([CContactInfo updateWithData:(NSArray*)((HttpAppResponse*)result).rows ByType:UpdateSourceType_BySelf]){
                                        if(self.delegate != nil){
                                            [(id)_delegate performSelector:@selector(updateSync:) withObject:@"同步成功"];
                                        }
                                    }
                                    
                                } failedBlock:^(NSError *error) {
                                    //
                                    DebugLog(@"%@",error);
                                } completionBlock:^{
                                    if(self.delegate != nil){
                                        [(id)_delegate performSelector:@selector(endSync)];
                                    }
                                }];
                                /** 读取联系人(基础) end **/
                            });
                        }
                    } failedBlock:^(NSError *error) {
                        //
                        if(self.delegate != nil){
                            [(id)_delegate performSelector:@selector(endSync)];
                        }
                        DebugLog(@"%@",error);
                    } completionBlock:^{
                        
                    }];
                    /** 读取机构目录 end **/
                    
                });
                
            } failedBlock:^(NSError *error) {
                if(self.delegate != nil){
                    [(id)_delegate performSelector:@selector(endSync)];
                }
                DebugLog(@"%@",error);
            } completionBlock:^{
                
            }];
            /** 读取当前联系人信息 end **/
        });
        
    }
}

- (void) doSync2:(id) sender{
    if(isActiviated && isAuthorized){

        NSDictionary *head = [NSDictionary dictionaryWithObjectsAndKeys:appSession.token,@"Token",invokeToAppId,@"ApplicationIdTo",appSession.du,@"DU",appSession.sdn,@"SDN",nil];
        HttpAppRequest *req = buildReq2(head);
        
        if(self.delegate != nil){
            [(id)_delegate performSelector:@selector(beginSync:) withObject:@"同步自身信息..."];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [HttpAppAsynchronous httpGetWithUrl:[appSession getBizUrl:BIT_SyncSelfInfo] req:req sucessBlock:^(id result) {

                DebugLog(@"IsSE:%@",[((HttpAppResponse*)result).ret objectForKey:@"IsSE"]);
                appSession.mappingDirectoryId = [((HttpAppResponse*)result).ret objectForKey:@"MappingDirectoryId"];
                appSession.isSE = [[((HttpAppResponse*)result).ret objectForKey:@"IsSE"] boolValue];
                
                savS(APP_SETTING_MAPPING_DIRECTORY_ID_KEY, appSession.mappingDirectoryId);
                savB(APP_SETTING_IS_SE_KEY, appSession.isSE);

                if(self.delegate != nil){
                    [(id)_delegate performSelector:@selector(beginSync:) withObject:@"同步机构目录..."];
                }
                //dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                
                //dispatch_get_main_queue()
                dispatch_async(dispatch_get_main_queue(), ^{
                    [HttpAppAsynchronous httpGetWithUrl:[appSession getBizUrl:BIT_SyncDirectory] req:req sucessBlock:^(id result) {
                        if([CDirectoryInfo updateAll:(NSArray*)((HttpAppResponse*)result).rows]){
                            /** 读取联系人(基础) start **/
                            if(self.delegate != nil){
                                [(id)_delegate performSelector:@selector(updateSync:) withObject:@"同步联系人(基础)..."];
                            }
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                [HttpAppAsynchronous httpGetWithUrl:[appSession getBizUrl:BIT_SyncContactBySelf] req:req sucessBlock:^(id result) {
                                    
                                    if([CContactInfo updateWithData:(NSArray*)((HttpAppResponse*)result).rows ByType:UpdateSourceType_BySelf]){
                                        
                                        /** 读取联系人(部门条线) start **/
                                        if(self.delegate != nil){
                                            [(id)_delegate performSelector:@selector(updateSync:) withObject:@"同步联系人(部门条线)..."];
                                        }
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            [HttpAppAsynchronous httpGetWithUrl:[appSession getBizUrl:BIT_SyncContactByDLine] req:req sucessBlock:^(id result) {
                                                
                                                if([CContactInfo updateWithData:(NSArray*)((HttpAppResponse*)result).rows ByType:UpdateSourceType_ByDLine]){
                                                    if(appSession.isSE){
                                                        /** 读取联系人(高管条线) start **/
                                                        if(self.delegate != nil){
                                                            [(id)_delegate performSelector:@selector(updateSync:) withObject:@"同步联系人(高管条线)..."];
                                                        }
                                                        dispatch_async(dispatch_get_main_queue(), ^{
                                                            [HttpAppAsynchronous httpGetWithUrl:[appSession getBizUrl:BIT_SyncContactBySELine] req:req sucessBlock:^(id result) {
                                                                if(((HttpAppResponse*)result).rows !=nil){
                                                                    [CContactInfo updateWithData:(NSArray*)((HttpAppResponse*)result).rows ByType:UpdateSourceType_BySELine];
                                                                    if(self.delegate != nil){
                                                                        [(id)_delegate performSelector:@selector(updateSync:) withObject:@"同步成功"];
                                                                    }
                                                                }
                                                                else{
                                                                    if(self.delegate != nil){
                                                                        [(id)_delegate performSelector:@selector(updateSync:) withObject:@"同步成功"];
                                                                    }
                                                                }
                                                                
                                                            } failedBlock:^(NSError *error) {
                                                                //
                                                                DebugLog(@"%@",error);
                                                            } completionBlock:^{
                                                                
                                                                if(self.delegate != nil){
                                                                    [(id)_delegate performSelector:@selector(endSync)];
                                                                }
                                                            }];
                                                        });
                                                        /** 读取联系人(高管条线) end **/
                                                    }
                                                    else{
                                                        if(self.delegate != nil){
                                                            [(id)_delegate performSelector:@selector(endSync)];
                                                        }
                                                    }
                                                }
                                                
                                            } failedBlock:^(NSError *error) {
                                                //
                                                if(self.delegate != nil){
                                                    [(id)_delegate performSelector:@selector(endSync)];
                                                }
                                                DebugLog(@"%@",error);
                                            } completionBlock:^{
                                                
                                            }];
                                            /** 读取联系人(部门条线) end **/
                                        });
                                    }
                                    
                                } failedBlock:^(NSError *error) {
                                    //
                                    
                                    if(self.delegate != nil){
                                        [(id)_delegate performSelector:@selector(endSync)];
                                    }
                                    DebugLog(@"%@",error);
                                } completionBlock:^{
                                    
                                }];
                                /** 读取联系人(基础) end **/
                            });
                        }
                    } failedBlock:^(NSError *error) {
                        //
                        if(self.delegate != nil){
                            [(id)_delegate performSelector:@selector(endSync)];
                        }
                        DebugLog(@"%@",error);
                    } completionBlock:^{
                        
                    }];
                    /** 读取机构目录 end **/
                    
                }); 

            } failedBlock:^(NSError *error) {
                if(self.delegate != nil){
                    [(id)_delegate performSelector:@selector(endSync)];
                }
                DebugLog(@"%@",error);
            } completionBlock:^{
                
            }];
            /** 读取当前联系人信息 end **/
        });
        
    }
}

- (void) doSettings:(id) sender{
    
}

- (void) doInfo:(id) sender{
    
}



@end
