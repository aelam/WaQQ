//
//  ProfileController.h
//  WaQQ
//
//  Created by Ryan W. on 11-1-11.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class User;

@interface ProfileController : NSWindowController {
	IBOutlet NSImageView *headImageView;
	IBOutlet NSForm *baseInfoForm;
	IBOutlet NSForm *NumForm;
	IBOutlet NSForm *TagForm;
	
	User *user;
	NSMutableDictionary *userInfoDic;
	
	IBOutlet NSDictionaryController *dicController;
}

@property (retain) 	NSMutableDictionary *userInfoDic;

- (IBAction)done:(id)sender;

- (void)configureUserInfo:(NSDictionary *)aUser sender:(id)sender;

@end
