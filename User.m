//
// User.m
// WaQQ
//
// Created by Ryan W. on 11-1-10.
// Copyright 2011 Apple Inc. All rights reserved.
//

#import "User.h"


@implementation User

@synthesize headURL,headImage,uid,nick,name,location,isVIP,isent,isMyBlack,isMyFan,isMyIdiol,introduction;
@synthesize verifyInfo,birthYear,birthMonth,birthDay,countryCode,provinceCode,cityCode,sex,fansNum,idolNum,tweetNum,tags;



//- (NSString *)description {
//	NSString *rs = [NSString stringWithFormat:@"\nHeadURL: %@ \n uid : %@ nick : %@, name:%@, location : %@ , isVip: %d"]
//}

- (void)dealloc {
	[headURL release];
	[headImage release];
	[uid release];
	[nick release];
	[name release];
	[location release];
	
	[introduction release];
	[verifyInfo release];
	[birthYear release];
	[birthMonth release];
	[birthDay release];
	[countryCode release];
	[provinceCode release];
	[cityCode release];
	[tags release];
	
	[super dealloc];
}

@end
