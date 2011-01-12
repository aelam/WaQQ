//
//  News.m
//  WaQQ
//
//  Created by Ryan W. on 11-1-10.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import "News.h"


@implementation News

@synthesize text,origText,from,imageURL,newsType,isSentBySelf,sender,newsId,count;


- (void)dealloc {
	self.text = nil;
	self.origText = nil;
	self.from = nil;
	[super dealloc];
}

@end
