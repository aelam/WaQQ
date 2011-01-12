//
//  QMessagePoster.m
//  WaQQ
//
//  Created by Ryan W. on 11-1-12.
//  Copyright 2011 Apple Inc. All rights reserved.
//

/*
 t/add 发表一条微博
 
 URL
 http://open.t.qq.com/api/t/add
 格式 	http请求方式 	是否需要鉴权 	请求数限制
 xml,json 	post 	true 	true
 
 关于请求数限制，参见接口访问权限说明
 请求参数 	说明
 format 	返回数据的格式 是（json或xml）
 content 	微博内容
 clientip 	用户ip(以分析用户所在地)
 jing 	经度（可以填空）
 wei 	纬度（可以填空）
 
 使用说明
 http://open.t.qq.com/api/t/add
 
 post包体格式：
 format=json&content=xxxx&clientip=127.0.0.1&jing=110.5&wei=23.4 
 
 */

#import "QMessagePoster.h"
#import "OAAsynchronousDataFetcher.h"

static NSString *postMessageBase = @"http://open.t.qq.com/api/t/add";

@implementation QMessagePoster

- (void)postMessage:(NSString *)content format:(NSString *)format clientIP:(NSString *)ip 
		  longitude:(NSString *)longitude latitude:(NSString *)latitude {
	
	NSString *body = [NSString stringWithFormat:
					  @"format=%@&content=%@&clientip=%@&jing=%@&wei=%@",
					  format,content,ip,longitude,latitude
					];	
	OAMutableURLRequest *hmacSha1Request = [[[OAMutableURLRequest alloc] initWithURL:[NSURL URLWithString:postMessageBase]
																			consumer:consumer
																			   token:self.token
																			   realm:NULL
																			callback:NULL
																   signatureProvider:hmacSha1Provider
											 ] autorelease];
	[hmacSha1Request setHTTPMethod:@"POST"];
	NSData *bodyData = [body dataUsingEncoding:NSUTF8StringEncoding];
	[hmacSha1Request setHTTPBody:bodyData];
	
	OAAsynchronousDataFetcher *fetcher = [[[OAAsynchronousDataFetcher alloc]
										   initWithRequest:hmacSha1Request
										   delegate:self
										   didFinishSelector:@selector(requestTokenTicket:finishedWithData:) 
										   didFailSelector:@selector(requestTokenTicket:failedWithError:)
										   ] autorelease];
	[fetcher start];
	
}


- (void)requestTokenTicket:(OAServiceTicket *)ticket finishedWithData:(NSMutableData *)data {
	NSString *responseBody = [[NSString alloc] initWithData:data
												   encoding:NSUTF8StringEncoding];
	RLog(@"responseBody:%@",responseBody);	
}

- (void)requestTokenTicket:(OAServiceTicket *)ticket failedWithError:(NSError *)error {
	NSLog(@"%@",error);
}


@end
