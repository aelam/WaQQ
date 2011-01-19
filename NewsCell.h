//
//  NewsCell.h
//  WaQQ
//
//  Created by Ryan W. on 11-1-11.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class News;

@interface NewsCell : NSTextFieldCell {
	NSImage		*_headImage;
	NSString	*_title;
	NSString	*_message;
	NSImage		*_image;
	News		*news;

}


@property (nonatomic, retain)  News		*news;
@property (nonatomic, retain)  NSImage	*headImage;
@property (nonatomic, retain)  NSString	*title;
@property (nonatomic, retain)  NSString	*message;
@property (nonatomic, retain)  NSImage	*image;

@end
