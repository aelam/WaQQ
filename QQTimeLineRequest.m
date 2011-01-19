//
//  QQTimeLineRequest.m
//  WaQQ
//
//  Created by Ryan W. on 11-1-19.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import "QQTimeLineRequest.h"
#import "JSON.h"

@implementation QQTimeLineRequest

@synthesize delegate = _delegate;

- (id)init {
	if (self = [super init]) {
		
	}
	
	return self;
}

- (void)dealloc {
	self.delegate = nil;
	[super dealloc];
}
	

static NSString *homeTimeLineBase = @"http://open.t.qq.com/api/statuses/home_timeline";
//static NSString *publicTimeLineBase = @"http://open.t.qq.com/api/statuses/public_timeline";
//static NSString *userTimeLineBase = @"http://open.t.qq.com/api/statuses/user_timeline";
//static NSString *mentionsTimeLineBase = @"http://open.t.qq.com/api/statuses/mentions_timeline";
//static NSString *htTimeLineBase = @"http://open.t.qq.com/api/statuses/ht_timeline";
//static NSString *broadcastTimeLineBase = @"http://open.t.qq.com/api/statuses/broadcast_timeline";

- (void)requestHomeTimelinewithFormat:(NSString *)format pageflag:(NSInteger)pageflag itemCount:(NSInteger)count time:(NSInteger)time {
	
	RLog();
	NSString *params = [NSString stringWithFormat:
						@"%@?format=%@&pageflag=%d&reqnum=%d&pagetime=%d",
						homeTimeLineBase,format,pageflag,count,time
						];
	NSURL *requestURL = [NSURL URLWithString:params];
	
	OAMutableURLRequest *hmacSha1Request = [[OAMutableURLRequest alloc] initWithURL:requestURL
																		   consumer:consumer
																			  token:token
																			  realm:NULL
																		   callback:NULL
																  signatureProvider:hmacSha1Provider
											];
	
	//	dispatch_queue_t *download_queue = dispatch_queue_create("Download Queu", NULL);
	//	dispatch_async(download_queue, ^{
	OADataFetcher *fetcher = [[[OADataFetcher alloc] init] autorelease];
	[fetcher fetchDataWithRequest:hmacSha1Request 
						 delegate:self
				didFinishSelector:@selector(requestTokenTicket:finishedWithData:)
				  didFailSelector:@selector(requestTokenTicket:failedWithError:)
	 ];
	//		
	//	})	
}

- (void)requestTokenTicket:(OAServiceTicket *)ticket finishedWithData:(NSMutableData *)data {
	//	NSString *responseBody = [[NSString alloc] initWithData:data
	//												   encoding:NSUTF8StringEncoding];
	//RLog(@"responseBody:%@",responseBody);
	SBJsonParser *parser = [[SBJsonParser new] autorelease];
	id rs = [parser objectWithData:data];
	//RLog(@"responseBody : %@",rs);
	
		if ([_delegate respondsToSelector:@selector(responseWithNewsArray:)]) {
			[_delegate responseWithNewsArray:rs];
		}
	
	
}

- (void)requestTokenTicket:(OAServiceTicket *)ticket failedWithError:(NSError *)error {
	RLog(@"%@",error);
	//	[self hideWebPage];
	// then show alertview
}



@end
