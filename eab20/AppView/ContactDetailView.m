//
//  ContactDetailView.m
//  eab20
//
//  Created by zppro on 13-12-29.
//  Copyright (c) 2013年 zppro. All rights reserved.
//

#import "ContactDetailView.h"
#import "CContactInfo.h"

@interface ContactDetailView ()
@property (nonatomic, retain) UITableView  *myTableView;
@property (nonatomic, retain) CContactInfo  *dataItem;
@end

@implementation ContactDetailView
@synthesize myTableView;
@synthesize dataItem;

- (void)dealloc {
    self.myTableView = nil;
    self.dataItem = nil;
    [super dealloc];
}


- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame andData:nil];
}

- (id)initWithFrame:(CGRect)frame andData:(CContactInfo*) theDataItem{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.dataItem = theDataItem;
        self.backgroundColor = [UIColor whiteColor];
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(5, 12, frame.size.width-10, 73)];
        [self addSubview:headView];
        [headView release];
        
        UIView *headPortraitContainer = [[UIView alloc] initWithFrame:CGRectMake(10.f, 0, 73, 73)];
        headPortraitContainer.backgroundColor =  MF_ColorFromRGB(234, 236, 237);
        [headView addSubview:headPortraitContainer];
        [headPortraitContainer release];
        
        UIImageView *headPortrait = [[UIImageView alloc] initWithFrame:CGRectMake((73-58)/2.f, (73-58)/2.f, 58.f, 58.f)];
        headPortrait.image = MF_PngOfDefaultSkin(@"head-portrait2.png");
        headPortrait.layer.borderWidth = 2;
        headPortrait.layer.borderColor = [UIColor whiteColor].CGColor;
        headPortrait.layer.cornerRadius = CGRectGetHeight(headPortrait.bounds) / 2;
        headPortrait.clipsToBounds = YES;
        [headPortraitContainer addSubview:headPortrait];
        [headPortrait release];
        
        
        UILabel *nameView = [[UILabel alloc] initWithFrame:CGRectMake(90, 10.f, 122.f, 20.f)];
        nameView.textColor = [UIColor blackColor];
        nameView.textAlignment = UITextAlignmentLeft;
        nameView.backgroundColor = [UIColor clearColor];
        nameView.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];//[UIFont systemFontOfSize:16];//
        nameView.text = self.dataItem.contactName;
        [headView addSubview:nameView];
        [nameView release];
        
        UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(90, 30.f, 122.f, 20.f)];
        titleView.textColor = [UIColor blackColor];
        titleView.textAlignment = UITextAlignmentLeft;
        titleView.backgroundColor = [UIColor clearColor];
        titleView.font = [UIFont fontWithName:@"Helvetica" size:12];//[UIFont systemFontOfSize:16];//
        titleView.text = self.dataItem.title;
        [headView addSubview:titleView];
        [titleView release];
        
        UIView *split1 = [[UIView alloc] initWithFrame:CGRectMake((headView.width-183.5)/2.f, 89, 183.5, 1)];
        split1.backgroundColor = MF_ColorFromRGB(136, 136, 137);
        [self addSubview:split1];
        [split1 release];
        
        myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 90.0f, headView.width,frame.size.height - 90)];
        myTableView.delegate = self;
        myTableView.dataSource = self;
        myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:myTableView]; 
        
    }
    return self;
}

#pragma mark - UITableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

static NSString *aCell=@"myCell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:aCell];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:aCell] autorelease];
        UIImageView *splitView = [[UIImageView alloc] initWithFrame:CGRectMake((myTableView.width-183.5)/2.f, 30-2, 183.5f, 2)];
        splitView.image = MF_PngOfDefaultSkin(@"split2.png");
        [cell addSubview:splitView];
        [splitView release];
        
        UILabel *titleCellView = [[UILabel alloc] initWithFrame:CGRectMake(splitView.left, (30-20.f)/2.f, 75, 20.f)];
        titleCellView.textColor = MF_ColorFromRGB(136, 137, 140);
        titleCellView.textAlignment = UITextAlignmentLeft;
        titleCellView.backgroundColor = [UIColor clearColor];
        titleCellView.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];//[UIFont systemFontOfSize:16];//
        [cell addSubview:titleCellView];
        [titleCellView release];
        
        UILabel *valueCellView = [[UILabel alloc] initWithFrame:CGRectMake(splitView.left+85, (30-20.f)/2.f, 100, 20.f)];
        valueCellView.textColor = [UIColor blackColor];
        valueCellView.textAlignment = UITextAlignmentLeft;
        valueCellView.backgroundColor = [UIColor clearColor];
        valueCellView.font = [UIFont fontWithName:@"Helvetica" size:14];//[UIFont systemFontOfSize:16];//
        [cell addSubview:valueCellView];
        [valueCellView release];
        
        if(indexPath.row==0){
            titleCellView.text = @"部门:";
            titleCellView.width = 40;
            valueCellView.text = MF_Replace(self.dataItem.directoryPath, @",", @"");
        }
        else if(indexPath.row==1){
            titleCellView.text = @"门牌号:";
            titleCellView.width = 50;
            valueCellView.text = MF_Replace(self.dataItem.doorNo, @",", @"");
        }
        else if (indexPath.row == 2){
            titleCellView.text = @"办公室电话:";
            titleCellView.width = 80;
            valueCellView.text = MF_Replace(self.dataItem.dTel, @",", @"");
        }
        else if (indexPath.row == 3){
            titleCellView.text = @"办公室短号:";
            titleCellView.width = 80;
            valueCellView.text = MF_Replace(self.dataItem.dTelShort, @",", @"");
        }
        else if (indexPath.row == 4){
            titleCellView.text = @"手机:";
            titleCellView.width = 40;
            valueCellView.text = MF_Replace(self.dataItem.mobile, @",", @"");
        }
        else if (indexPath.row == 5){
            titleCellView.text = @"手机短号:";
            titleCellView.width = 70;
            valueCellView.text = MF_Replace(self.dataItem.mobileShort, @",", @"");
        }
        else if (indexPath.row == 6){
            titleCellView.text = @"电子邮件:";
            titleCellView.width = 70;
            valueCellView.text = MF_Replace(self.dataItem.eMail, @",", @"");
        }
        valueCellView.left = titleCellView.left+titleCellView.width;
        valueCellView.width = splitView.width - titleCellView.width;
        //DebugLog(@"%@:%f",titleCellView.text,valueCellView.width);
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
