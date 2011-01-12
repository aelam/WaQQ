#import <GHUnit/GHUnit.h>
//#import "LOAuth.h"
#import "QUserInfoRequest.h"

@interface OAuthTest : GHTestCase {
	//LOAuth *oauth;
	
	//QUserInfoRequest *request;
}
@end

@implementation OAuthTest

- (void)setUpClass {
	// Run at start of all tests in the class
}

- (void)tearDownClass {
	// Run at end of all tests in the class
}

- (void)setUp {
	// Run before each test method
	//oauth = [[LOAuth alloc] initWithDelegate:self];
//	request = [[QUserInfoRequest alloc] init];
//	GHAssertTrue(request,@"QUserInfoRequest initialize success");
}

- (void)tearDown {
	// Run after each test method
//	[request release];
//	GHAssertNil
}

- (void)testRequestMyProfile {	
	QUserInfoRequest *request = [[[QUserInfoRequest alloc] init] autorelease];
	[request requestMyProfileWithFormat:@"json"];
}

- (void)testRequestOthersProfile {	
	QUserInfoRequest *request = [[[QUserInfoRequest alloc] init] autorelease];
	[request requestUserProfileWithName:@"danniel" format:@"json"];
}




//- (void)testOK {
//	//GHAssertTrue(YES, nil);
//	//[oauth startRequestToken];
//
//}
//
//- (void)testFail {
//	GHAssertTrue(NO, nil);
//}

@end
