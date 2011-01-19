//
//  NewsViewController.h
//  WaQQ
//
//  Created by Ryan W. on 11-1-10.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class QQTimeLineRequest;

@interface NewsViewController : NSViewController <NSTableViewDelegate,NSTableViewDataSource>{
	IBOutlet NSTableView *newsTable;
	IBOutlet NSArrayController *newsArrayController;
	
	QQTimeLineRequest *request;
}

@end
