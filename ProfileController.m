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
	[self setHead:^(NSImage *image) {
		headImageView.image = image;
	}];
		
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
- (void)setHead:(void(^)(NSImage *image))myBlock {
	
	dispatch_queue_t current_queue = dispatch_get_current_queue();
	dispatch_queue_t download_queue = dispatch_queue_create("com.yuxi.download",NULL);
	
	dispatch_async(download_queue,^{
		NSString *imageURL = [userInfoDic objectForKey:@"head"];
		NSString *imageURL40Pixel = [imageURL stringByAppendingString:@"/40"];
		NSURL *url = [NSURL URLWithString:imageURL40Pixel];
		NSImage *image = [[[NSImage alloc] initWithContentsOfURL:url] autorelease];
		dispatch_async(current_queue,^{
			myBlock(image);
		});
	});
	
	dispatch_release(download_queue);
	
}


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
