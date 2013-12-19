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

@end

@implementation ActionSideBarController
- (void)dealloc { 
    [super dealloc];
}

- (void)loadView{
    [super loadView];
    self.view.width = ActionSideBarWidth;
    self.view.backgroundColor = [UIColor whiteColor];
    
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
}

- (void) doSearch:(id) sender{
    
}

- (void) doSync:(id) sender{
    if(isActiviated && isAuthorized){
        [self showWaitViewWithTitle:@"同步机构目录..."];
        
        NSDictionary *head = [NSDictionary dictionaryWithObjectsAndKeys:appSession.token,@"Token",invokeToAppId,@"ApplicationIdTo",appSession.du,@"DU",appSession.sdn,@"SDN",nil];
        HttpAppRequest *req = buildReq2(head);
        [HttpAppAsynchronous httpGetWithUrl:[appSession getBizUrl:BIT_SyncDirectory] req:req sucessBlock:^(id result) {
            if([CDirectoryInfo updateAll:(NSArray*)((HttpAppResponse*)result).rows]){
                /** 读取联系人(基础) start **/
                [self updateWaitViewWithTitle:@"同步联系人(基础)..."];
                [HttpAppAsynchronous httpGetWithUrl:[appSession getBizUrl:BIT_SyncContactBySelf] req:req sucessBlock:^(id result) {
                    
                    if([CContactInfo updateWithData:(NSArray*)((HttpAppResponse*)result).rows ByType:UpdateSourceType_BySelf]){
                    
                        /** 读取联系人(部门条线) start **/
                        [self updateWaitViewWithTitle:@"同步联系人(部门条线)..."];
                        [HttpAppAsynchronous httpGetWithUrl:[appSession getBizUrl:BIT_SyncContactByDLine] req:req sucessBlock:^(id result) {
                            
                            if([CContactInfo updateWithData:(NSArray*)((HttpAppResponse*)result).rows ByType:UpdateSourceType_ByDLine]){
                            
                                /** 读取联系人(高管条线) start **/
                                [self updateWaitViewWithTitle:@"同步联系人(高管条线)..."];
                                [HttpAppAsynchronous httpGetWithUrl:[appSession getBizUrl:BIT_SyncContactBySELine] req:req sucessBlock:^(id result) {
                                    [CContactInfo updateWithData:(NSArray*)((HttpAppResponse*)result).rows ByType:UpdateSourceType_BySELine];
                                    [self updateWaitViewWithTitle:@"同步成功"];
                                } failedBlock:^(NSError *error) {
                                    //
                                    DebugLog(@"%@",error);
                                } completionBlock:^{
                                    [self closeWaitView];
                                }];
                                /** 读取联系人(高管条线) end **/
                            }
                            
                        } failedBlock:^(NSError *error) {
                            //
                            [self closeWaitView];
                            DebugLog(@"%@",error);
                        } completionBlock:^{
                            
                        }];
                        /** 读取联系人(部门条线) end **/
                    }
                    
                } failedBlock:^(NSError *error) {
                    //
                    [self closeWaitView];
                    DebugLog(@"%@",error);
                } completionBlock:^{
                    
                }];
                /** 读取联系人(基础) end **/
            }
        } failedBlock:^(NSError *error) {
            //
            [self closeWaitView];
            DebugLog(@"%@",error);
        } completionBlock:^{
            
        }];
    }
}

- (void) doSettings:(id) sender{
    
}

- (void) doInfo:(id) sender{
    
}

@end
