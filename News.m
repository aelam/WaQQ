//
//  News.m
//  WaQQ
//
//  Created by Ryan W. on 11-1-10.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import "News.h"


@implementation News

@synthesize text,origText,from,imageURL,timeStamp,newsType,isSentBySelf,sender,newsId,count;


- (void)dealloc {
//	self.text = nil;
//	self.origText = nil;
//	self.from = nil;
	[text release];
	[origText release];
	[from release];
	[imageURL release];
	[timeStamp release];
	[sender release];
	[super dealloc];
}

@end
