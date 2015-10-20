//
//  SuperAwesome2.h
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

#import <Foundation/Foundation.h>

// import model header files
#import "SAAd.h"
#import "SACreative.h"
#import "SADetails.h"

// import views
#import "SALoader.h"
#import "SALoaderProtocol.h"
#import "SABannerAd.h"
#import "SAInterstitialAd.h"
#import "SAVideoAd.h"

// interface declaration
@interface SuperAwesome : NSObject

// singleton instance (instead of init)
+ (SuperAwesome *)sharedManager;

// other functions
- (NSString*) version;

// set configuration
- (void) setConfigurationProduction;
- (void) setConfigurationStaging;
- (void) setConfigurationDevelopment;
- (NSString*) getBaseURL;

// test mode
- (void) enableTestMode;
- (void) disableTestMode;
- (BOOL) isTestingEnabled;

@end
