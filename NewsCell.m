//
//  NewsCell.m
//  WaQQ
//
//  Created by Ryan W. on 11-1-11.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import "NewsCell.h"


@implementation NewsCell

- (id) init {
	
	if (self = [super init]) {
		[self setEnabled:NO];
	}
	return self;
}

- (id)copyWithZone:(NSZone*)zone {
    NewsCell* newCopy = [[NewsCell alloc] init];
    return newCopy;
}

- (void)drawRect:(NSRect)dirtyRect {
    // Drawing code here.
}

@end
