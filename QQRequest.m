//
//  QQRequest.m
//  WaQQ
//
//  Created by Ryan W. on 11-1-9.
//  Copyright 2011 Apple Inc. All rights reserved.
//

#import "QQRequest.h"
#import "RLog.h"
#import "JSON.h"

@implementation QQRequest

@synthesize token;
//@synthesize delegate;

- (void)dealloc {
	self.token = nil;
//	self.delegate = nil;
	[super dealloc];
}

- (id)init {
	if (self = [super init]) {
		consumer = [[OAConsumer alloc] initWithKey:API_KEY secret:API_SECRET];
		hmacSha1Provider = [[OAHMAC_SHA1SignatureProvider alloc] init];
#ifdef UNIT_TEST
		NSString *body = @"oauth_token=0468cd86ec32497fa21cd58af80695ad&oauth_token_secret=d4197ee3c036f4293abe72a768cd4dd0&name=lunwang";
#else
		NSString *body = [[NSUserDefaults standardUserDefaults] objectForKey:@"ACCESS_BODY"];
#endif
		//RLog(@"body %@",body);
		token = [[OAToken alloc] initWithHTTPResponseBody:body];
	}
	return self;
}
// TIMELINE 
/*
 Statuses/home_timeline 主页时间线
 
 获取用户收听的人+用户本人最新n条微博信息，与用户“我的主页”返回内容相同。
 
 URL
 http://open.t.qq.com/api/statuses/home_timeline
 格式 	HTTP请求方式 	是否需要鉴 	请求数限制
 xml,json 	GET 	true 	true
 
 关于请求数限制，参见接口访问权限说明
 参数			说明
 Format 	返回数据的格式 是（json或xml）
 Pageflag 	分页标识（0：第一页，1：向下翻页，2向上翻页）
 PageTime 	本页起始时间（第一页 0，继续：根据返回记录时间决定）
 Reqnum 	每次请求记录的条数（1-20条）
 
 使用说明
 http://open.t.qq.com/api/statuses/home_timeline?format=json&pageflag=0&reqnum=20&pagetime=0
 */
static NSString *homeTimeLineBase = @"http://open.t.qq.com/api/statuses/home_timeline";
static NSString *publicTimeLineBase = @"http://open.t.qq.com/api/statuses/public_timeline";
static NSString *userTimeLineBase = @"http://open.t.qq.com/api/statuses/user_timeline";
static NSString *mentionsTimeLineBase = @"http://open.t.qq.com/api/statuses/mentions_timeline";
static NSString *htTimeLineBase = @"http://open.t.qq.com/api/statuses/ht_timeline";
static NSString *broadcastTimeLineBase = @"http://open.t.qq.com/api/statuses/broadcast_timeline";

- (void)requestHomeTimelinewithFormat:(NSString *)format pageflag:(NSInteger)pageflag itemCount:(NSInteger)count time:(NSInteger)time {
	
	RLog();
	NSString *params = [NSString stringWithFormat:
							@"%@?format=%@&pageflag=%d&reqnum=%d&pagetime=%d",
							homeTimeLineBase,format,pageflag,count,time
						];
	NSURL *requestURL = [NSURL URLWithString:params];
	
	OAMutableURLRequest *hmacSha1Request = [[OAMutableURLRequest alloc] initWithURL:requestURL
												consumer:consumer
												token:token
												realm:NULL
												callback:NULL
												signatureProvider:hmacSha1Provider
											];
	
//	dispatch_queue_t *download_queue = dispatch_queue_create("Download Queu", NULL);
//	dispatch_async(download_queue, ^{
		OADataFetcher *fetcher = [[[OADataFetcher alloc] init] autorelease];
		[fetcher fetchDataWithRequest:hmacSha1Request 
							 delegate:self
					didFinishSelector:@selector(requestTokenTicket:finishedWithData:)
					  didFailSelector:@selector(requestTokenTicket:failedWithError:)
		 ];
//		
//	})	
}

- (void)requestTokenTicket:(OAServiceTicket *)ticket finishedWithData:(NSMutableData *)data {
//	NSString *responseBody = [[NSString alloc] initWithData:data
//												   encoding:NSUTF8StringEncoding];
	//RLog(@"responseBody:%@",responseBody);
	SBJsonParser *parser = [[SBJsonParser new] autorelease];
	id rs = [parser objectWithData:data];
	//RLog(@"responseBody : %@",rs);
	
//	if ([delegate respondsToSelector:@selector(responseWithNewsArray:)]) {
//		[delegate responseWithNewsArray:rs];
//	}
	
	
}

