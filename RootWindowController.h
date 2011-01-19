//
//  RootWindowController.h
//  WaQQ
//
//  Created by Ryan W. on 11-1-9.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "QUserInfoRequest.h"
#import "LOAuth.h"

@class NewsViewController;
@class ProfileController;
@class MailViewController;
@class User;

@interface RootWindowController : NSWindowController <QUserInfoRequestDelegate,NSToolbarDelegate,LOAuthDelegate>{

	NewsViewController	*newsViewController;
	ProfileController	*profileController;
	MailViewController	*mailViewController;
	
	IBOutlet id			headImageView;
	User				*me;
	NSDictionary		*profileDic;
	IBOutlet NSView		*rootView;
	IBOutlet NSToolbar	*toolbar;
	
}

@property (retain) IBOutlet NewsViewController *newsViewController;
@property (retain) IBOutlet ProfileController *profileController;
@property (retain) IBOutlet MailViewController *mailViewController;


- (IBAction)login:(id)sender;
- (IBAction)viewProfile:(id)sender;
- (IBAction)showMessages:(id)sender;
- (IBAction)search:(id)sender;
- (IBAction)showPrivateMail:(id)sender;

@end
