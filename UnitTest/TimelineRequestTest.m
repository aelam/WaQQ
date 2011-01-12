//
//  TestTimelineRequest.m
//  WaQQ
//
//  Created by Ryan W. on 11-1-10.
//  Copyright 2011 Apple Inc. All rights reserved.
//

//#import "TestTimelineRequest.h"
#import <GHUnit/GHUnit.h>
#import "QQRequest.h"

@interface TimelineRequestTest : GHTestCase {
	QQRequest *request;
}

@end


@implementation TimelineRequestTest

- (void)setUp {
	request = [[QQRequest alloc] init];
}

- (void)testHomeTimeLine {
	[request requestHomeTimelinewithFormat:@"json" pageflag:0 itemCount:2 time:0];
}

- (void)tearDown {
	[request release];
}

@end
