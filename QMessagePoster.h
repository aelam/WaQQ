//
//  QMessagePoster.h
//  WaQQ
//
//  Created by Ryan W. on 11-1-12.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "QQRequest.h"

@interface QMessagePoster : QQRequest {

}

- (void)postMessage:(NSString *)content format:(NSString *)format clientIP:(NSString *)ip 
		  longitude:(NSString *)longitude latitude:(NSString *)latitude;

@end
