//
//  LOAuthRequest.h
//  WaQQ
//
//  Created by Ryan W. on 11-1-8.
//  Copyright 2011 Apple Inc. All rights reserved.
//

//#import <Cocoa/Cocoa.h>

@interface LOAuthRequest : NSMutableURLRequest {
@private
//	NSURL	*_url;
	NSString *_key;
	NSString *_secret;
	NSString *_method;
	NSString *_timestamp;
	NSString *_nonce;	
	NSDictionary *_other;
}

//@property (nonatomic,retain) NSURL	*url;
@property (nonatomic,copy) NSString *key;
@property (nonatomic,copy) NSString *secret;
@property (nonatomic,copy) NSString *method;
@property (nonatomic,copy) NSString *timestamp;
@property (nonatomic,copy) NSString *nonce;	
@property (nonatomic,copy) NSDictionary *other;	

- (id)initWithURL:(NSURL *)URL key:(NSString *)aKey secret:(NSString *)aSecret 
  signatureMethod:(NSString *)aMethod nonce:(NSString *)aNonce timestamp:(NSString *)aTimestamp other:(NSDictionary *)likeCallBack;

@end
