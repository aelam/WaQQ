//
//  NewsCell.m
//  WaQQ
//
//  Created by Ryan W. on 11-1-11.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import "NewsCell.h"


@implementation NewsCell

@synthesize headImage =  _headImage;
@synthesize title = _title;
@synthesize message = _message;
@synthesize image = _image;
@synthesize news;


- (id)init {
    self = [super init];
    if (self != nil) {
        [self setLineBreakMode:NSLineBreakByTruncatingTail];
		RLog();
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
	return self;
}

// NSTableView likes to copy a cell before tracking -- therefore we need to properly implement copyWithZone.
- (id)copyWithZone:(NSZone *)zone {
    NewsCell *result = [super copyWithZone:zone];
    if (result != nil) {

    }
    return result;
}

- (void)setObjectValue:(id <NSCopying>)obj {
	//RLog();
	[super setObjectValue:obj];
}

- (void)drawInteriorWithFrame:(NSRect)bounds inView:(NSView *)controlView {
//	if (news) {
//		RLog(@"%@",news);
//	}
//	
//	NSButton* button = [[NSButton alloc] initWithFrame:NSMakeRect(100, 20, 100, 20)];
//    [button setTitle:@"Click me!"];
//    [button setBezelStyle:NSRoundRectBezelStyle];
//    [controlView addSubview:button];
//    
//    NSString *test = @"show";
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    [test drawAtPoint:NSMakePoint(1, 1) 
//       withAttributes:attrs];
	NSRect imageRect = NSRectFromCGRect(CGRectMake(5, 5, 32, 32));
	//RLog(@"%@",NSStringFromRect(bounds));
	NSImage *image = [NSImage imageNamed:@"test.png"];
	[image drawInRect:imageRect fromRect:NSZeroRect operation:NSCompositeSourceIn fraction:1.0];
	
	// Name
	NSString *name = @"Test";
	[name drawAtPoint:NSMakePoint(50, 5) withAttributes:nil];
	
	//Message
	NSString *message = @"Message :2011-01-17 16:09:18.501 WaQQ[54255:a0f] [LINE:49] -[NewsCell setObjectValue:] ";
	[message drawInRect:NSRectFromCGRect(CGRectMake(50, 20, 200, 40)) withAttributes:nil];

	// Reply 
//	NSButton* button = [[NSButton alloc] initWithFrame:NSMakeRect(100, 20, 100, 20)];
//    [button setTitle:@"Click me!"];
//    [button setBezelStyle:NSRoundRectBezelStyle];
//    [controlView addSubview:button];
//	[button release];
//	[button ]
	
	// Retweet 
//	NSButton* button = [[NSButton alloc] initWithFrame:NSMakeRect(100, 20, 100, 20)];
//    [button setTitle:@"Click me!"];
//    [button setBezelStyle:NSRoundRectBezelStyle];
//    [controlView addSubview:button];
	
	//NSBu	

}



- (void)dealloc {
//	[_headImage release];
//	[_title release];
//	[_message release];
//	[_image release];
	[super dealloc];
}
	

@end
