//
//  News.h
//  WaQQ
//
//  Created by Ryan W. on 11-1-10.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class User;

@interface News : NSObject {
	NSString	*text;
	NSString	*origText;
	NSString	*from;
	NSString	*imageURL;
	BOOL		*isSentBySelf;
	User		*sender;
	NSInteger	*newsType;	// type:微博类型 1-原创发表、2-转载、3-私信 4-回复 5-空回 6-提及
	NSInteger	newsId;
	NSInteger	count;		// 转发次数
}

@property (copy) NSString	*text;
@property (copy) NSString	*origText;
@property (copy) NSString	*from;
@property (copy) NSString	*imageURL;
@property (retain) User		*sender;
@property	BOOL			*isSentBySelf;
@property	NSInteger		*newsType;	// type:微博类型 1-原创发表、2-转载、3-私信 4-回复 5-空回 6-提及
@property	NSInteger		newsId;
@property	NSInteger		count;			// 转发次数

@end
