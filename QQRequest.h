//
//  QQRequest.h
//  WaQQ
//
//  Created by Ryan W. on 11-1-9.
//  Copyright 2011 Apple Inc. All rights reserved.
//

//

//http://open.t.qq.com/api/statuses/home_timeline?format=json&pageflag=0&reqnum=20&pagetime=0
//http://open.t.qq.com/api/statuses/mentions_timeline

#import <Cocoa/Cocoa.h>
#import "OADataFetcher.h"
#import "Key.h"

//@protocol QQRequestDelegate 
//
//- (void)
//
//@end


@interface QQRequest : NSObject {
	OAConsumer *consumer;
	OAHMAC_SHA1SignatureProvider	*hmacSha1Provider;
	OAToken *token;
}

@property (nonatomic,retain)OAToken *token;

- (void)requestHomeTimelinewithFormat:(NSString *)format pageflag:(NSInteger)pageflag itemCount:(NSInteger)count time:(NSInteger)time;

@end
