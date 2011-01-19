//
//  RootWindowController.m
//  WaQQ
//
//  Created by Ryan W. on 11-1-9.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import "RootWindowController.h"
#import "NewsViewController.h"
#import "QQRequest.h"
#import "ProfileController.h"
#import "MailViewController.h"
#import "ATPopupWindow.h"

@implementation RootWindowController

@synthesize newsViewController,profileController,mailViewController;

- (void)requestUserInfoStatus:(BOOL)status userDic:(NSDictionary *)aUserDic {
	RLog("%@",aUserDic);
	[profileDic release];
	profileDic = [aUserDic retain];
}


- (void)dealloc {
	self.newsViewController = nil;
	self.profileController = nil;
	self.mailViewController = nil;
	[super dealloc];
}

- (id)init {
	if (self = [super initWithWindowNibName:@"MainWindow"]) {
		QUserInfoRequest *request = [[[QUserInfoRequest alloc] initWithDelegate:self] autorelease];
		[request requestMyProfileWithJSONFormat];
	}
	return self;
}

- (void)awakeFromNib {

    //NSToolbar *toolbar=[[[NSToolbar alloc] initWithIdentifier:@"myToolbar"] autorelease];
    //[toolbar setDelegate:self];
    //[toolbar setAllowsUserCustomization:NO];
	//[toolbar setAutosavesConfiguration: YES]; 
    //[toolbar setDisplayMode: NSToolbarDisplayModeDefault];
    // install the toolbar.
    //[self.window setToolbar:toolbar];
	//[self.window setShowsToolbarButton:YES];
	//[toolbar setVisible:YES];
	
	//Default set all Messages
	[rootView addSubview:newsViewController.view];

}

- (NSString *)windowTitleForDocumentDisplayName:(NSString *)displayName {
	RLog(@"%@",displayName);
	return @"QQ 微博";
}


- (IBAction)login:(id)sender {
	LOAuth *oauth = [[LOAuth alloc] initWithDelegate:self];
	[oauth startRequestToken];
}

- (IBAction)viewProfile:(id)sender {
	RLog();
	
	if (profileController == nil) {
		profileController = [[ProfileController alloc] init];
	}
	[profileController configureUserInfo:profileDic sender:self];

}

- (IBAction)showMessages:(id)sender {
	[rootView addSubview:newsViewController.view];
}

- (IBAction)search:(id)sender {
	NSRect viewFrame = rootView.frame;
	// Create and setup our window
	ATPopupWindow *_window = [[ATPopupWindow alloc] initWithContentRect:viewFrame styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:NO];
	[_window setReleasedWhenClosed:NO];
	[_window setLevel:NSPopUpMenuWindowLevel];
	[_window setHasShadow:YES];        
	//[[_window contentView] addSubview:rootView];
	[_window makeFirstResponder:rootView];
	
	// Make the window have a clear color and be non-opaque for our pop-up animation
	[_window setBackgroundColor:[NSColor clearColor]];
	[_window setOpaque:NO];
	
	[_window popup];

}

- (IBAction)showPrivateMail:(id)sender {
	[rootView addSubview:mailViewController.view];
}


@end
