//
//  ProfileController.m
//  WaQQ
//
//  Created by Ryan W. on 11-1-11.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import "ProfileController.h"


@implementation ProfileController

@synthesize userInfoDic;

- (void)awakeFromNib {
	
}

- (NSString *)windowNibName
{
	return @"ProfilePanel";
}

- (IBAction)done:(id)sender {
	[NSApp stopModal];
}

- (void)configureUserInfo:(NSDictionary *)aUserDic sender:(id)sender {
	//self.user = aUser
//	[userInfoDic release]; 
//	userInfoDic = [aUserDic retain];
	[self setUserInfoDic:aUserDic];
	[self setHead];
		
	NSWindow *window = [self window];
	
	[NSApp beginSheet:window modalForWindow:[sender window] modalDelegate:nil didEndSelector:nil contextInfo:nil];
	[NSApp runModalForWindow:window];
	// sheet is up here...
	
	[NSApp endSheet:window];
	[window orderOut:self];
}

/*
- (void)configureUserInfo:(User *)aUser sender:(id)sender {

	self.user = aUser;
	NSWindow *window = [self window];
	
	[NSApp beginSheet:window modalForWindow:[sender window] modalDelegate:nil didEndSelector:nil contextInfo:nil];
	[NSApp runModalForWindow:window];
	// sheet is up here...
	
	[NSApp endSheet:window];
	[window orderOut:self];
	
}
*/

- (void)setHead {
	NSURL *url = [NSURL URLWithString:[userInfoDic objectForKey:@"head"]];
	NSData *headData = [[NSData alloc] initWithContentsOfURL:url];
	RLog(@"%@",[userInfoDic objectForKey:@"headImage"]);		
	
	if (headData) {
		headImageView.image = [[[NSImage alloc] initWithData:headData] autorelease];
		[userInfoDic setObject:headData forKey:@"headImage"];
	}
}
/*
- (void)setPanelInfoByDic:(NSDictionary *)dic {
//	NSString *name = [dic objectForKey:@"name"];
	NSURL *url = [NSURL URLWithString:[dic objectForKey:@"head"]];
	headImageView.image = [[[NSImage alloc]initWithContentsOfURL:url] autorelease];
}
*/

- (void)setUserInfoDic:(NSDictionary *)aDic {
	[userInfoDic release];
	userInfoDic = [[NSMutableDictionary alloc] initWithDictionary:aDic];
}

@end
