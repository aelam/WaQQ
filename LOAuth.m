//
//  LOAuth.m
//  iPhone Doudou
//

#import "LOAuth.h"
#import "NSString+Catalog.h"
#import "OADataFetcher.h"
#import "RLog.h"

@interface LOAuth (PRIVATE)

- (NSString *)requestTokenFromResponseBody:(NSString *)body;

@end


@implementation LOAuth

@synthesize consumer,hmacSha1Request,hmacSha1Request1,token,hmacSha1Provider,delegate;

- (id)initWithDelegate:(id<LOAuthDelegate>)d {
	if (self = [super init]) {
		self.delegate = d;
		consumer = [[OAConsumer alloc] initWithKey:API_KEY secret:API_SECRET];
		hmacSha1Provider = [[OAHMAC_SHA1SignatureProvider alloc] init];
	}
	return self;
}

- (void)dealloc {
//	self.webview = nil;
	self.delegate = nil;
	[consumer release];
	[hmacSha1Provider release];
	[hmacSha1Request release];
	[hmacSha1Request1 release];
	[token release];
	[super dealloc];
}


- (void)startRequestToken {
	//NSLog(@"[%d]:%s",__LINE__,__FUNCTION__);
	
	self.hmacSha1Request = [[OAMutableURLRequest alloc] 
									initWithURL:[NSURL URLWithString:REQUEST_TOKEN_STRING]
									consumer:consumer
									token:NULL
									realm:NULL
									callback:CALL_BACK_URL
									signatureProvider:hmacSha1Provider
							];
	OADataFetcher *fetcher = [[[OADataFetcher alloc] init] autorelease];
    [fetcher fetchDataWithRequest:hmacSha1Request 
			delegate:self
			didFinishSelector:@selector(requestTokenTicket:finishedWithData:)
			didFailSelector:@selector(requestTokenTicket:failedWithError:)
	];

}

// QQ NEEDS A VERIFIER 
- (void)startAccessOauthWithVerifier:(NSString *)verifier {
	
	if (hmacSha1Request1) {
		[hmacSha1Request1 release]; hmacSha1Request1 = nil;
	}
	self.hmacSha1Request1 = [[[OAMutableURLRequest alloc]
								initWithURL:[NSURL URLWithString:ACCESS_TOKEN_STRING]
								consumer:consumer
								token:token
								realm:NULL
								callback:NULL
								signatureProvider:hmacSha1Provider] 
								autorelease];
	self.hmacSha1Request1.verifier = verifier;
		
	OADataFetcher *fetcher = [[[OADataFetcher alloc] init] autorelease];
    [fetcher fetchDataWithRequest:hmacSha1Request1 
		delegate:self
		didFinishSelector:@selector(requestTokenTicket:finishedWithData:)
		didFailSelector:@selector(requestTokenTicket:failedWithError:)
	];
}



#pragma mark delegate
- (void)requestTokenTicket:(OAServiceTicket *)ticket finishedWithData:(NSMutableData *)data {
	
	if ([[ticket request] isEqual:hmacSha1Request]) {
		NSString *responseBody = [[NSString alloc] initWithData:data
													   encoding:NSUTF8StringEncoding];
		RLog(@"获得未授权的KEY:%@",responseBody);
		self.token = [[[OAToken alloc] initWithHTTPResponseBody:responseBody] autorelease];

		// WATCH THE USL SCHEMA
		[[NSAppleEventManager sharedAppleEventManager] setEventHandler:self andSelector:@selector(handleEvent:withReplyEvent:) forEventClass:kInternetEventClass andEventID:kAEGetURL];
		NSString *url = [NSString stringWithFormat:@"%@?%@",AUTHORIZE_STRING,responseBody];
		[responseBody release];

		[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:url]];
	}
	else if ([[ticket request] isEqual:hmacSha1Request1])
	{
		[[NSAppleEventManager sharedAppleEventManager] removeEventHandlerForEventClass:kInternetEventClass andEventID:kAEGetURL];
		NSString *responseBody = [[NSString alloc] initWithData:data
													   encoding:NSUTF8StringEncoding];
		NSLog(@"responseBody:%@",responseBody);
		[[NSUserDefaults standardUserDefaults] setValue:responseBody forKey:@"ACCESS_BODY"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		self.token = [[[OAToken alloc] initWithHTTPResponseBody:responseBody] autorelease];
		
		if ([delegate respondsToSelector:@selector(oauthDidFinish:)]) {
			[delegate oauthDidFinish:token];			
		}
	}
}

- (void)requestTokenTicket:(OAServiceTicket *)ticket failedWithError:(NSError *)error {
	NSLog(@"%@",error);
//	[self hideWebPage];
	// then show alertview
}



// TEST
- (void)handleEvent:(NSAppleEventDescriptor *)event withReplyEvent:(NSAppleEventDescriptor *)replyEvent {
	NSURL *url = [NSURL URLWithString:[[event paramDescriptorForKeyword:keyDirectObject] stringValue]];

	NSString *verifier = nil;
	
	if (!url) {
		// ERROR 
		return;
	}
	NSString *urlString = [url description];
	NSArray *pairs = [urlString componentsSeparatedByString:@"&"];
		
	for (NSString *pair in pairs) {
		NSArray *elements = [pair componentsSeparatedByString:@"="];
		if ([[elements objectAtIndex:0] isEqualToString:@"oauth_verifier"]) {
			verifier = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		}
	}	
	
	[self startAccessOauthWithVerifier:verifier];
}

- (NSString *)requestTokenFromResponseBody:(NSString *)body {
	NSString *requestToken = nil;
	NSString *requestToekenSecret = nil;
	NSString *verifier = nil;
	
	NSArray *pairs = [body componentsSeparatedByString:@"&"];
	
	for (NSString *pair in pairs) {
		NSArray *elements = [pair componentsSeparatedByString:@"="];
		if ([[elements objectAtIndex:0] isEqualToString:@"oauth_token"]) {
			requestToken = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		} else if ([[elements objectAtIndex:0] isEqualToString:@"oauth_verifier"]) {
			verifier = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		} else if ([[elements objectAtIndex:0] isEqualToString:@"oauth_token_secret"]) {
			requestToekenSecret = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		} 
	}
	
	return requestToken;
}

@end
