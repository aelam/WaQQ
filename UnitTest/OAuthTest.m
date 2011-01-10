#import <GHUnit/GHUnit.h>
#import "LOAuth.h"

@interface OAuthTest : GHTestCase {
	LOAuth *oauth;
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
}

- (void)tearDown {
	// Run after each test method
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
