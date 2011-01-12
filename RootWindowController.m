//
//  RootWindowController.m
//  WaQQ
//
//  Created by Ryan W. on 11-1-9.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import "RootWindowController.h"
#import "LOAuth.h"
#import "NewsViewController.h"
#import "QQRequest.h"
#import "ProfileController.h"

@implementation RootWindowController

@synthesize newsViewController;

- (void)requestUserInfoStatus:(BOOL)status userDic:(NSDictionary *)aUserDic {
	RLog("%@",aUserDic);
	[profileDic release];
	profileDic = [aUserDic retain];
}


- (void)dealloc {
	self.newsViewController = nil;
	[super dealloc];
}

- (id)init {
	if (self = [super initWithWindowNibName:@"MainWindow"]) {
		QUserInfoRequest *request = [[[QUserInfoRequest alloc] initWithDelegate:self] autorelease];
		//RLog();
		[request requestMyProfileWithJSONFormat];
	}
	return self;
}

- (void)awakeFromNib {

    NSToolbar *toolbar=[[[NSToolbar alloc] initWithIdentifier:@"myToolbar"] autorelease];
    [toolbar setDelegate:self];
    [toolbar setAllowsUserCustomization:NO];
	[toolbar setAutosavesConfiguration: YES]; 
    [toolbar setDisplayMode: NSToolbarDisplayModeDefault];
    // install the toolbar.
    [self.window setToolbar:toolbar];
	[self.window setShowsToolbarButton:NO];
	[toolbar setVisible:YES];
}

- (NSString *)windowTitleForDocumentDisplayName:(NSString *)displayName {
	RLog(@"%@",displayName);
	return @"QQ 微博";
}


- (IBAction)login:(id)sender {
	
}

- (IBAction)viewProfile:(id)sender {
	RLog();
	
	if (profileController == nil) {
		profileController = [[ProfileController alloc] init];
	}
	[profileController configureUserInfo:profileDic sender:self];

}

@end
