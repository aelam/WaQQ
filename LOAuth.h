//
//  LOAuth.h
//  iPhone Doudou
//
//  Created by Ryan W. on 11-1-4.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OADataFetcher.h"
#import "Key.h"

@protocol LOAuthDelegate;

@interface LOAuth : NSObject {
	
	OAConsumer						*consumer;
	OAMutableURLRequest				*hmacSha1Request;//请求授权
	OAMutableURLRequest				*hmacSha1Request1;//请求access
	OAToken							*token;
	OAHMAC_SHA1SignatureProvider	*hmacSha1Provider;
	id<LOAuthDelegate>				delegate;

}

@property (nonatomic, retain) OAConsumer *consumer;
@property (nonatomic, retain) OAMutableURLRequest *hmacSha1Request;
@property (nonatomic, retain) OAMutableURLRequest *hmacSha1Request1;
@property (nonatomic, retain) OAToken *token;
@property (nonatomic, retain) OAHMAC_SHA1SignatureProvider *hmacSha1Provider;
@property (nonatomic, assign) id<LOAuthDelegate> delegate;

- (id)initWithDelegate:(id<LOAuthDelegate>)d;
- (void)startRequestToken;
- (void)startAccessOauthWithVerifier:(NSString *)verifier;

// LISTEN OUR URL SCHEMA 
- (void)handleEvent:(NSAppleEventDescriptor *)event withReplyEvent:(NSAppleEventDescriptor *)replyEvent;

@end


@protocol LOAuthDelegate<NSObject>

- (void)hide;
- (void)oauthDidFinish:(id)token;

@end


