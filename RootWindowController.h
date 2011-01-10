//
//  RootWindowController.h
//  WaQQ
//
//  Created by Ryan W. on 11-1-9.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface RootWindowController : NSWindowController {
	IBOutlet WebView *webview;
}

- (IBAction)login:(id)sender;

@end
