//
//  PostViewController.m
//  WaQQ
//
//  Created by Ryan W. on 11-1-11.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import "PostViewController.h"
#import "QMessagePoster.h"

@implementation PostViewController

#pragma mark --
// GET COMPUTER IP


- (IBAction)post:(id)sender {
	NSHost *host = [NSHost currentHost];
	RLog(@"%@",[host addresses]);
	QMessagePoster *poster = [[QMessagePoster alloc] init];
	RLog(@"%@",postField.stringValue);
	if (postField.stringValue) {
		[poster postMessage:postField.stringValue format:@"json" clientIP:@"202.1.1.1" longitude:@"120.0" latitude:@"140.0"];		
	}
}

@end
