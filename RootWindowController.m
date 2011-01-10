//
//  RootWindowController.m
//  WaQQ
//
//  Created by Ryan W. on 11-1-9.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import "RootWindowController.h"
#import "LOAuth.h"

@implementation RootWindowController

- (id)init {
	if (self = [super initWithWindowNibName:@"MainWindow.xib"]) {
		
	}
	return self;
}

- (IBAction)login:(id)sender {
	LOAuth *oauth = [[LOAuth alloc] initWithDelegate:self];
	[oauth startRequestToken];
	
}


@end
