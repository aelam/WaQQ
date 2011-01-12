//
//  NewsViewController.m
//  WaQQ
//
//  Created by Ryan W. on 11-1-10.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsCell.h"

@implementation NewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		
	}
	return self;
}

- (void)awakeFromNib {
	RLog();
	NSTableColumn *column =	[newsTable tableColumnWithIdentifier:@"NewsCellIdentifier"];
    NewsCell* newsCell = [[[NewsCell alloc] init] autorelease];
	[column setDataCell:newsCell];
}




@end
