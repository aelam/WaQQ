//
//  QUserInfoRequest.h
//  WaQQ
//
//  Created by Ryan W. on 11-1-11.
//  Copyright 2011 Apple Inc. All rights reserved.
//
#import "QQRequest.h"
#import "OAAsynchronousDataFetcher.h"
#import "User.h"

@protocol QUserInfoRequestDelegate<NSObject>

@optional
- (void)requestUserInfoStatus:(BOOL)status user:(User *)aUser;
- (void)requestUserInfoStatus:(BOOL)status userDic:(NSDictionary *)aUserDic;

@end


@interface QUserInfoRequest : QQRequest {
	id<QUserInfoRequestDelegate> delegate;
}

@property (assign) id<QUserInfoRequestDelegate> delegate;


- (void)requestMyProfileWithFormat:(NSString *)format;
- (void)requestUserProfileWithName:(NSString *)name format:(NSString *)format;

@end
