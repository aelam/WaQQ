//
//  NewsViewController.m
//  WaQQ
//
//  Created by Ryan W. on 11-1-10.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsCell.h"
#import "QQTimeLineRequest.h"
#import "ImagePreviewCell.h"

@implementation NewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		//request.delegate = self;
	}
	return self;
}
- (void)awakeFromNib {
	//request = [[QQRequest alloc] init];
	request = [[QQTimeLineRequest alloc] init];
	request.delegate = self;
	RLog();

//	NSTableColumn *column =	[newsTable tableColumnWithIdentifier:@"NewsCellIdentifier"];
 //   NewsCell* newsCell = [[[NewsCell alloc] init] autorelease];
//	[column setDataCell:newsCell];
	//NSCell *newsCell = [[[NSCell alloc] init] autorelease];
//	[newsCell setImage:[NSImage imageNamed:@"test.png"]];
	//[column setDataCell:newsCell];
	//[newsCell action]
	//[column dataCellForRow:<#(NSInteger)row#>];
	//[NSTableColumn d]
		
	[request requestHomeTimelinewithFormat:@"JSON" pageflag:0 itemCount:30 time:0];
	
}


#pragma mark Request Delegate
- (void)responseWithNewsArray:(id )rs {
	RLog(@"%@",[[rs objectForKey:@"data"] objectForKey:@"info"]);
	id ar = [[rs objectForKey:@"data"] objectForKey:@"info"];
	[newsArrayController setContent:ar];
//	[newsArrayController setContent:[NSArray arrayWithObject:[NSDictionary dictionaryWithObject:@"OK" forKey:@"test"]]];
	
}




//- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
//{
//	return 10;//[accountArray count];
//}


- (BOOL)tableView:(NSTableView *)tableView isGroupRow:(NSInteger)row {
	return YES;
}

//- (void)outlineView:(NSOutlineView *)outlineView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn item:(id)item {
//	RLog();
//}


- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {

//	NSTableColumn *column = [tableView tableColumnWithIdentifier:@"head"];
//	if (column == tableColumn) {
//		RLog(@"= ");
//		return @"==";
//	}
	//User *user = [[User alloc] init];
	//return [user autorelease];
	return nil;
}


//- (NSCell *)tableView:(NSTableView *)tableView dataCellForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	
//	NSTableColumn *column = [tableView tableColumnWithIdentifier:@"head"];
//	if (column == tableColumn) {
//		NSImageCell *cell = [[NSImageCell alloc] init];
//		[cell setImage:[NSImage imageNamed:@"test.png"]];
//		return [cell autorelease];
//	} else {
//		return [[[NSTextFieldCell alloc] init] autorelease];
//	}

//	return cell;
//	if (row < 2) {
//		return [[[NewsCell alloc] init] autorelease];
//	} else {
//		return [[[ImagePreviewCell alloc] init] autorelease];
//	}
//}

//- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
//	if (row % 2 == 0) {
//		return 50.f;
//	}
//	return  100.f;
//}

-(NSString*)tableView: (NSTableView*)aTableView
	   toolTipForCell: (NSCell*)aCell
				 rect: (NSRectPointer)rect
		  tableColumn: (NSTableColumn*)aTableColumn
				  row: (NSInteger)row
		mouseLocation: (NSPoint)mouseLocation {
	return @"阿弥陀佛";
}

@end
