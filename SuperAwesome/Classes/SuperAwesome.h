//
//  SuperAwesome.h
//  Pods
//
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//
//  Created by Gabriel Coman on 28/09/2015.
//
//

#import <Foundation/Foundation.h>

// import model header files
#import "SAAd.h"
#import "SACreative.h"
#import "SADetails.h"

// import load
#import "SALoader.h"

// import views
#import "SABannerAd.h"
#import "SAInterstitialAd.h"
#import "SAVideoAd.h"
#import "SAFullscreenVideoAd.h"

// load protocols
#import "SALoaderProtocol.h"
#import "SAAdProtocol.h"
#import "SAVideoAdProtocol.h"

// @brief:
// This is the main SuperAwesome class that handles the Ad Session
// as a singleton (enable / disable test mode, configuration, version, etc)
@interface SuperAwesome : NSObject

// singleton instance (instead of init)
+ (SuperAwesome *)sharedManager;

// current SDK version
- (NSString*) version;

// set configuration - which determines what URL will call for ads
// @production: https://ads.superawesome.tv
// @staging: https://staging.beta.ads.superawesome.tv
// @development: https://dev.ads.superawesome.tv
- (void) setConfigurationProduction;
- (void) setConfigurationStaging;
- (void) setConfigurationDevelopment;
- (NSString*) getBaseURL;

// enable or disable test mode
- (void) enableTestMode;
- (void) disableTestMode;
- (BOOL) isTestingEnabled;

@end
