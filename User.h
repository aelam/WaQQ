//
//  User.h
//  WaQQ
//
//  Created by Ryan W. on 11-1-10.
//  Copyright 2011 Apple Inc. All rights reserved.
//

/*	
 name: 用户帐户名
 nick: 用户昵称
 uid: 用户id(目前为空)
 head: 头像URL
 location: 所在地
 Isvip: 是否认证用户
 isent: 是否企业机构
 introduction: 个人介绍
 verifyinfo: 认证信息
 birth_year: 出生年
 birth_month:出生月
 birth_day:出生天 
 country_code: 国家ID,
 province_code: 地区ID,
 city_code: 城市ID,
 sex:用户性别 1男 2 女 0未知
 fansnum:听众数
 idolnum:收听的人数
 tweetnum:发表的微博数
 tag:
 id:个人标签ID
 name:标签名
 */

#import <Cocoa/Cocoa.h>


@interface User : NSObject {
	NSString	*headURL;
	NSImage		*headImage;
	NSString	*uid;
	NSString	*nick;
	NSString	*name;
	NSString	*location;

	BOOL		isVIP;
	BOOL		isent;		//	是否企业用户
	
	BOOL		isMyBlack;	//	黑名单
	BOOL		isMyFan;
	BOOL		isMyIdiol;
	
	NSString	*introduction;
	
	NSString	*verifyInfo;
	NSString	*birthYear;
	NSString	*birthMonth;
	NSString	*birthDay;
	
	NSInteger	countryCode;
	NSInteger	provinceCode;
	NSInteger	cityCode;
	
	NSInteger	sex;	//用户性别 1男 2 女 0未知
	
	NSInteger	fansNum;
	NSInteger	idolNum;
	NSInteger	tweetNum;
	
	NSMutableDictionary *tags;
}

@property (copy)	NSString	*headURL;
@property (retain)	NSImage		*headImage;
@property (copy)	NSString	*uid;
@property (copy)	NSString	*nick;
@property (copy)	NSString	*name;
@property (copy)	NSString	*location;

@property			BOOL		isVIP;
@property			BOOL		isent;		//	是否企业用户

@property			BOOL		isMyBlack;	//	黑名单
@property			BOOL		isMyFan;
@property			BOOL		isMyIdiol;

@property (copy)	NSString	*introduction;

@property (copy)	NSString	*verifyInfo;
@property (copy)	NSString	*birthYear;
@property (copy)	NSString	*birthMonth;
@property (copy)	NSString	*birthDay;

@property			NSInteger	countryCode;
@property			NSInteger	provinceCode;
@property			NSInteger	cityCode;

@property			NSInteger	sex;	//用户性别 1男 2 女 0未知

@property			NSInteger	fansNum;
@property			NSInteger	idolNum;
@property			NSInteger	tweetNum;

@property (retain)	NSMutableDictionary *tags;

@end
