//
//  LOAuthRequest.m
//  WaQQ
//
//  Created by Ryan W. on 11-1-8.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import "LOAuthRequest.h"
#import "Signaturer.h"
#import "NSString+Catalog.h"
#import "Key.h"

@implementation LOAuthRequest

//@synthesize url = _url;
@synthesize key = _key;
@synthesize secret = _secret;
@synthesize method = _method;
@synthesize timestamp = _timestamp;
@synthesize nonce = _nonce;	
@synthesize other = _other;	

- (id)initWithURL:(NSURL *)URL key:(NSString *)aKey secret:(NSString *)aSecret 
  signatureMethod:(NSString *)aMethod nonce:(NSString *)aNonce timestamp:(NSString *)aTimestamp other:(NSDictionary *)likeCallBack {
	if (self = [super initWithURL:URL]) {
//		self.url = URL;
		self.key = aKey;
		self.secret = aSecret;
		self.method = aMethod;
		self.nonce = aNonce;
		self.timestamp = aTimestamp;
		self.other = likeCallBack;
	}
	[self prepareOAuthHeader];
	return self;
}

- (void)prepareOAuthHeader {
	NSMutableDictionary *info = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								 self.key,@"oauth_consumer_key",
								 self.method,@"oauth_signature_method",
								 self.timestamp,@"oauth_timestamp",
								 self.nonce,@"oauth_nonce",
								 @"1.0",@"oauth_version",
								 nil];
	if (self.secret == nil) {
		self.secret = @"";
	}
	else {
		[info setValue:self.secret forKey:@"oauth_token"];
	}

	if (self.other) {
		[info addEntriesFromDictionary:self.other];
	}
	
//	NSArray *sortedkeys = [[info allKeys] sortedArrayUsingSelector:@selector(compare:)];
	NSMutableArray *temp = [NSMutableArray array];
	
	for (NSString *key_ in info) {
		[temp addObject:[NSString stringWithFormat:@"%@=%@",key_,[info objectForKey:key_]]];
	}
	
	NSString *param = [temp componentsJoinedByString:@"&"];
	RLog(@"header : %@",param);
	
	NSString *sign = [Signaturer signClearText:[NSString stringWithFormat:@"%@&%@&%@",@"GET",[self.URL description],param] 
									withSecret:[NSString stringWithFormat:@"%@&%@",self.key,self.secret]
					  ];
	RLog(@"sign : %@",sign);
	[info setValue:sign forKey:@"oauth_signature"];
	NSString *oauthHeader = [NSString stringWithFormat:@"oauth_consumer_key=%@&oauth_signature_method=%@&oauth_signature=%@&oauth_timestamp=%@&oauth_nonce=%@&oauth_version=1.0&oauth_callback=%@",
                             [NSString stringWithEscapeURIComponent:self.key] ,
                             //self.key,
                            [NSString stringWithEscapeURIComponent:self.method] ,
                            [NSString stringWithEscapeURIComponent:sign] ,
                            // sign,
							 self.timestamp,
                             self.nonce,
							 [NSString stringWithEscapeURIComponent:@"http://www.baidu.com"]];
	RLog(@"oauthHeader : %@",oauthHeader);
	
	NSString *newURL = [NSString stringWithFormat:@"%@?%@",REQUEST_TOKEN_STRING,oauthHeader];
	RLog(@"newURL : %@",newURL);

	[self setURL:[NSURL URLWithString:newURL]];
 //   [self setValue:oauthHeader forHTTPHeaderField:@"Authorization"];
}


- (void)dealloc {
//	self.url = nil;
	self.key = nil;
	self.secret = nil;
	self.method = nil;
	self.nonce = nil;
	self.timestamp = nil;
	self.other = nil;
	[super dealloc];
}

@end
