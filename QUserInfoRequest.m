//
//  QUserInfoRequest.m
//  WaQQ
//
//  Created by Ryan W. on 11-1-11.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import "QUserInfoRequest.h"
#import "RLog.h"
#import "JSON.h"
#import "NSObject+Collection.h"

static NSString *myInfoBase = @"http://open.t.qq.com/api/user/info";
static NSString *myInfoUpdateBase = @"http://open.t.qq.com/api/user/update";
static NSString *myHeadUpdateBase = @"http://open.t.qq.com/api/user/update_head";
// http://open.t.qq.com/api/user/other_info?format=json&name=xxxx <----need User name
static NSString *othersInfoBase = @"http://open.t.qq.com/api/user/other_info";


@implementation QUserInfoRequest

@synthesize delegate;

- (id)initWithDelegate:(id<QUserInfoRequestDelegate> )aDelegate {
	if (self = [super init]) {
		self.delegate = aDelegate;
	}
	return self;
}

- (void)dealloc {
	self.delegate = nil;
	[super dealloc];
}


- (void)requestMyProfileWithJSONFormat {
	[self requestMyProfileWithFormat:@"json"];
}

- (void)requestMyProfileWithFormat:(NSString *)format {
	NSString *params = [NSString stringWithFormat:@"%@?format=%@",myInfoBase,format];
	NSURL *requestURL = [NSURL URLWithString:params];

	OAMutableURLRequest *hmacSha1Request = [[[OAMutableURLRequest alloc] initWithURL:requestURL
										consumer:consumer
										token:self.token
										realm:NULL
										callback:NULL
										signatureProvider:hmacSha1Provider
									] autorelease];
	OAAsynchronousDataFetcher *fetcher = [[[OAAsynchronousDataFetcher alloc]
										  initWithRequest:hmacSha1Request
										  delegate:self
										  didFinishSelector:@selector(requestTokenTicket:finishedWithData:) 
										  didFailSelector:@selector(requestTokenTicket:failedWithError:)
										] autorelease];
	[fetcher start];
}

- (void)requestUserProfileWithName:(NSString *)name format:(NSString *)format {
	NSString *params = [NSString stringWithFormat:@"%@?format=%@&name=%@",othersInfoBase,format,name];
	NSURL *requestURL = [NSURL URLWithString:params];
	
	OAMutableURLRequest *hmacSha1Request = [[[OAMutableURLRequest alloc] initWithURL:requestURL
																		   consumer:consumer
																			  token:self.token
																			  realm:NULL
																		   callback:NULL
																  signatureProvider:hmacSha1Provider
											] autorelease];
	OAAsynchronousDataFetcher *fetcher = [[[OAAsynchronousDataFetcher alloc]
										  initWithRequest:hmacSha1Request
										  delegate:self
										  didFinishSelector:@selector(requestTokenTicket:finishedWithData:) 
										  didFailSelector:@selector(requestTokenTicket:failedWithError:)
										  ] autorelease];
	[fetcher start];
	
}


- (void)requestTokenTicket:(OAServiceTicket *)ticket finishedWithData:(NSMutableData *)data {
	NSString *responseBody = [[NSString alloc] initWithData:data
												   encoding:NSUTF8StringEncoding];
	RLog(@"responseBody:%@",responseBody);
	SBJsonParser *parser = [[SBJsonParser new] autorelease];
	id rs = [parser objectWithData:data];
	if (!rs) return;
	RLog(@"is Dictionary :rs %@, %d",rs,[rs isNSDictionary],rs);
	if (![rs isNSDictionary]) return;
	NSDictionary *level1 = [(NSDictionary *)rs objectForKey:@"data"];
	if ([delegate respondsToSelector:@selector(requestUserInfoStatus:userDic:)]) {
		[delegate requestUserInfoStatus:YES userDic:level1];
	}
		
}

- (void)requestTokenTicket:(OAServiceTicket *)ticket failedWithError:(NSError *)error {
	NSLog(@"%@",error);
	//	[self hideWebPage];
	// then show alertview
	if ([delegate respondsToSelector:@selector(requestUserInfoStatus:userDic:)]) {
		[delegate requestUserInfoStatus:NO userDic:nil];
	}
}

@end
