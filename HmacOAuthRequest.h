//
//  HmacOAuthRequest.h
//  WaQQ
//
//  Created by Ryan W. on 11-1-9.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface HmacOAuthRequest : NSMutableURLRequest {
@private
	NSString *_key;
	NSString *_token;
	NSString *_timestamp;
	NSString *_nonce;	
	NSDictionary *_otherParams;
}

@property (nonatomic,copy) NSString *key;
@property (nonatomic,copy) NSString *token;
@property (nonatomic,copy) NSString *signatureMethod;
//@property (nonatomic,copy) NSString *httpMethod;
@property (nonatomic,copy) NSString *timestamp;
@property (nonatomic,copy) NSString *nonce;	
@property (nonatomic,copy) NSDictionary *otherParams;	

- (id)initWithURL:(NSURL *)URL key:(NSString *)aKey token:(NSString *)aSecret 
	   httpMethod:(NSString *)aHttpMethod otherParams:(NSDictionary *)likeCallBack;

@end
