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

@protocol QQRequestDelegate <NSObject>

- (void)responseWithNewsArray:(NSArray *)array;

@end


@interface QQRequest : NSObject {
	OAConsumer *consumer;
	OAHMAC_SHA1SignatureProvider	*hmacSha1Provider;
	OAToken *token;
	
	//id <QQRequestDelegate> delegate;
}

@property (nonatomic,retain)OAToken *token;
@property (nonatomic,assign)id <QQRequestDelegate> delegate;

- (void)requestHomeTimelinewithFormat:(NSString *)format pageflag:(NSInteger)pageflag itemCount:(NSInteger)count time:(NSInteger)time;

@end
