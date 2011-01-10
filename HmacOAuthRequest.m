//
//  HmacOAuthRequest.m
//  WaQQ
//
//  Created by Ryan W. on 11-1-9.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import "HmacOAuthRequest.h"
#import "NSString+Catalog.h"
#import "Signaturer.h"
#import "OARequestParameter.h"

@implementation HmacOAuthRequest

@synthesize key = _key;
@synthesize token = _token;
//@synthesize signatureMethod = _signatureMethod;
//@synthesize httpMethod = _httpMethod;
@synthesize timestamp = _timestamp;
@synthesize nonce = _nonce;	
@synthesize otherParams = _otherParams;	

//static NSString const *signatureMethod = @"HMAC-SHA1";
#define SIGNATURE_METHOD	@"HMAC-SHA1"
#define OAUTH_VERSION		@"1.0"

- (id)initWithURL:(NSURL *)URL key:(NSString *)aKey token:(NSString *)atoken httpMethod:(NSString *)aHttpMethod otherParams:(NSDictionary *)likeCallBack {
	if (aKey == nil ) {
		RLog(@"Please provide your appKey and Your appSecret");
		exit(1);
	}
	if (self = [super initWithURL:URL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.f]) {
		self.URL = URL;
		self.key = aKey;
		self.token = atoken;
		self.HTTPMethod = aHttpMethod;
		self.otherParams = likeCallBack;
		self.timestamp = [NSString timeStamp];
		self.nonce = [NSString nonce];
		self.otherParams = likeCallBack;
	}
	
	[self prepareSignature];
	return self;
}

- (void)prepareSignature {
//	RLog();
	NSString *callback = @"http://www.baidu.com";
	
	//self.HTTPMethod
	NSMutableDictionary *info = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								 self.key,@"oauth_consumer_key",
								 SIGNATURE_METHOD,@"oauth_signature_method",
								 self.timestamp,@"oauth_timestamp",
								 self.nonce,@"oauth_nonce",
								 OAUTH_VERSION,@"oauth_version",
								 nil];	
	
	if (self.otherParams) {
		[info addEntriesFromDictionary:self.otherParams];
	} else {
		[info setObject:callback forKey:@"oauth_callback"];
	}
	
	NSString *tokenInHeader = nil;
	if (self.token) {
		[info setObject:self.token forKey:@"oauth_token"];
		tokenInHeader = [NSString stringWithFormat:@"&oauth_token=%@",[self.token URLEncodedString]];
	}else {
		self.token = @"";
		tokenInHeader = @"";
	}

	
	RLog();
//	NSString *base = [self generateBaseStringWithParams:info];
	NSString *base = [self _signatureBaseString];
	RLog(@"base : %@",base);
	NSString *clearText = [NSString stringWithFormat:@"%@&%@&%@",self.HTTPMethod,[[self.URL description] URLEncodedString],[base URLEncodedString]];
	RLog(@"clearText : %@",clearText);
	
	NSString *sign = [Signaturer signClearText:clearText withSecret:[NSString stringWithFormat:@"%@&%@",self.key,self.token]];
	[info setObject:sign forKey:@"oauth_signature"];
	RLog(@"info : %@",info);

	
//	NSString *oauthHeader = [self generateBaseStringWithParams:info];
    NSString *oauthHeader = [NSString stringWithFormat:@"oauth_consumer_key=%@%@&oauth_signature_method=%@&oauth_signature=%@&oauth_timestamp=%@&oauth_nonce=%@&oauth_version=1.0&oauth_callback=%@",
                             //[realm URLEncodedString],
                             [self.key URLEncodedString],
                             [tokenInHeader URLEncodedString],
                             [SIGNATURE_METHOD URLEncodedString],
                             [sign URLEncodedString],
                             self.timestamp,
                             [self.nonce URLEncodedString],
							 [@"http://www.baidu.com" URLEncodedString]];
	
	NSString *newURL = [NSString stringWithFormat:@"%@?%@",self.URL,oauthHeader];
	RLog(@"newURL : %@",newURL);
	
	self.URL = [NSURL URLWithString:newURL];
	RLog(@"self.URL : %@",self.URL);

}

- (NSString *)_signatureBaseString 
{
    // OAuth Spec, Section 9.1.1 "Normalize Request Parameters"
    // build a sorted array of both request parameters and OAuth header parameters
    NSMutableArray *parameterPairs = [NSMutableArray  arrayWithCapacity:7]; // 6 being the number of OAuth params in the Signature Base String
    
	[parameterPairs addObject:[[OARequestParameter requestParameterWithName:@"oauth_consumer_key" value:self.key] URLEncodedNameValuePair]];
	[parameterPairs addObject:[[OARequestParameter requestParameterWithName:@"oauth_signature_method" value:SIGNATURE_METHOD]URLEncodedNameValuePair]];
	[parameterPairs addObject:[[OARequestParameter requestParameterWithName:@"oauth_timestamp" value:self.timestamp] URLEncodedNameValuePair]];
	[parameterPairs addObject:[[OARequestParameter requestParameterWithName:@"oauth_nonce" value:self.nonce] URLEncodedNameValuePair]];
	[parameterPairs addObject:[[OARequestParameter requestParameterWithName:@"oauth_version" value:@"1.0"] URLEncodedNameValuePair]];
	
	//
	[parameterPairs addObject:[[OARequestParameter requestParameterWithName:@"oauth_callback" value:@"http:www.baidu.com"] URLEncodedNameValuePair]];
		
    if (![self.token isEqualToString:@""]) {
        [parameterPairs addObject:[[OARequestParameter requestParameterWithName:@"oauth_token" value:self.key] URLEncodedNameValuePair]];
    }
    
    for (OARequestParameter *param in [self parameters]) {
        [parameterPairs addObject:[param URLEncodedNameValuePair]];
    }
    
    NSArray *sortedPairs = [[NSArray arrayWithArray:parameterPairs] sortedArrayUsingSelector:@selector(compare:)];
    NSString *normalizedRequestParameters = [sortedPairs componentsJoinedByString:@"&"];
    
    // OAuth Spec, Section 9.1.2 "Concatenate Request Elements"
    NSString *ret = [NSString stringWithFormat:@"%@&%@&%@",
					 [self HTTPMethod],
					 [[[self URL] URLStringWithoutQuery] URLEncodedString],
					 [normalizedRequestParameters URLEncodedString]];
	
	return ret;
}


- (NSString *)generateBaseStringWithParams:(NSDictionary *)info {
	NSArray *temp = [[info allKeys] sortedArrayUsingSelector:@selector(compare:)];
	NSMutableArray *pairs = [NSMutableArray array];
	for(NSString *e in temp) {
		[pairs addObject:[NSString stringWithFormat:@"%@=%@",e,[[info objectForKey:e]URLEncodedString]]];
	}
	
	NSString *all = [pairs componentsJoinedByString:@"&"];
	RLog(@"pairs : %@",all);
	return all;
}

//- (NSString *)urlParams:(NSDictionary *)info {
//	
//}

- (void)dealloc {
	self.key = nil;
	self.token = nil;
//	self.signatureMethod = nil;
//	self.HTTPMethod = nil;
	self.nonce = nil;
	self.timestamp = nil;
	self.otherParams = nil;	
	[super dealloc];
}

@end
