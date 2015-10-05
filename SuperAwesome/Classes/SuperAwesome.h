//
//  SuperAwesome2.h
//  Pods
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

#import <Foundation/Foundation.h>
#import "SKLogger.h"

// import all header files
#import "SAAd.h"
#import "SACreative.h"
#import "SAImageDetials.h"
#import "SAVideoDetails.h"
#import "SAValueDetails.h"
#import "SAEvent.h"
#import "SANetwork.h"
#import "SANetwork+Ad.h"

// import views
#import "SAAdView.h"
#import "SABannerView.h"
#import "SAInterstitialView.h"
#import "SAVideoView.h"

// typedef client configuration
typedef NS_ENUM(NSUInteger, SAConfiguration) {
    SAConfigurationDevelopment,
    SAConfigurationStaging,
    SAConfigurationProduction
};

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
