//
//  QQTimeLineRequest.h
//  WaQQ
//
//  Created by Ryan W. on 11-1-19.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "QQRequest.h"

@protocol QQTimeLineRequest <NSObject>

- (void)responseWithNewsArray:(NSArray *)array;

@end

@interface QQTimeLineRequest : QQRequest {

	id <QQTimeLineRequest> _delegate;
}

@property (nonatomic, retain)  id <QQTimeLineRequest> delegate;

@end