- (void)requestTokenTicket:(OAServiceTicket *)ticket failedWithError:(NSError *)error {
	RLog(@"%@",error);
	//	[self hideWebPage];
	// then show alertview
}


/*
 Statuses/public_timeline 广播大厅时间线
 
 获取最新n条公共微博信息，与“广播大厅—全部广播”返回内容相同。
 
 URL
 http://open.t.qq.com/api/statuses/public_timeline
 格式 	HTTP请求方式 	是否需要鉴 	请求数限制
 xml,json 	GET 	true 	true
 
 关于请求数限制，参见接口访问权限说明
 参数 	说明
 Format 	返回数据的格式 是（json或xml）
 Pos 	记录的起始位置（第一次请求是填0，继续请求进填上次返回的Pos）
 Reqnum 	每次请求记录的条数（1-20条）
 
 使用说明：
 http://open.t.qq.com/api/statuses/public_timeline?format=json&pos=0&reqnum=20
 
 */

/*Statuses/user_timeline 其他用户发表时间线
 
 获取用户收听的人最新n条微博信息。
 格式 	HTTP请求方式 	是否需要鉴 	请求数限制
 xml,json 	GET 	true 	true
 
 关于请求数限制，参见接口访问权限说明
 参数 	说明
 Format 	返回数据的格式 是（json或xml）
 Pageflag 	分页标识（0：第一页，1：向下翻页，2向上翻页）
 PageTime 	本页起始时间（第一页 0，继续：根据返回记录时间决定）
 Reqnum 	每次请求记录的条数（1-20条）
 Name 	用户名
 
 使用说明
 http://open.t.qq.com/api/statuses/user_timeline?format=json&pageflag=0&reqnum=20&pagetime=0 
 */

/*
 Statuses/mentions_timeline 用户提及时间线
 
 获取最新n条@提到我的微博。
 
 URL
 http://open.t.qq.com/api/statuses/mentions_timeline
 格式 	HTTP请求方式 	是否需要鉴 	请求数限制
 xml,json 	GET 	true 	true
 
 关于请求数限制，参见接口访问权限说明
 参数 	说明
 Format 	返回数据的格式 是（json或xml）
 Pageflag 	分页标识（0：第一页，1：向下翻页，2向上翻页）
 PageTime 	本页起始时间（第一页 0，继续：根据返回记录时间决定）
 Reqnum 	每次请求记录的条数（1-20条）
 Lastid 	当前页最后一条记录，用用精确翻页用
 
 使用说明
 http://open.t.qq.com/api/statuses/mentions_timeline?format=json&pageflag=0&reqnum=20&pagetime=0
 */

/*
 Statuses/ht_timeline 话题时间线
 
 获取某个话题有关的最新n条微博。
 
 URL
 http://open.t.qq.com/api/statuses/mentions_timeline
 格式 	HTTP请求方式 	是否需要鉴 	请求数限制
 xml,json 	GET 	true 	true
 
 关于请求数限制，参见接口访问权限说明
 请求参数 	说明
 Format 	返回数据的格式 是（json或xml）
 Httext 	话题名字
 Pageflag 	分页标识（PageFlag = 1表示向后（下一页）查找；
 PageFlag = 2表示向前（上一页）查找；
 PageFlag = 3表示跳到最后一页
 PageFlag = 4表示跳到最前一页）
 pageinfo 	分页标识（第一页 填空，继续翻页：根据返回的 pageinfo决定）
 Reqnum 	每次请求记录的条数（1-20条）
 
 使用说明
 http://open.t.qq.com/api/statuses/ht_timeline?format=json&pageflag=1&reqnum=20&pageinfo=
 
 */

/*
 Statuses/broadcast_timeline 我发表时间线
 
 获取用户本人发表的最新n条微博。
 
 URL
 http://open.t.qq.com/api/statuses/broadcast_timeline
 格式 	HTTP请求方式 	是否需要鉴 	请求数限制
 xml,json 	GET 	true 	true
 
 关于请求数限制，参见接口访问权限说明
 请求参数 	说明
 Format 	返回数据的格式 是（json或xml）
 Pageflag 	分页标识（0：第一页，1：向下翻页，2向上翻页）
 PageTime 	本页起始时间（第一页 0，继续：根据返回记录时间决定）
 Reqnum 	每次请求记录的条数（1-20条）
 Name 	用户名
 
 使用说明
 http://open.t.qq.com/api/statuses/broadcast_timeline?format=json&pageflag=0&reqnum=20&pagetime=0 
 */
//----------------------------------------------------------------------------
/**/
/**/
@end
