//
//  RootWindowController.h
//  WaQQ
//
//  Created by Ryan W. on 11-1-9.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "QUserInfoRequest.h"

@class NewsViewController;
@class ProfileController;
@class User;

@interface RootWindowController : NSWindowController <QUserInfoRequestDelegate,NSToolbarDelegate>{

	NewsViewController	*newsViewController;
	ProfileController	*profileController;
	IBOutlet id headImageView;
	User	*me;
	NSDictionary *profileDic;
	
}

@property (retain) IBOutlet NewsViewController *newsViewController;


- (IBAction)login:(id)sender;
- (IBAction)viewProfile:(id)sender;

@end
