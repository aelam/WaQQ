//
//	RLog.h	
//	
//  Created by Ryan W. on 10-12-29.
//  Copyright 2010 YuxiPacific All rights reserved.
//


#define _R_Log(fmt,...) NSLog(fmt,__LINE__,__FUNCTION__,##__VA_ARGS__) 

#ifdef DEBUG 
	#define RTrace(fmt,...) _R_Log(@"[LINE:%d] %s " fmt,##__VA_ARGS__)
#else
	#define RTrace(fmt,...)
#endif

#define RLog(fmt,...) _R_Log(@"[LINE:%d] %s " fmt,##__VA_ARGS__)
