//
//  PostViewController.h
//  WaQQ
//
//  Created by Ryan W. on 11-1-11.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PostViewController : NSViewController {
	IBOutlet NSTextField *postField;
}

- (IBAction)post:(id)sender;

@end
